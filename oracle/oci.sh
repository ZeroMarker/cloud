# Oracle Cloud Infrastructure (OCI) CLI command notebook
# Last verified: 2026-08-21 with OCI CLI 3.90.2
#
# This is a reference notebook, not a script to run from top to bottom.
# Replace every <placeholder> before executing a command. Run `oci <group> --help`
# when adapting an example to a different resource type.

# Install
# Linux/macOS installer maintained by Oracle:
bash -c "$(curl -L https://raw.githubusercontent.com/oracle/oci-cli/master/scripts/install/install.sh)"
# Windows PowerShell installer (run directly in PowerShell, without the leading #):
# powershell -NoProfile -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/oracle/oci-cli/master/scripts/install/install.ps1'))"

# Version and authentication
oci --version
oci setup config
oci iam region list --all
oci iam availability-domain list --compartment-id <tenancy-ocid>
oci iam tenancy get --tenancy-id <tenancy-ocid>

# Deployment template (do not commit real resource names, addresses, or OCIDs)
# Home region: <home-region>
# Instance: <instance-name>
# State: <lifecycle-state>
# Shape: <shape>
# OCPUs / memory: <ocpus> / <memory-gb>
# Boot volume: <boot-volume-gb>, <vpus-per-gb> VPUs/GB
# Public IP: <public-ip>
# Local SSH shortcut: <ssh-alias>
# Month-to-date cost: <amount> <currency>

# Always Free guardrails# - Create Always Free Compute only in the tenancy home region.
# - Pure Always Free tenancy: current docs show A1 at 2 OCPUs / 12 GB total.
# - PAYG A1 free metering: 3,000 OCPU-hours and 18,000 GB-hours per month,
#   equivalent to 4 OCPUs / 24 GB running throughout a 31-day month.
# - PAYG service limits can be higher than the free metering allowance.
# - VM.Standard.E2.1.Micro: up to two instances.
# - Boot volumes plus block volumes: 200 GB total.
# - Keep boot-volume performance at 10 VPUs/GB (Balanced).
# - Use an Always Free-eligible Oracle Linux or Ubuntu image.
# - VM.Standard.E4.Flex and Ultra High Performance volumes are not Always Free.

# Compute instances
oci compute instance list --compartment-id <compartment-ocid> --all
oci compute instance get --instance-id <instance-ocid>

# A1 example for a pure Always Free tenancy. PAYG accounts can use 4 OCPUs and
# 24 GB within their monthly included A1 hours. Only the public SSH key is
# uploaded; keep the private key on the client. The 150 GB boot volume leaves
# 50 GB of the 200 GB storage allowance.
oci compute instance launch \
  --compartment-id <compartment-ocid> \
  --availability-domain <availability-domain> \
  --shape VM.Standard.A1.Flex \
  --shape-config '{"ocpus": 2, "memoryInGBs": 12}' \
  --subnet-id <subnet-ocid> \
  --image-id <always-free-image-ocid> \
  --display-name <instance-name> \
  --assign-public-ip true \
  --boot-volume-size-in-gbs 150 \
  --ssh-authorized-keys-file ~/.ssh/id_rsa_oracle.pub

# Instance lifecycle
oci compute instance stop --instance-id <instance-ocid>
oci compute instance start --instance-id <instance-ocid>
oci compute instance reboot --instance-id <instance-ocid>
oci compute instance update --instance-id <instance-ocid> --display-name <new-name>
# Flexible-shape resize reboots a running instance.
oci compute instance update \
  --instance-id <instance-ocid> \
  --shape-config '{"ocpus": 4, "memoryInGBs": 24}' \
  --force

# Termination is destructive. Choose boot-volume behavior explicitly.
oci compute instance terminate --instance-id <instance-ocid> --preserve-boot-volume false
# To retain the boot volume instead:
# oci compute instance terminate --instance-id <instance-ocid> --preserve-boot-volume true

# VNIC and IP discovery
oci compute vnic-attachment list --compartment-id <compartment-ocid> --instance-id <instance-ocid>
oci network vnic get --vnic-id <vnic-ocid>

# Images
oci compute image list --compartment-id <compartment-ocid> --all --sort-by TIMECREATED --sort-order DESC
oci compute image get --image-id <image-ocid>
oci compute image export to-object \
  --image-id <image-ocid> \
  --namespace <object-storage-namespace> \
  --bucket-name <bucket-name> \
  --name <object-name>

