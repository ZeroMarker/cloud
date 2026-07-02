# DigitalOcean doctl CLI commands

# Authentication
doctl auth init
doctl auth init --context <name>
doctl auth switch --context <name>
doctl auth list
doctl account get

# Droplets (Compute)
doctl compute droplet list
doctl compute droplet get <droplet-id>
doctl compute droplet create <name> --region <region> --size <size> --image <image>
doctl compute droplet create <name> --region <region> --size <size> --image <image> --ssh-keys <key-id>
doctl compute droplet delete <droplet-id>
doctl compute droplet delete --force <droplet-id>
doctl compute droplet action resize <droplet-id> --size <new-size>
doctl compute droplet action rename <droplet-id> --hostname <new-name>
doctl compute droplet action rebuild <droplet-id> --image <image>
doctl compute droplet action restore <droplet-id> --image <snapshot-id>
doctl compute droplet action snapshot <droplet-id> --snapshot-name <name>
doctl compute droplet neighbors <droplet-id>
doctl compute ssh <droplet-name>
doctl compute ssh <user>@<droplet-name>

# 1-Click Apps
doctl 1-click list
doctl 1-click slugs

# Domains / DNS
doctl compute domain list
doctl compute domain create <domain> --ip-address <ip>
doctl compute domain delete <domain>
doctl compute domain records list <domain>
doctl compute domain records create <domain> --record-type A --record-name @ --record-data <ip>
doctl compute domain records create <domain> --record-type CNAME --record-name www --record-data <target>
doctl compute domain records create <domain> --record-type TXT --record-name <name> --record-data <value>
doctl compute domain records update <domain> --record-id <id> --record-data <new-ip>
doctl compute domain records delete <domain> --record-id <id>

# Floating IPs
doctl compute floating-ip list
doctl compute floating-ip create --region <region>
doctl compute floating-ip delete <ip>
doctl compute floating-ip-action assign <ip> <droplet-id>
doctl compute floating-ip-action unassign <ip>

# Volumes (Block Storage)
doctl compute volume list
doctl compute volume get <volume-id>
doctl compute volume create <name> --region <region> --size <size-gb> --description <desc>
doctl compute volume delete <volume-id>
doctl compute volume attach <volume-id> --droplet-id <droplet-id>
doctl compute volume detach <volume-id> --droplet-id <droplet-id>
doctl compute volume-snapshot list
doctl compute volume-snapshot create <volume-id> --snapshot-name <name>
doctl compute volume-snapshot delete <snapshot-id>

# Snapshots
doctl compute snapshot list
doctl compute snapshot get <snapshot-id>
doctl compute snapshot delete <snapshot-id>

# Images
doctl compute image list
doctl compute image get <image-id>
doctl compute image list --public
doctl compute image update <image-id> --name <new-name>
doctl compute image delete <image-id>

# Load Balancers
doctl compute load-balancer list
doctl compute load-balancer get <lb-id>
doctl compute load-balancer create <name> --region <region> --forwarding-rules <rules>
doctl compute load-balancer update <lb-id> --name <new-name>
doctl compute load-balancer delete <lb-id>
doctl compute load-balancer add-droplets <lb-id> --droplet-ids <ids>
doctl compute load-balancer remove-droplets <lb-id> --droplet-ids <ids>
doctl compute load-balancer add-forwarding-rules <lb-id> --forwarding-rules <rules>
doctl compute load-balancer remove-forwarding-rules <lb-id> --forwarding-rules <rules>

# Firewalls
doctl compute firewall list
doctl compute firewall get <firewall-id>
doctl compute firewall create <name> --inbound-rules <rules> --outbound-rules <rules>
doctl compute firewall update <firewall-id> --name <new-name>
doctl compute firewall delete <firewall-id>
doctl compute firewall add-droplets <firewall-id> --droplet-ids <ids>
doctl compute firewall remove-droplets <firewall-id> --droplet-ids <ids>
doctl compute firewall add-rules <firewall-id> --inbound-rules <rules>
doctl compute firewall remove-rules <firewall-id> --inbound-rules <rules>

# Reserved IPs
doctl compute reserved-ip list
doctl compute reserved-ip create --region <region>
doctl compute reserved-ip get <ip>
doctl compute reserved-ip delete <ip>
doctl compute reserved-ip-action assign <ip> <droplet-id>
doctl compute reserved-ip-action unassign <ip>

# VPCs
doctl vpcs list
doctl vpcs get <vpc-id>
doctl vpcs create --name <name> --region <region> --ip-range <cidr>
doctl vpcs update <vpc-id> --name <new-name>
doctl vpcs delete <vpc-id>
doctl vpcs list-members <vpc-id>

