# Cloud CLI Notes

A practical command notebook for cloud providers, VPS platforms, and edge
services. Each provider folder contains commonly used CLI commands for setup,
authentication, compute, networking, storage, databases, deployment, monitoring,
and cleanup.

Use the commands as copy-and-adjust references. Most examples include
placeholders such as `<region>`, `<project-id>`, `<instance>`, or `<bucket>` that
must be replaced before running.

## Quick Start

1. Pick a provider from the list below.
2. Open the matching `.sh` file.
3. Configure credentials with the provider's official CLI.
4. Replace all placeholder values before running any command.
5. Check [pricing-free-tier.md](pricing-free-tier.md) before creating billable
   resources.

## Command Conventions

- Values in angle brackets, such as `<project-id>`, are placeholders and must be
  replaced; do not type the brackets literally.
- Uppercase values such as `SERVER_ID` are placeholders unless the surrounding
  notes explicitly define them as environment variables.
- The `.sh` files are reference notebooks, not scripts intended to be run from
  top to bottom. Copy only the command you need and inspect it first.
- Commands that create, resize, transfer, or retain resources can incur charges.
- Commands containing `delete`, `remove`, `terminate`, `purge`, `--force`, or
  `--delete` can be destructive. List or preview the target before running them.

## Repository Layout

| Path | Purpose |
| --- | --- |
| [README.md](README.md) | Project overview and provider index. |
| [pricing-free-tier.md](pricing-free-tier.md) | Free-tier, trial-credit, and cost-check notes. |
| `<provider>/<cli>.sh` | Provider-specific command reference. |

## Provider Index

### Major Cloud Platforms

| Provider | CLI notes |
| --- | --- |
| Alibaba Cloud | [aliyun/aliyun.sh](aliyun/aliyun.sh) |
| Amazon Web Services | [aws/aws.sh](aws/aws.sh) |
| Microsoft Azure | [azure/azure.sh](azure/azure.sh) |
| Google Cloud Platform | [gcp/gcloud.sh](gcp/gcloud.sh), [gcp/ssh.sh](gcp/ssh.sh) |
| Firebase | [firebase/firebase.sh](firebase/firebase.sh) |
| Tencent Cloud | [tencent/tencentcloud.sh](tencent/tencentcloud.sh) |
| Huawei Cloud | [huawei/hcloud.sh](huawei/hcloud.sh) |
| Oracle Cloud Infrastructure | [oracle/oci.sh](oracle/oci.sh) |
| IBM Cloud | [ibm/ibmcloud.sh](ibm/ibmcloud.sh) |

### VPS And Developer Clouds

| Provider | CLI notes |
| --- | --- |
| DigitalOcean | [digitalocean/doctl.sh](digitalocean/doctl.sh) |
| Vultr | [vultr/vultr.sh](vultr/vultr.sh) |
| Linode / Akamai Cloud | [linode/linode-cli.sh](linode/linode-cli.sh) |
| Hetzner Cloud | [hetzner/hcloud.sh](hetzner/hcloud.sh) |
| Contabo | [contabo/cntb.sh](contabo/cntb.sh) |
| IONOS | [ionos/ionosctl.sh](ionos/ionosctl.sh) |
| Hostwinds | [hostwinds/hostwinds.sh](hostwinds/hostwinds.sh) |
| Kamatera | [kamatera/kamatera.sh](kamatera/kamatera.sh) |

### Edge, CDN, And Media

| Provider | CLI notes |
| --- | --- |
| Cloudflare | [cloudflare/cf.sh](cloudflare/cf.sh) |
| Bitiful S4 | [bitiful/bitiful.sh](bitiful/bitiful.sh) |
| Mux | [mux/mux.sh](mux/mux.sh) |

## Safety Notes

- Treat these files as command references, not executable deployment scripts.
- Review destructive commands such as delete, remove, release, terminate, purge,
  and revoke before running them.
- Confirm the active account, project, subscription, region, and billing profile
  before creating resources.
- Store credentials in each provider's recommended credential manager or
  environment variables. Do not commit secrets.
- Set budgets or billing alerts before experiments that create compute, storage,
  public IPs, snapshots, backups, or load balancers.

## Pricing Notes

Pricing and free-tier rules change often. The shortlist in
[pricing-free-tier.md](pricing-free-tier.md) is meant for orientation only; always
confirm current prices, regional availability, taxes, bandwidth limits, IPv4
charges, support fees, and trial-expiry behavior on the provider's official site.
