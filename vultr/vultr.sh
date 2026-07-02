# Vultr CLI commands

# Authentication
export VULTR_API_KEY=<your-api-key>
vultr-cli account

# Instance (Compute)
vultr-cli instance list
vultr-cli instance get <instance-id>
vultr-cli instance create --region <region> --plan <plan> --os <os-id> --host <hostname>
vultr-cli instance create --region <region> --plan <plan> --os <os-id> --host <hostname> --notify=true
vultr-cli instance delete <instance-id>
vultr-cli instance start <instance-id>
vultr-cli instance stop <instance-id>
vultr-cli instance reboot <instance-id>
vultr-cli instance reinstall <instance-id>
vultr-cli instance update <instance-id> --label <new-label>
vultr-cli instance bandwidth <instance-id>

# Bare Metal
vultr-cli bare-metal list
vultr-cli bare-metal get <bare-metal-id>
vultr-cli bare-metal create --region <region> --plan <plan> --os <os-id> --hostname <hostname>
vultr-cli bare-metal delete <bare-metal-id>

# Block Storage
vultr-cli block-storage list
vultr-cli block-storage get <block-id>
vultr-cli block-storage create --region <region> --size <size-gb> --label <label>
vultr-cli block-storage delete <block-id>
vultr-cli block-storage attach <block-id> --instance <instance-id>
vultr-cli block-storage detach <block-id>

# Object Storage
vultr-cli object-storage list
vultr-cli object-storage get <cluster-id>
vultr-cli object-storage create --region <region> --label <label>
vultr-cli object-storage delete <cluster-id>
vultr-cli object-storage s3key-list <cluster-id>
vultr-cli object-storage s3key-create <cluster-id> --label <label>
vultr-cli object-storage s3key-delete <cluster-id> --s3key-id <key-id>

# Object Storage (S3-compatible via AWS CLI)
aws --endpoint-url https://<cluster-id>.vultrobjects.com s3 ls
aws --endpoint-url https://<cluster-id>.vultrobjects.com s3 ls s3://<bucket>
aws --endpoint-url https://<cluster-id>.vultrobjects.com s3 cp ./file.txt s3://<bucket>/file.txt
aws --endpoint-url https://<cluster-id>.vultrobjects.com s3 cp s3://<bucket>/file.txt ./file.txt
aws --endpoint-url https://<cluster-id>.vultrobjects.com s3 rm s3://<bucket>/file.txt
aws --endpoint-url https://<cluster-id>.vultrobjects.com s3 rb s3://<bucket>
aws --endpoint-url https://<cluster-id>.vultrobjects.com s3 sync ./dir s3://<bucket>/dir
aws --endpoint-url https://<cluster-id>.vultrobjects.com s3 presign s3://<bucket>/file.txt --expires-in 3600

# VPC / VPC2
vultr-cli vpc list
vultr-cli vpc create --region <region> --description <description>
vultr-cli vpc delete <vpc-id>
vultr-cli vpc2 list
vultr-cli vpc2 create --region <region> --description <description>

# Reserved IP
vultr-cli reserved-ip list
vultr-cli reserved-ip create --region <region> --type <type>
vultr-cli reserved-ip attach <ip-id> --instance <instance-id>
vultr-cli reserved-ip detach <ip-id>
vultr-cli reserved-ip delete <ip-id>

# DNS
vultr-cli dns domain list
vultr-cli dns domain create --domain <domain> --ip <ip>
vultr-cli dns domain delete <domain>
vultr-cli dns record list <domain>
vultr-cli dns record create <domain> --type <type> --name <name> --data <data>
vultr-cli dns record update <domain> --record-id <id> --data <new-data>
vultr-cli dns record delete <domain> --record-id <id>

# Firewall
vultr-cli firewall group list
vultr-cli firewall group create --description <description>
vultr-cli firewall group delete <group-id>
vultr-cli firewall rule list <group-id>
vultr-cli firewall rule create <group-id> --type <type> --protocol <protocol> --port <port> --subnet <subnet>
vultr-cli firewall rule delete <group-id> --rule-id <rule-id>

