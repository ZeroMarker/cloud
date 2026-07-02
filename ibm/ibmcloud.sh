# IBM Cloud CLI (ibmcloud) commands

# Authentication
ibmcloud login
ibmcloud login --sso
ibmcloud logout
ibmcloud target --cf
ibmcloud target -r <region>
ibmcloud target -g <resource-group>

# Resource Groups
ibmcloud resource groups
ibmcloud resource group create <name>
ibmcloud resource group delete <name>

# VPC - Instances
ibmcloud is instances
ibmcloud is instance <instance-id>
ibmcloud is instance-create my-vsi <vpc-id> <zone> <profile> <subnet-id> --image <image-id>
ibmcloud is instance-delete <instance-id> --force
ibmcloud is instance-start <instance-id>
ibmcloud is instance-stop <instance-id>
ibmcloud is instance-reboot <instance-id>
ibmcloud is instance-reload <instance-id>
ibmcloud is instance-clone <instance-id> --name <new-name>
ibmcloud is instance-network-interface-add <instance-id> --subnet <subnet-id> --name <nic-name>
ibmcloud is instance-network-interface-remove <instance-id> --network-interface <nic-id>

# VPC - Volumes
ibmcloud is volumes
ibmcloud is volume <volume-id>
ibmcloud is volume-create <name> <zone> --profile <profile> --capacity <gb>
ibmcloud is volume-delete <volume-id> --force
ibmcloud is instance-volume-attach <instance-id> --volume <volume-id> --auto-delete
ibmcloud is instance-volume-detach <instance-id> --volume <volume-id>

# VPC - VPCs
ibmcloud is vpcs
ibmcloud is vpc <vpc-id>
ibmcloud is vpc-create <name>
ibmcloud is vpc-delete <vpc-id> --force
ibmcloud is vpc-update <vpc-id> --name <new-name>

# VPC - Subnets
ibmcloud is subnets
ibmcloud is subnet <subnet-id>
ibmcloud is subnet-create <name> <vpc-id> --zone <zone> --ipv4-address-count <count>
ibmcloud is subnet-delete <subnet-id> --force

# VPC - Security Groups
ibmcloud is security-groups
ibmcloud is security-group <sg-id>
ibmcloud is security-group-create <name> <vpc-id>
ibmcloud is security-group-delete <sg-id> --force
ibmcloud is security-group-rule-add <sg-id> inbound tcp --remote <ip-cidr> --port-min 80 --port-max 80
ibmcloud is security-group-rule-add <sg-id> inbound udp --remote <ip-cidr> --port-min 53 --port-max 53
ibmcloud is security-group-rule-add <sg-id> outbound tcp --remote <ip-cidr> --port-min 1 --port-max 65535
ibmcloud is security-group-rules <sg-id>
ibmcloud is security-group-rule-delete <sg-id> <rule-id> --force

# VPC - Floating IPs
ibmcloud is floating-ips
ibmcloud is floating-ip-reserve <name> --target <nic-id>
ibmcloud is floating-ip-release <fip-id> --force
ibmcloud is floating-ip-update <fip-id> --name <new-name>

# VPC - Public Gateways
ibmcloud is public-gateways
ibmcloud is public-gateway-create <name> <vpc-id> <zone>
ibmcloud is public-gateway-delete <pgw-id> --force
ibmcloud is subnet-public-gateway-attach <subnet-id> --gateway <pgw-id>
ibmcloud is subnet-public-gateway-detach <subnet-id>

# VPC - Network ACLs
ibmcloud is network-acls
ibmcloud is network-acl <acl-id>
ibmcloud is network-acl-create <name> <vpc-id>
ibmcloud is network-acl-delete <acl-id> --force
ibmcloud is network-acl-rule-add <acl-id> inbound --action allow --source <ip-cidr> --port-min 80 --port-max 80
ibmcloud is network-acl-rules <acl-id>
ibmcloud is network-acl-rule-delete <acl-id> <rule-id> --force

# VPC - VPN Gateway
ibmcloud is vpn-gateways
ibmcloud is vpn-gateway-create <name> <subnet-id>
ibmcloud is vpn-gateway-delete <vpn-gw-id> --force
ibmcloud is vpn-gateway-connections <vpn-gw-id>
ibmcloud is vpn-gateway-connection-create <vpn-gw-id> <name> <peer-address> --pre-shared-key <key>
ibmcloud is vpn-gateway-connection-delete <vpn-gw-id> <conn-id> --force

