# 文本翻译、ASR 与 TTS 云服务免费额度

最后核对：2026-09-20。

本文对比公有云 API 的文本翻译、自动语音识别（ASR / Speech-to-Text）和
语音合成（TTS / Text-to-Speech）免费额度。额度、适用模型、地域和新用户资格
经常调整，接入前请再次查看链接中的官方定价页和控制台实际显示。

## 快速对比

| 云服务商 | 文本翻译 | ASR | TTS | 额度类型 |
| --- | --- | --- | --- | --- |
| Google Cloud | 每月前 50 万字符，NMT Basic 与 Advanced 合并计算；以每月 USD 10 赠金抵扣，不适用于 Translation LLM | 每月 60 分钟；以官方免费层列出的 V1 / 指定 SKU 为准 | Standard 每月 400 万字符；WaveNet、Neural2、Polyglot、Chirp 3 HD、Studio 各每月 100 万字符 | 持续月度免费层；须启用结算，超额自动计费 |
| Microsoft Azure | Translator F0 每月 200 万字符，标准翻译与自定义翻译训练合并计算 | Speech F0：标准实时转写 5 音频小时/月，自定义实时转写另有 5 音频小时/月 | Speech F0：Neural 50 万字符/月 | F0 月度免费层；免费层吞吐限制不可调高 |
| AWS | Amazon Translate 标准文本/批量文档翻译每月 200 万字符 | Amazon Transcribe 每月 60 分钟 | Amazon Polly：Standard 500 万、Neural 100 万、Long-Form 50 万、Generative 10 万字符/月 | 前 12 个月；从对应服务首次请求起算，未用额度不结转 |
| 阿里云 | 机器翻译通用版和专业版各每月 100 万字符；主账号与子账号共享 | 智能语音交互新用户试用 3 个月，最多 2 路并发；录音文件识别每天 2 小时 | 普通语音合成新用户试用 3 个月，最多 2 路并发 | 翻译为月度免费量；语音为限时试用 |
| 腾讯云 | 每月 500 万字符 | 录音文件识别 10 小时/月；实时、极速版、语音流异步识别各 5 小时/月；一句话识别 5,000 次/月 | 通用语音合成一次性 800 万字符 | 翻译和 ASR 按月；TTS 领取后 3 个月有效且每账号一次 |
| 百度智能云 | 通用版个人认证一次性 500 万字符，企业认证一次性 1,000 万字符 | 普通话短语音个人 5 万次/企业 10 万次；实时普通话、实时英语和文件转写各 10 小时 | 短文本基础/精品音库个人 5 万次、企业 10 万次；长文本和流式合成个人 5 万、企业 10 万字符 | 完成认证后发放的一次性测试资源，长期有效 |

## 官方依据与限制

### Google Cloud