# Kubernetes
vultr-cli kubernetes list
vultr-cli kubernetes get <cluster-id>
vultr-cli kubernetes create --region <region> --plan <plan> --version <version> --label <label>
vultr-cli kubernetes delete <cluster-id>
vultr-cli kubernetes node-pool list <cluster-id>
vultr-cli kubernetes node-pool create <cluster-id> --plan <plan> --quantity <qty> --label <label>
vultr-cli kubernetes get-config <cluster-id>

# Database
vultr-cli database list
vultr-cli database get <db-id>
vultr-cli database create --region <region> --plan <plan> --database-engine <engine> --database-version <version> --label <label>
vultr-cli database delete <db-id>
vultr-cli database update <db-id> --label <new-label>
vultr-cli database backups list <db-id>
vultr-cli database backups restore <db-id> --backup-id <backup-id>
vultr-cli database connection-pool list <db-id>
vultr-cli database connection-pool create <db-id> --name <name> --db <db> --user <user> --size <size>
vultr-cli database connection-pool delete <db-id> --pool-id <pool-id>
vultr-cli database user list <db-id>
vultr-cli database user create <db-id> --username <user> --password <pass>
vultr-cli database user delete <db-id> --username <user>
vultr-cli database db list <db-id>
vultr-cli database db create <db-id> --name <name>
vultr-cli database db delete <db-id> --name <name>
vultr-cli database maintenance list <db-id>
vultr-cli database maintenance window <db-id> --day <day> --hour <hour>
vultr-cli database read-replica list <db-id>
vultr-cli database read-replica create <db-id> --region <region> --plan <plan>

# Load Balancer
vultr-cli load-balancer list
vultr-cli load-balancer get <lb-id>
vultr-cli load-balancer create --region <region> --label <label>
vultr-cli load-balancer delete <lb-id>
vultr-cli load-balancer add-forwarding-rule <lb-id> --front <front> --back <back>
vultr-cli load-balancer remove-forwarding-rule <lb-id> --id <rule-id>

# CDN
vultr-cli cdn list
vultr-cli cdn create --origin <origin> --label <label>
vultr-cli cdn delete <cdn-id>
vultr-cli cdn purge-cache <cdn-id>

# Container Registry
vultr-cli container-registry list
vultr-cli container-registry create --name <name>
vultr-cli container-registry delete <registry-id>

# Inference (AI)
vultr-cli inference list
vultr-cli inference create --region <region> --plan <plan>

# SSH Keys
vultr-cli ssh-key list
vultr-cli ssh-key create --name <name> --public-key <key>
vultr-cli ssh-key delete <key-id>

# Snapshots
vultr-cli snapshot list
vultr-cli snapshot create --instance <instance-id> --description <desc>
vultr-cli snapshot delete <snapshot-id>

# Startup Scripts
vultr-cli script list
vultr-cli script create --name <name> --type <type> --content <content>
vultr-cli script delete <script-id>

# ISO
vultr-cli iso list
vultr-cli iso delete <iso-id>

# Users
vultr-cli user list
vultr-cli user create --email <email> --password <password> --api-enabled=<true/false>
vultr-cli user delete <user-id>

# Billing
vultr-cli billing list
vultr-cli billing pending list

# Plans / Regions / OS
vultr-cli plans list
vultr-cli regions list
vultr-cli os list
vultr-cli apps list
vultr-cli backups list <instance-id>
vultr-cli marketplace list

# Logs
vultr-cli logs instance <instance-id>

# Log Forwarding
vultr-cli log-forwarding list
vultr-cli log-forwarding create --region <region> --destination <destination> --port <port> --public-key <key> --private-key <key> --hostname <hostname> --ip4 <ip>
vultr-cli log-forwarding delete <id>
vultr-cli log-forwarding logs <id>

# Shell Completions
vultr-cli completion bash
vultr-cli completion zsh
vultr-cli completion fish
vultr-cli completion powershell

# Config
vultr-cli --config /path/to/vultr-cli.yaml <command>

# Output Format
vultr-cli instance list -o json
vultr-cli instance list -o yaml
