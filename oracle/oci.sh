# Oracle Cloud Infrastructure (OCI) CLI commands

# Install
bash -c "$(curl -L https://raw.githubusercontent.com/oracle/oci-cli/master/install.sh)"
# or
pip3 install oci-cli

# Authentication
oci setup config
oci iam availability-domain list
oci iam tenancy get

# Compute (Instances)
oci compute instance list --compartment-id <compartment-ocid>
oci compute instance get --instance-id <instance-ocid>
oci compute instance launch --compartment-id <compartment-ocid> --availability-domain <ad> --shape <shape> --subnet-id <subnet-ocid> --display-name <name>
oci compute instance launch --compartment-id <compartment-ocid> --availability-domain <ad> --shape VM.Standard.E4.Flex --subnet-id <subnet-ocid> --display-name <name> --image-id <image-ocid> --shape-config '{"memoryInGBs": 4, "ocpus": 1}'
oci compute instance terminate --instance-id <instance-ocid>
oci compute instance stop --instance-id <instance-ocid>
oci compute instance start --instance-id <instance-ocid>
oci compute instance reboot --instance-id <instance-ocid>
oci compute instance update --instance-id <instance-ocid> --display-name <new-name>
oci compute instance get-instance-agent-config --instance-id <instance-ocid>

# Compute Images
oci compute image list --compartment-id <compartment-ocid>
oci compute image list --compartment-id <compartment-ocid> --sort-by TIMECREATED --sort-order DESC
oci compute image get --image-id <image-ocid>
oci compute image export to-object --instance-id <instance-ocid> --destination-uri <bucket-url>

# Instance Configurations
oci compute instance-configuration list --compartment-id <compartment-ocid>
oci compute instance-configuration get --instance-configuration-id <config-ocid>
oci compute instance-configuration create --compartment-id <compartment-ocid> --instance-configuration <json-file>

# Instance Pools
oci compute instance-pool list --compartment-id <compartment-ocid>
oci compute instance-pool get --instance-pool-id <pool-ocid>
oci compute instance-pool create --compartment-id <compartment-ocid> --instance-configuration-id <config-ocid> --size <count> --display-name <name>
oci compute instance-pool terminate --instance-pool-id <pool-ocid>
oci compute instance-pool update --instance-pool-id <pool-ocid> --size <new-count>

# Boot Volumes
oci compute boot-volume list --compartment-id <compartment-ocid>
oci compute boot-volume get --boot-volume-id <bootvol-ocid>
oci compute boot-volume create --availability-domain <ad> --compartment-id <compartment-ocid> --source-details <json>

# Block Volumes
oci bv volume list --compartment-id <compartment-ocid>
oci bv volume get --volume-id <volume-ocid>
oci bv volume create --compartment-id <compartment-ocid> --availability-domain <ad> --display-name <name> --size-in-gbs <size>
oci bv volume delete --volume-id <volume-ocid>
oci bv volume update --volume-id <volume-ocid> --display-name <new-name> --size-in-gbs <new-size>
oci bv volume backup list --volume-id <volume-ocid>
oci bv volume backup create --volume-id <volume-ocid> --display-name <name>

# Volume Attachments
oci compute volume-attachment list --compartment-id <compartment-ocid>
oci compute volume-attachment attach --instance-id <instance-ocid> --volume-id <volume-ocid> --type Paravirtualized
oci compute volume-attachment detach --volume-attachment-id <attachment-ocid>

# Networking (VCN)
oci network vcn list --compartment-id <compartment-ocid>
oci network vcn create --compartment-id <compartment-ocid> --cidr-blocks '["10.0.0.0/16"]' --display-name <name>
oci network vcn delete --vcn-id <vcn-ocid>

# Subnets
oci network subnet list --compartment-id <compartment-ocid> --vcn-id <vcn-ocid>
oci network subnet create --compartment-id <compartment-ocid> --vcn-id <vcn-ocid> --cidr-block <cidr> --display-name <name>
oci network subnet update --subnet-id <subnet-ocid> --display-name <new-name>

# Internet Gateways
oci network internet-gateway list --compartment-id <compartment-ocid> --vcn-id <vcn-ocid>
oci network internet-gateway create --compartment-id <compartment-ocid> --vcn-id <vcn-ocid> --is-enabled true