- [Cloud Translation 定价](https://cloud.google.com/translate/pricing)：NMT 文本翻译和语言检测合计前 50 万字符/月免费；字符按发送给 API 的源文本计算。批量翻译到多个目标语言时会分别计量。
- [Speech-to-Text 免费层](https://cloud.google.com/free/docs/free-cloud-features)和 [V1 请求说明](https://cloud.google.com/speech-to-text/docs/v1/speech-to-text-requests)：每账号每月 60 分钟。不同 API 版本、识别模型和增强功能不一定适用。
- [Text-to-Speech 定价](https://cloud.google.com/text-to-speech/pricing)：按提交字符数计量，空格和大部分 SSML 标签也计入。必须关联有效结算账号，超过免费量后会自动收费。

### Microsoft Azure

- [Azure Translator 定价](https://azure.microsoft.com/pricing/details/translator/)：需要创建 `F0` 资源；200 万字符是标准翻译和自定义翻译训练的共享月度额度。
- [Azure Speech 定价](https://azure.microsoft.com/pricing/details/speech/)：Speech-to-Text 按音频秒数计量，TTS 按字符计量；表中只列当前 F0 的实时标准能力。
- [Speech 配额与限制](https://learn.microsoft.com/azure/ai-services/speech-service/speech-services-quotas-and-limits)：F0 实时 ASR 默认仅 1 个并发请求，TTS 为每 60 秒 20 次事务，且 F0 限制不能申请调高。批量转写和批量合成不属于表中的免费实时额度。

### AWS

- [Amazon Translate 定价](https://aws.amazon.com/translate/pricing/)：标准文本翻译和批量文档翻译共享每月 200 万字符的 12 个月免费层；实时 DOCX 文档翻译不适用。
- [Amazon Transcribe 定价](https://aws.amazon.com/transcribe/pricing/)：流式与批量标准转写合计每月 60 分钟，持续 12 个月；内容脱敏、自定义语言模型等附加能力不适用。
- [Amazon Polly 定价](https://aws.amazon.com/polly/pricing/)：不同音色引擎分别计量；生成 Speech Marks 也会消耗字符。AWS 在 2025 年调整了新账号免费计划和赠金，最终资格应以账号控制台为准。

### 阿里云

- [机器翻译产品定价](https://help.aliyun.com/zh/machine-translation/product-overview/pricing-of-machine-translation)：免费字符用完后按“资源包、后付费”顺序继续扣费；标点、空格和 HTML 标签均计入源文本字符数。
- [智能语音交互计费项](https://help.aliyun.com/zh/isi/product-overview/pricing)和[试用说明](https://help.aliyun.com/zh/isi/getting-started/user-guide-for-non-developers)：一句话识别、实时识别、普通录音文件识别和普通语音合成支持 3 个月试用。长文本 TTS、CosyVoice 流式 TTS、录音文件识别闲时版/极速版等仅支持商用。
- 试用版升级为商用版后不能恢复原试用权益；商用版会按量计费。需要 API 接入时还应确认目标服务，而不是只看控制台演示工具的每日额度。

### 腾讯云

- [机器翻译计费概述](https://cloud.tencent.com/document/product/551/35017)：文本翻译免费资源包按月发放；后付费默认关闭，免费量与预付费资源包耗尽后是否停服取决于后付费开关。
- [语音识别计费概述](https://cloud.tencent.com/document/product/1093/35686)：免费包仅当月有效；表中小时数和次数只统计识别成功的音频或请求。
- [语音合成购买方式](https://cloud.tencent.com/document/product/1073/78325)：800 万字符包需在控制台领取，仅用于通用语音合成，不支持长文本合成；到期或耗尽后，如未关闭后付费，可能自动产生费用。

### 百度智能云

- [机器翻译计费概述](https://cloud.baidu.com/doc/MT/s/ml779m8vi)：未认证账号没有免费测试量；免费测试资源在完成认证、首次进入控制台后发放，且每个认证主体只发放一次。
- [语音技术免费测试资源](https://cloud.baidu.com/doc/SPEECH/s/Wl9mh4doe)：各语种、音库和接口分别计量。表中列的是常用普通话/英语 ASR 与基础、精品 TTS；臻品音库等额度更低。
- 百度免费测试资源未用完时，即使开通付费也会先抵扣免费资源；之后依次抵扣预付费资源包和按量后付费。并发数会随个人或企业认证状态而不同。

## 使用前检查

- 区分“免费用量”和 QPS、并发、单次文件时长等技术配额；后者不代表免费。
- 确认额度是每月重置、限时试用还是一次性资源包，并记录起算时间和时区。
- 检查目标地域、API 版本、模型/音色、实时或批量模式是否在免费范围内。
- 默认关闭后付费或开启“用完即停”，同时配置预算和账单告警。
- ASR 还可能产生对象存储和网络费用；翻译到多个目标语言可能按目标语言倍增；TTS 的空格、标点和 SSML 也可能计费。
- 中国大陆服务通常要求实名认证；企业认证与个人认证的免费量、并发和商用授权可能不同。
