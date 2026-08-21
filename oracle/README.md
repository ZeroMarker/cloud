# Oracle Cloud Infrastructure 运维笔记

最后核对：2026-08-21；OCI CLI 3.90.2。

本目录保存 Oracle Cloud Infrastructure（OCI）的常用命令、部署配置模板、
PAYG 免费额度和费用检查方法。完整命令索引见 [oci.sh](oci.sh)。该文件是命令
参考，不应从头到尾整段执行。

## 部署配置模板

| 项目 | 当前值 |
| --- | --- |
| Home Region | `<home-region>` |
| 实例 | `<instance-name>` |
| 状态 | `<lifecycle-state>` |
| Shape | `<shape>` |
| 配置 | `<ocpus>` OCPU、`<memory-gb>` GB RAM |
| 启动盘 | `<boot-volume-gb>` GB、`<vpus-per-gb>` VPUs/GB |
| 当月累计费用 | `<amount> <currency>`（以 Usage API 查询结果为准） |

## PAYG 免费额度

PAYG 账户仍保留免费用量。Ampere A1 按每月累计小时计量：

- 前 3,000 OCPU-hours/月免费；
- 前 18,000 GB-hours/月免费；
- 4 OCPU × 744 小时 = 2,976 OCPU-hours；
- 24 GB × 744 小时 = 17,856 GB-hours。

因此，`VM.Standard.A1.Flex` 的 4 OCPU、24 GB 内存可以在 31 天月份持续运行，
仍处于 PAYG 免费用量内。此结论只覆盖 A1 CPU 和内存；存储、备份、IP、负载
均衡器、其他 Shape 和其他服务应分别检查。

不要把 PAYG 服务限额当成免费额度。租户可能允许创建 16 OCPU、96 GB RAM，
但超过上述月度小时额度的部分会计费。

Oracle 当前 Always Free 文档对纯免费租户显示 A1 为 2 OCPU、12 GB；PAYG 的
免费计量应以 Oracle 全球价目表中的 3,000 OCPU-hours 和 18,000 GB-hours 为准。

## 快速检查实例

```powershell
$compartmentId = "<compartment-ocid>"

oci compute instance list `
  --compartment-id $compartmentId `
  --all `
  --query 'data[].{Name:"display-name",State:"lifecycle-state",Shape:shape,OCPU:"shape-config".ocpus,RAM_GB:"shape-config"."memory-in-gbs"}' `
  --output table
```

单台 A1 调整为 4 OCPU、24 GB 会触发重启：

```powershell
oci compute instance update `
  --instance-id "<instance-ocid>" `
  --shape-config '{"ocpus":4,"memoryInGBs":24}' `
  --force
```

调整后确认：

```powershell
oci compute instance get `
  --instance-id "<instance-ocid>" `
  --query 'data.{Name:"display-name",State:"lifecycle-state",Shape:shape,OCPU:"shape-config".ocpus,RAM_GB:"shape-config"."memory-in-gbs"}' `
  --output table
```

## 查询当月费用

Usage API 的部分月份查询应使用 `DAILY`；`MONTHLY` 要求起止时间都是每月第一
天。`request-summarized-usages` 不支持 `--all`，使用 `--limit` 控制返回数量。

```powershell
$tenantId = oci iam availability-domain list `
  --query 'data[0]."compartment-id"' `
  --raw-output

oci usage-api usage-summary request-summarized-usages `
  --tenant-id $tenantId `
  --time-usage-started "<month-start-utc>" `
  --time-usage-ended "<end-utc>" `
  --granularity DAILY `
  --query-type COST `
  --group-by '["service"]' `
  --is-aggregate-by-time true `
  --limit 500
```

查询结果中的 `computedAmount` 是费用，`currency` 是结算币种。Usage 数据可能
延迟入账，结束时间是 exclusive，不包含该时间点。

查询成本需要相应的 Usage/Cost Analysis IAM 权限。若出现连接超时，检查
`HTTP_PROXY`、`HTTPS_PROXY` 和 `ALL_PROXY`；本机曾出现普通 OCI API 可用、
但代理无法与 `usageapi.<region>.oci.oraclecloud.com` 完成 TLS 握手的情况。

## 费用安全检查

- A1 CPU/内存累计不超过 3,000 OCPU-hours 和 18,000 GB-hours/月；
- 启动盘与块存储合计不超过 200 GB；
- 卷性能保持 Balanced（10 VPUs/GB）；
- Always Free Compute 和存储放在 Home Region；
- 检查是否存在额外实例、保留公网 IP、备份、负载均衡器或付费镜像；
- PAYG 超额后会自动计费，预算告警通常不会自动停止资源。

## 官方资料

- [Always Free Resources](https://docs.oracle.com/en-us/iaas/Content/FreeTier/freetier_topic-Always_Free_Resources.htm)
- [OCI Free Tier](https://docs.oracle.com/en-us/iaas/Content/FreeTier/freetier.htm)
- [OCI CLI Usage API](https://docs.oracle.com/en-us/iaas/tools/oci-cli/latest/oci_cli_docs/cmdref/usage-api/usage-summary/request-summarized-usages.html)
- [Cost Analysis](https://docs.oracle.com/en-us/iaas/Content/Billing/Concepts/costanalysisoverview.htm)
- [Oracle PaaS and IaaS Global Price List](https://www.oracle.com/uy/a/ocom/docs/corporate/pricing/oracle-paas-and-iaas-global-price-list.pdf)