# NAT Gateways
oci network nat-gateway list --compartment-id <compartment-ocid>
oci network nat-gateway create --compartment-id <compartment-ocid> --vcn-id <vcn-ocid> --display-name <name>
oci network nat-gateway delete --nat-gateway-id <nat-ocid>

# Route Tables
oci network route-table list --compartment-id <compartment-ocid> --vcn-id <vcn-ocid>
oci network route-table create --compartment-id <compartment-ocid> --vcn-id <vcn-ocid> --route-rules <json>

# Security Lists
oci network security-list list --compartment-id <compartment-ocid> --vcn-id <vcn-ocid>
oci network security-list create --compartment-id <compartment-ocid> --vcn-id <vcn-ocid> --display-name <name> --ingress-security-rules <json> --egress-security-rules <json>

# Network Load Balancers
oci network load-balancer list --compartment-id <compartment-ocid>
oci network load-balancer create --compartment-id <compartment-ocid> --subnet-ids '[<subnet-ocid>]' --display-name <name> --is-private false
oci network load-balancer delete --network-load-balancer-id <nlb-ocid>
oci network load-balancer backend-set list --network-load-balancer-id <nlb-ocid>
oci network load-balancer backend-set create --network-load-balancer-id <nlb-ocid> --name <name> --policy <policy> --backends <json> --health-check <json>
oci network load-balancer backend list --network-load-balancer-id <nlb-ocid> --backend-set-name <name>
oci network load-balancer listener list --network-load-balancer-id <nlb-ocid>
oci network load-balancer listener create --network-load-balancer-id <nlb-ocid> --default-backend-set-name <name> --name <name> --port <port> --protocol <protocol>

# Load Balancers (Classic)
oci network load-balancer load-balancer list --compartment-id <compartment-ocid>
oci network load-balancer load-balancer create --compartment-id <compartment-ocid> --subnet-ids '[<subnet-ocid>]' --display-name <name>

# Public IPs
oci network public-ip list --compartment-id <compartment-ocid>
oci network public-ip create --compartment-id <compartment-ocid> --lifetime RESERVED --display-name <name>
oci network public-ip delete --public-ip-id <ip-ocid>

# Private IPs
oci network private-ip list --compartment-id <compartment-ocid>
oci network private-ip list --subnet-id <subnet-ocid>

# DNS
oci dns zone list --compartment-id <compartment-ocid>
oci dns zone create --compartment-id <compartment-ocid> --name <domain> --zone-type PRIMARY
oci dns zone delete --zone-id <zone-ocid>
oci dns record list --zone-name <domain>
oci dns record create --zone-name <domain> --domain <subdomain> --rtype A --rdata <ip>
oci dns record create --zone-name <domain> --domain <subdomain> --rtype CNAME --rdata <target>
oci dns record create --zone-name <domain> --domain <subdomain> --rtype MX --rdata "<priority> <mail-server>"
oci dns record create --zone-name <domain> --domain <subdomain> --rtype TXT --rdata <value>
oci dns record update --zone-name <domain> --domain <subdomain> --rtype A --rdata <new-ip>
oci dns record delete --zone-name <domain> --domain <subdomain> --rtype A
oci dns zone import from-file --file <zone-file>

# Object Storage
oci os bucket list --compartment-id <compartment-ocid>
oci os bucket create --name <bucket-name> --compartment-id <compartment-ocid>
oci os bucket delete --name <bucket-name>
oci os object list --bucket-name <bucket-name>
oci os object put --bucket-name <bucket-name> --name <object-name> --file <path>
oci os object get --bucket-name <bucket-name> --name <object-name> --file <output-path>
oci os object delete --bucket-name <bucket-name> --name <object-name>
oci os presigned-url get --namespace <ns> --bucket-name <bucket> --name <object> --expires 3600

# Databases
oci db system list --compartment-id <compartment-ocid>
oci db system get --db-system-id <db-ocid>
oci db system launch --compartment-id <compartment-ocid> --availability-domain <ad> --db-edition <edition> --shape <shape> --subnet-id <subnet-ocid> --display-name <name>
oci db system terminate --db-system-id <db-ocid>
oci db backup list --db-system-id <db-ocid>
oci db backup create --db-system-id <db-ocid> --display-name <name>

