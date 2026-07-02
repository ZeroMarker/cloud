# Pricing and Free Tier Notes

Last checked: 2026-06-23.

Pricing changes often by region, currency, tax, image, bandwidth, IPv4, support plan, and promotion eligibility. Use this file as a quick shortlist, then confirm on the official pricing page before buying.

## Quick Picks

| Need | Good starting point | Notes |
| --- | --- | --- |
| Long-running free VM experiments | Oracle Cloud, Google Cloud, Azure | Check exact eligible shapes and regions. Free tiers are quota-limited. |
| Most generous new-user trial credit | Google Cloud, Oracle Cloud, Azure, IBM Cloud | Usually time-limited credits; resources may stop or bill after expiry. |
| Cheap simple VPS | Contabo, Hetzner, IONOS, Vultr, DigitalOcean, Akamai/Linode | Watch bandwidth, backup, IPv4, snapshot, and support costs. |
| US network and managed help | Hostwinds | Hourly cloud pricing; no clear public always-free tier found. |
| Flexible resize / short testing | Kamatera, IONOS Cloud, Vultr, DigitalOcean | Prefer hourly billing and easy upgrade/downgrade. |

## Free Credits and Free Tiers

| Provider | Free / trial offer | Price-plan notes | Official link |
| --- | --- | --- | --- |
| AWS | New Free Tier accounts advertise up to USD 200 credits over 6 months; AWS also has always-free, 12-month, and short trial offers. | For simple VPS pricing, Lightsail bundles are easier to predict than raw EC2. | https://aws.amazon.com/free/ |
| Azure | USD 200 credit for up to 30 days, plus 12-month free services and always-free monthly service amounts. | Pay-as-you-go after upgrade; VM free eligibility is shape-specific. | https://azure.microsoft.com/en-us/pricing/purchase-options/azure-account |
| Google Cloud | USD 300 credit for 90 days, plus 20+ always-free products up to monthly limits. | Compute Engine has an always-free e2-micro allowance in eligible regions. | https://cloud.google.com/free |
| Oracle Cloud | USD 300 credit for 30 days, plus Always Free services. | Always Free compute includes limited AMD micro instances and Arm Ampere A1 monthly quota. | https://www.oracle.com/cloud/free/ |
| Alibaba Cloud | Free-trial page advertises USD 90 credits valid for 3 months and 80+ tools, with some offers up to 12 months free. | Promotions vary by account type and region. | https://www.alibabacloud.com/en/free |
| Tencent Cloud | Free Tier page advertises 30+ free product packages. | Product trials are service-specific and time/quota-limited. | https://www.tencentcloud.com/act/pro/FreeTier |
| Huawei Cloud | Free trial page includes always-free and limited-time-free packages; each product trial is generally once per product. | Some trials require Visa or Mastercard and may be first-come, first-served. | https://activity.huaweicloud.com/intl/en-us/free_packages/index.html |
| IBM Cloud | Registration page advertises USD 200 credit for 30 days; IBM also has Lite and Free service plans. | Lite plans are always free; billable services are fixed monthly or usage-based. | https://cloud.ibm.com/registration |
| DigitalOcean | Common new-account promotion is USD 200 credits for 60 days; verify on the signup page for your account. | Droplets start from low monthly flat-rate plans; App Platform has a USD 0/month starter tier. | https://www.digitalocean.com/pricing |
| Vultr | Free Tier program exists for eligible applicants; promotions often advertise USD 200 free credit. | Plans are pay-as-you-go; verify eligible products for promo credits. | https://www.vultr.com/free-tier-program/ |
| Akamai / Linode | Public signup/referral pages advertise USD 100 cloud credit; enterprise promotions may differ. | Shared CPU plans are simple monthly/hourly VPS-style pricing. | https://www.akamai.com/cloud/pricing |
| Hetzner Cloud | No official always-free cloud tier found. | Known for low-cost hourly/monthly cloud plans; confirm current prices after 2026 price adjustments. | https://www.hetzner.com/cloud |
| Contabo | No official always-free tier found. | Pricing page lists low-cost Cloud VPS plans, e.g. Cloud VPS 10 from EUR 5.50/month when checked. | https://contabo.com/en-us/pricing/ |
| IONOS | VPS free trial / 30-day money-back style offer; IONOS Cloud trial access is also available. | VPS plans target simple managed-friendly hosting; IONOS Cloud is usage-based. | https://www.ionos.com/servers/free-vps |
| Hostwinds | No clear official always-free tier found. | Cloud Servers page lists hourly pricing starting at USD 0.006931/hour when checked. | https://www.hostwinds.com/cloud/cloud-servers |
| Kamatera | 30-day trial; terms state one server up to USD 100 plus 1 TB free traffic during trial. | No long-term commitment; can scale up/down any time. | https://www.kamatera.com/pricing/ |
| Cloudflare | Free plan includes CDN, DDoS protection, SSL, and basic analytics. Workers free tier: 100k requests/day, 10ms CPU time. R2: 10GB storage, 1M Class A ops/month. D1: 5GB storage, 5M rows read/day, 100k rows written/day. KV: 1GB storage, 100k reads/day, 1k writes/day. | Workers paid plan starts at USD 0.30/million requests. R2: USD 0.015/GB-month storage, egress free. D1: USD 0.75/GB-month storage. | https://www.cloudflare.com/plans/ |

## Cost Checks Before Buying

- Confirm whether public IPv4 is included or billed separately.
- Check outbound traffic allowance and overage price.
- Check whether snapshots, backups, block storage, object storage, and load balancers are extra.
- Verify trial expiry behavior: disabled, deleted, or converted to paid.
- Set billing alerts before creating instances.
- Delete test resources instead of only shutting them down if the provider bills stopped disks/IPs.