# Instance configurations and pools belong to compute-management, not compute.
oci compute-management instance-configuration list --compartment-id <compartment-ocid> --all
oci compute-management instance-configuration get --instance-configuration-id <configuration-ocid>
oci compute-management instance-configuration create \
  --compartment-id <compartment-ocid> \
  --instance-details file://<instance-details-json>

oci compute-management instance-pool list --compartment-id <compartment-ocid> --all
oci compute-management instance-pool get --instance-pool-id <pool-ocid>
oci compute-management instance-pool update --instance-pool-id <pool-ocid> --size <new-size>
oci compute-management instance-pool terminate --instance-pool-id <pool-ocid>

# Boot volumes use the bv command group.
oci bv boot-volume list --compartment-id <compartment-ocid> --availability-domain <availability-domain> --all
oci bv boot-volume get --boot-volume-id <boot-volume-ocid>
oci bv boot-volume update --boot-volume-id <boot-volume-ocid> --vpus-per-gb 10
oci bv boot-volume delete --boot-volume-id <boot-volume-ocid>

# Block volumes
oci bv volume list --compartment-id <compartment-ocid> --availability-domain <availability-domain> --all
oci bv volume get --volume-id <volume-ocid>
oci bv volume create \
  --compartment-id <compartment-ocid> \
  --availability-domain <availability-domain> \
  --display-name <volume-name> \
  --size-in-gbs <size> \
  --vpus-per-gb 10
oci bv volume update --volume-id <volume-ocid> --display-name <new-name> --size-in-gbs <new-size> --vpus-per-gb 10
oci bv volume delete --volume-id <volume-ocid>

# Block-volume backups use `bv backup`; boot-volume backups use
# `bv boot-volume-backup`.
oci bv backup list --compartment-id <compartment-ocid> --volume-id <volume-ocid> --all
oci bv backup create --volume-id <volume-ocid> --display-name <backup-name>
oci bv boot-volume-backup list --compartment-id <compartment-ocid> --boot-volume-id <boot-volume-ocid> --all
oci bv boot-volume-backup create --boot-volume-id <boot-volume-ocid> --display-name <backup-name>

# Volume attachments
oci compute volume-attachment list --compartment-id <compartment-ocid> --instance-id <instance-ocid> --all
oci compute volume-attachment attach --instance-id <instance-ocid> --volume-id <volume-ocid> --type paravirtualized
oci compute volume-attachment detach --volume-attachment-id <attachment-ocid>

# VCN and subnet
oci network vcn list --compartment-id <compartment-ocid> --all
oci network vcn create --compartment-id <compartment-ocid> --cidr-blocks '["10.0.0.0/16"]' --display-name <vcn-name>
oci network subnet list --compartment-id <compartment-ocid> --vcn-id <vcn-ocid> --all
oci network subnet create \
  --compartment-id <compartment-ocid> \
  --vcn-id <vcn-ocid> \
  --cidr-block <subnet-cidr> \
  --display-name <subnet-name>

# Gateways, routes, and security lists
oci network internet-gateway list --compartment-id <compartment-ocid> --vcn-id <vcn-ocid> --all
oci network internet-gateway create --compartment-id <compartment-ocid> --vcn-id <vcn-ocid> --is-enabled true --display-name <gateway-name>
oci network nat-gateway list --compartment-id <compartment-ocid> --all
oci network route-table list --compartment-id <compartment-ocid> --vcn-id <vcn-ocid> --all
oci network security-list list --compartment-id <compartment-ocid> --vcn-id <vcn-ocid> --all
oci network nsg list --compartment-id <compartment-ocid> --vcn-id <vcn-ocid> --all

# Network Load Balancer (NLB)
oci nlb network-load-balancer list --compartment-id <compartment-ocid> --all
oci nlb network-load-balancer create \
  --compartment-id <compartment-ocid> \
  --display-name <nlb-name> \
  --subnet-id <subnet-ocid> \
  --is-private false
oci nlb network-load-balancer delete --network-load-balancer-id <nlb-ocid>

# Flexible Load Balancer. For Always Free, use the 10 Mbps flexible shape only.
oci lb load-balancer list --compartment-id <compartment-ocid> --all
oci lb load-balancer create \
  --compartment-id <compartment-ocid> \
  --display-name <lb-name> \
  --shape-name flexible \
  --shape-details '{"minimumBandwidthInMbps": 10, "maximumBandwidthInMbps": 10}' \
  --subnet-ids '["<subnet-ocid>"]' \
  --is-private false

# Public and private IPs
oci network public-ip list --compartment-id <compartment-ocid> --scope REGION --all
oci network public-ip create --compartment-id <compartment-ocid> --lifetime RESERVED --display-name <name>
oci network public-ip delete --public-ip-id <public-ip-ocid>
oci network private-ip list --subnet-id <subnet-ocid> --all