# Autonomous Database
oci db autonomous-database list --compartment-id <compartment-ocid>
oci db autonomous-database create --compartment-id <compartment-ocid> --display-name <name> --db-name <dbname> --admin-password <password> --db-workload <OLTP|DW|APEX|ALL>
oci db autonomous-database terminate --autonomous-database-id <adb-ocid>
oci db autonomous-database start --autonomous-database-id <adb-ocid>
oci db autonomous-database stop --autonomous-database-id <adb-ocid>
oci db autonomous-database connection list --autonomous-database-id <adb-ocid>
oci db autonomous-database wallet download --autonomous-database-id <adb-ocid> --file <path>

# IAM
oci iam user list --compartment-id <tenancy-ocid>
oci iam user create --name <username> --email <email> --compartment-id <tenancy-ocid>
oci iam user delete --user-id <user-ocid>
oci iam group list --compartment-id <tenancy-ocid>
oci iam group create --name <name> --compartment-id <tenancy-ocid>
oci iam policy list --compartment-id <tenancy-ocid>
oci iam policy create --name <name> --compartment-id <tenancy-ocid> --statements <json>
oci iam compartment list --compartment-id <tenancy-ocid>
oci iam compartment create --name <name> --compartment-id <tenancy-ocid> --description <desc>

# Dynamic Groups
oci iam dynamic-group list --compartment-id <tenancy-ocid>
oci iam dynamic-group create --name <name> --compartment-id <tenancy-ocid> --matching-rule <rule>

# API Keys
oci iam api-key list --user-id <user-ocid>
oci iam api-key upload --user-id <user-ocid> --key-file <path>

# Auth Tokens
oci iam auth-token list --user-id <user-ocid>
oci iam auth-token create --user-id <user-ocid> --description <desc>

# Customer Secret Keys
oci iam customer-secret-key list --user-id <user-ocid>
oci iam customer-secret-key create --user-id <user-ocid> --display-name <name>

# Tags
oci iam tag namespace list --compartment-id <tenancy-ocid>
oci iam tag namespace create --compartment-id <tenancy-ocid> --name <namespace>
oci iam tag list --tag-namespace-id <ns-ocid>
oci iam tag create --tag-namespace-id <ns-ocid> --name <tag-name>
oci iam tag-default list --compartment-id <tenancy-ocid>

# Events
oci events rule list --compartment-id <compartment-ocid>
oci events rule create --compartment-id <compartment-ocid> --display-name <name> --condition <json> --actions <json>

# Audit
oci audit event list --start-time <time> --end-time <time>

# Key Management (Vault)
oci kms management key list --compartment-id <compartment-ocid> --endpoint <endpoint>
oci kms management key create --compartment-id <compartment-ocid> --endpoint <endpoint> --display-name <name> --key-shape '{"algorithm": "AES", "length": 32}'

# Functions
oci fn function list --application-id <app-ocid>
oci fn application list --compartment-id <compartment-ocid>
oci fn function invoke --function-id <fn-ocid> --file <input-file>

# API Gateway
oci apigateway gateway list --compartment-id <compartment-ocid>
oci apigateway deployment list --compartment-id <compartment-ocid>

# Service Connector Hub
oci sch service-connector list --compartment-id <compartment-ocid>

# Health Checks
oci health-check probe-monitor-result list --compartment-id <compartment-ocid>

# Logging
oci logging log list --compartment-id <compartment-ocid>
oci logging log-group list --compartment-id <compartment-ocid>
oci logging log-group create --compartment-id <compartment-ocid> --display-name <name>

# Monitoring
oci monitoring alarm list --compartment-id <compartment-ocid>
oci monitoring alarm create --compartment-id <compartment-ocid> --display-name <name> --metric-compartment-id <cid> --namespace <ns> --query <query>

# Search
oci search resource list --compartment-id <tenancy-ocid> --type <resource-type>

# Output Format
oci compute instance list --compartment-id <cid> --output json
oci compute instance list --compartment-id <cid> --output table
oci compute instance list --compartment-id <cid> --output yaml

# Pagination
oci compute instance list --compartment-id <cid> --all
oci compute instance list --compartment-id <cid> --limit 100

# CLI Pagination
oci compute instance list --compartment-id <cid> --page <page-token>

# Raw Requests
oci raw-request --http-method GET --target-uri <uri>