# Kubernetes
doctl kubernetes cluster list
doctl kubernetes cluster get <cluster-id>
doctl kubernetes cluster create <name> --region <region> --version <version> --size <size>
doctl kubernetes cluster delete <cluster-id>
doctl kubernetes cluster update <cluster-id> --name <new-name>
doctl kubernetes cluster node-pool list <cluster-id>
doctl kubernetes cluster node-pool create <cluster-id> --name <name> --size <size> --count <count>
doctl kubernetes cluster node-pool delete <cluster-id> --pool-id <pool-id>
doctl kubernetes cluster node-pool update <cluster-id> --pool-id <pool-id> --count <count>
doctl kubernetes cluster kubeconfig show <cluster-id>
doctl kubernetes cluster kubeconfig save <cluster-id>
doctl kubernetes cluster kubeconfig remove <cluster-id>

# Databases
doctl databases list
doctl databases get <db-id>
doctl databases create <name> --engine <engine> --version <version> --size <size> --region <region>
doctl databases delete <db-id>
doctl databases resize <db-id> --size <new-size>
doctl databases connection-pool list <db-id>
doctl databases connection-pool create <db-id> --name <name> --db <db-name> --user <user>
doctl databases connection-pool delete <db-id> --pool-name <pool>
doctl databases user list <db-id>
doctl databases user create <db-id> --name <username>
doctl databases user delete <db-id> --name <username>
doctl databases db list <db-id>
doctl databases db create <db-id> --name <dbname>
doctl databases db delete <db-id> --name <dbname>
doctl databases firewall-rules list <db-id>
doctl databases firewall-rules append <db-id> --rule <type>:<value>

# Apps Platform
doctl apps list
doctl apps get <app-id>
doctl apps create --spec <spec-file>
doctl apps update <app-id> --spec <spec-file>
doctl apps delete <app-id>
doctl apps deployments list <app-id>
doctl apps logs <app-id>

# Container Registry
doctl registry get
doctl registry create <name>
doctl registry delete
doctl registry repository list
doctl registry repository get <repo-name>
doctl registry repository delete <repo-name>
doctl registry run

# Monitoring
doctl monitoring alert create --type <type> --value <value>
doctl monitoring alert list
doctl monitoring alert update <alert-id> --value <new-value>
doctl monitoring alert delete <alert-id>

# Projects
doctl projects list
doctl projects get <project-id>
doctl projects create --name <name> --description <desc>
doctl projects update <project-id> --name <new-name>
doctl projects delete <project-id>
doctl projects resources list <project-id>
doctl projects resources assign <project-id> --resource-urn <urn>

# Account & Billing
doctl account get
doctl balance get
doctl billing-history list

# Tags
doctl compute tag list
doctl compute tag create <tag-name>
doctl compute tag delete <tag-name>

# SSH Keys
doctl compute ssh-key list
doctl compute ssh-key get <key-id>
doctl compute ssh-key create <name> <public-key>
doctl compute ssh-key update <key-id> --name <new-name>
doctl compute ssh-key delete <key-id>

# Regions / Sizes
doctl compute region list
doctl compute size list

# Shell Completions
doctl completion bash
doctl completion zsh
doctl completion fish

# Config
doctl --config <path> <command>

# Spaces (S3-compatible Object Storage)
doctl spaces region list
doctl spaces list
doctl spaces create <bucket-name> --region <region>
doctl spaces delete <bucket-name> --region <region>
doctl spaces objects list <bucket-name> --region <region>
doctl spaces objects upload <bucket-name> --file <local-file> --key <object-key> --region <region>
doctl spaces objects download <bucket-name> --key <object-key> --file <local-file> --region <region>
doctl spaces objects delete <bucket-name> --key <object-key> --region <region>
doctl spaces objects get <bucket-name> --key <object-key> --region <region>
doctl spaces objects presign <bucket-name> --key <object-key> --region <region> --expiry <seconds>

# CDN
doctl cdn list
doctl cdn get <cdn-id>
doctl cdn create --origin <origin> --certificate-id <cert-id> --custom-domain <domain>
doctl cdn delete <cdn-id>
doctl cdn flush-cache <cdn-id>
doctl cdn update <cdn-id> --origin <new-origin>

# Functions (Serverless)
doctl serverless list-namespaces
doctl serverless create-namespace <namespace>
doctl serverless delete-namespace <namespace>
doctl serverless functions list --namespace <namespace>
doctl serverless functions get <function> --namespace <namespace>
doctl serverless functions invoke <function> --namespace <namespace> --param <key>=<value>
doctl serverless functions deploy <function> --namespace <namespace> --runtime <runtime> --handler <handler> --file <file>
doctl serverless functions delete <function> --namespace <namespace>
doctl serverless packages list --namespace <namespace>
doctl serverless packages get <package> --namespace <namespace>
doctl serverless triggers list --namespace <namespace>
doctl serverless triggers create <trigger> --namespace <namespace> --type <type> --function <function>
doctl serverless triggers delete <trigger> --namespace <namespace>
doctl serverless logs <function> --namespace <namespace> --limit <n>

# Output Format
doctl compute droplet list -o json
doctl compute droplet list -o text