# COS (Cloud Object Storage)
ibmcloud cos buckets
ibmcloud cos bucket-create <bucket-name> --class <storage-class> --region <region>
ibmcloud cos bucket-delete <bucket-name> --region <region>
ibmcloud cos objects --bucket <bucket-name> --region <region>
ibmcloud cos object-upload --bucket <bucket-name> --key <key> --file <local-file> --region <region>
ibmcloud cos object-download --bucket <bucket-name> --key <key> --file <local-file> --region <region>
ibmcloud cos object-delete --bucket <bucket-name> --key <key> --region <region>
ibmcloud cos object-head --bucket <bucket-name> --key <key> --region <region>
ibmcloud cos presign --method PUT --bucket <bucket-name> --key <key> --region <region> --expiry 3600

# Kubernetes (IKS/ROKS)
ibmcloud ks clusters
ibmcloud ks cluster get --cluster <cluster-id-or-name>
ibmcloud ks cluster create vpc-gen2 --name <name> --zone <zone> --flavor <flavor> --version <version> --vpc-id <vpc> --subnet-id <subnet>
ibmcloud ks cluster rm --cluster <cluster-id-or-name> --force
ibmcloud ks cluster workers --cluster <cluster-id-or-name>
ibmcloud ks worker-pool add --cluster <cluster-id-or-name> --name <pool-name> --flavor <flavor> --size <count> --vpc-id <vpc> --subnet-id <subnet>
ibmcloud ks worker-pool rm --cluster <cluster-id-or-name> --pool <pool-name> --force
ibmcloud ks worker-pool resize --cluster <cluster-id-or-name> --pool <pool-name> --count <count>
ibmcloud ks cluster-config --cluster <cluster-id-or-name> --admin
ibmcloud ks cluster ls-versions --cluster <cluster-id-or-name>
ibmcloud ks cluster update --cluster <cluster-id-or-name> --version <version>

# IAM
ibmcloud iam users
ibmcloud iam user-api-keys <user-id>
ibmcloud iam api-key-create <name> --file <file>
ibmcloud iam api-key-delete <api-key-id> --force
ibmcloud iam access-groups
ibmcloud iam access-group-create <name>
ibmcloud iam access-group-delete <group-id> --force
ibmcloud iam access-group-members <group-id>
ibmcloud iam access-group-user-add <group-id> --user <user-id>
ibmcloud iam access-group-user-remove <group-id> --user <user-id>

# DNS (Internet Services)
ibmcloud dns zones
ibmcloud dns zone-create --name <domain>
ibmcloud dns zone-delete --zone-id <zone-id> --force
ibmcloud dns resource-records --zone-id <zone-id>
ibmcloud dns resource-record-create --zone-id <zone-id> --type A --name @ --ip-address <ip>
ibmcloud dns resource-record-create --zone-id <zone-id> --type CNAME --name www --alias-name <target>
ibmcloud dns resource-record-update --zone-id <zone-id> --record-id <id> --data <new-ip>
ibmcloud dns resource-record-delete --zone-id <zone-id> --record-id <id> --force

# Event Streams
ibmcloud es clusters
ibmcloud es instance-create <name> --plan standard --region <region>
ibmcloud es instance-delete <instance-id> --force
ibmcloud es topic-create --name <topic> --replication-factor 3 --partitions 1
ibmcloud es topic-delete --name <topic> --force
ibmcloud es topic-list

# Cloud Functions
ibmcloud fn list
ibmcloud fn action create <package>/<action> <file.js>
ibmcloud fn action invoke <package>/<action> --param key value
ibmcloud fn action delete <package>/<action> --force
ibmcloud fn trigger create <trigger-name> --feed <feed-name>
ibmcloud fn trigger delete <trigger-name> --force
ibmcloud fn rule create <rule-name> --trigger <trigger> --action <action>
ibmcloud fn rule delete <rule-name> --force
ibmcloud fn package create <package>
ibmcloud fn package delete <package> --force

# Monitoring (Sysdig)
ibmcloud monitoring dashboards
ibmcloud monitoring dashboard-create --name <name>
ibmcloud monitoring dashboard-delete --dashboard-id <id> --force
ibmcloud monitoring alert-create --name <name> --condition <condition>
ibmcloud monitoring alert-list
ibmcloud monitoring alert-delete --alert-id <id> --force

# Logging
ibmcloud logging instances
ibmcloud logging targets
ibmcloud logging target-create --name <name> --host <host> --port <port>
ibmcloud logging target-delete --target-id <id> --force
ibmcloud logging routes
ibmcloud logging route-create --name <name> --target <target-id>
ibmcloud logging route-delete --route-id <id> --force