# DNS
oci dns zone list --compartment-id <compartment-ocid> --scope GLOBAL --all
oci dns zone create --compartment-id <compartment-ocid> --name <zone-name> --zone-type PRIMARY --scope GLOBAL
oci dns zone delete --zone-name-or-id <zone-name-or-ocid> --scope GLOBAL
oci dns record zone get --zone-name-or-id <zone-name-or-ocid> --scope GLOBAL
oci dns record rrset get --zone-name-or-id <zone-name-or-ocid> --domain <fqdn> --rtype A --scope GLOBAL
oci dns record rrset update \
  --zone-name-or-id <zone-name-or-ocid> \
  --domain <fqdn> \
  --rtype A \
  --items '[{"domain":"<fqdn>","rtype":"A","rdata":"<ip>","ttl":300}]' \
  --scope GLOBAL
oci dns record rrset delete --zone-name-or-id <zone-name-or-ocid> --domain <fqdn> --rtype A --scope GLOBAL
oci dns zone create-zone-from-zone-file \
  --compartment-id <compartment-ocid> \
  --create-zone-from-zone-file-details file://<zone-file> \
  --scope GLOBAL

# Object Storage
oci os ns get
oci os bucket list --compartment-id <compartment-ocid> --all
oci os bucket create --compartment-id <compartment-ocid> --name <bucket-name>
oci os object list --bucket-name <bucket-name> --all
oci os object put --bucket-name <bucket-name> --name <object-name> --file <local-file>
oci os object get --bucket-name <bucket-name> --name <object-name> --file <output-file>
oci os object delete --bucket-name <bucket-name> --name <object-name>

# A pre-authenticated request is the OCI equivalent of a presigned URL.
oci os preauth-request create \
  --namespace-name <namespace> \
  --bucket-name <bucket-name> \
  --name <request-name> \
  --access-type ObjectRead \
  --object-name <object-name> \
  --time-expires <utc-expiration-time>

# Autonomous AI Database. Keep the password in a task-specific environment
# variable or secret store; never commit it to this repository.
oci db autonomous-database list --compartment-id <compartment-ocid> --all
oci db autonomous-database create \
  --compartment-id <compartment-ocid> \
  --db-name <database-name> \
  --display-name <display-name> \
  --db-workload OLTP \
  --is-free-tier true \
  --admin-password "$OCI_ADB_ADMIN_PASSWORD"
oci db autonomous-database get --autonomous-database-id <database-ocid>
oci db autonomous-database stop --autonomous-database-id <database-ocid>
oci db autonomous-database start --autonomous-database-id <database-ocid>
oci db autonomous-database terminate --autonomous-database-id <database-ocid>

# IAM and API keys
oci iam user list --compartment-id <tenancy-ocid> --all
oci iam group list --compartment-id <tenancy-ocid> --all
oci iam policy list --compartment-id <tenancy-ocid> --all
oci iam compartment list --compartment-id <tenancy-ocid> --compartment-id-in-subtree true --all
oci iam api-key list --user-id <user-ocid> --all
oci iam api-key upload --user-id <user-ocid> --key-file <public-api-key-file>

# Audit, health checks, monitoring, and resource search
oci audit event list --compartment-id <compartment-ocid> --start-time <start-time> --end-time <end-time>
oci health-checks http-monitor list --compartment-id <compartment-ocid> --all
oci monitoring alarm list --compartment-id <compartment-ocid> --all
oci search resource structured-search --query-text "query all resources" --limit 1000

# Cost and usage. For a partial month use DAILY; MONTHLY requires first-of-month
# boundaries. The end time is exclusive. This command has --limit, not --all.
oci usage-api usage-summary request-summarized-usages \
  --tenant-id <tenancy-ocid> \
  --time-usage-started <month-start-utc> \
  --time-usage-ended <end-utc> \
  --granularity DAILY \
  --query-type COST \
  --group-by '["service"]' \
  --is-aggregate-by-time true \
  --limit 500

# Output and pagination
oci compute instance list --compartment-id <compartment-ocid> --output json --all
oci compute instance list --compartment-id <compartment-ocid> --output table --all
oci compute instance list --compartment-id <compartment-ocid> --output yaml --all
oci compute instance list --compartment-id <compartment-ocid> --limit 100
oci compute instance list --compartment-id <compartment-ocid> --page <page-token>

# Raw request (read the target API documentation before use)
oci raw-request --http-method GET --target-uri <uri>
