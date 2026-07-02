# Linode CLI (linode-cli / lin) commands

# Install
pip3 install linode-cli --upgrade
# or for Ubuntu 23.04+
pipx install linode-cli

# Authentication
linode-cli configure
linode-cli configure --token

# Account
linode-cli account view
linode-cli account update
linode-cli invoices list
linode-cli invoices view <invoice-id>
linode-cli payments list

# Linodes (Compute)
linode-cli linodes list
linode-cli linodes view <linode-id>
linode-cli linodes create --label <name> --region <region> --type <type> --image <image>
linode-cli linodes create --label <name> --region us-east --type g6-standard-1 --image linode/ubuntu24.04
linode-cli linodes create --label <name> --region us-east --type g6-nanode-1 --image linode/ubuntu24.04 --authorized_keys "ssh-rsa AAAA..."
linode-cli linodes delete <linode-id>
linode-cli linodes update <linode-id> --label <new-label> --tags <tag1,tag2>
linode-cli linodes resize <linode-id> --type <new-type>
linode-cli linodes reboot <linode-id>
linode-cli linodes shutdown <linode-id>
linode-cli linodes boot <linode-id>
linode-cli linodes rescue <linode-id>
linode-cli linodes clone <linode-id> --region <region> --type <type>
linode-cli linodes migrate <linode-id> --region <region>
linode-cli linodes rebuild <linode-id> --image <image>
linode-cli linodes password <linode-id> --root_pass <password>
linode-cli linodes ssh <linode-label> -l <root>
linode-cli linodes config list <linode-id>
linode-cli linodes config create <linode-id> --label <name>
linode-cli linodes disk list <linode-id>
linode-cli linodes disk create <linode-id> --label <name> --size <size> --type ext4
linode-cli linodes disk delete <linode-id> --disk-id <disk-id>
linode-cli linodes snapshot <linode-id> --label <snapshot-name>

# IP Addresses
linode-cli linodes ips-list
linode-cli linodes ip-view <linode-id> <ip-address>
linode-cli linodes ip-update <linode-id> <ip-address> --rdns <hostname>
linode-cli linodes ip-add <linode-id> --type <ipv4|ipv6>
linode-cli linodes ip-delete <linode-id> <ip-address>

# Volumes (Block Storage)
linode-cli volumes list
linode-cli volumes view <volume-id>
linode-cli volumes create --label <name> --region <region> --size <size-gb>
linode-cli volumes delete <volume-id>
linode-cli volumes update <volume-id> --label <new-label> --size <new-size>
linode-cli volumes attach <volume-id> --linode-id <linode-id>
linode-cli volumes detach <volume-id>

# NodeBalancers (Load Balancing)
linode-cli nodebalancers list
linode-cli nodebalancers view <nodebalancer-id>
linode-cli nodebalancers create --region <region> --label <name>
linode-cli nodebalancers delete <nodebalancer-id>
linode-cli nodebalancers update <nodebalancer-id> --label <new-label>
linode-cli nodebalancers config-list <nodebalancer-id>
linode-cli nodebalancers config-create <nodebalancer-id> --port <port> --protocol <http|tcp>
linode-cli nodebalancers config-update <nodebalancer-id> --config-id <config-id> --port <port>
linode-cli nodebalancers config-delete <nodebalancer-id> --config-id <config-id>
linode-cli nodebalancers node-list <nodebalancer-id> --config-id <config-id>
linode-cli nodebalancers node-create <nodebalancer-id> --config-id <config-id> --address <ip:port> --label <name> --weight <weight>
linode-cli nodebalancers node-update <nodebalancer-id> --config-id <config-id> --node-id <node-id> --weight <weight>
linode-cli nodebalancers node-delete <nodebalancer-id> --config-id <config-id> --node-id <node-id>

# Domains (DNS)
linode-cli domains list
linode-cli domains view <domain-id>
linode-cli domains create --domain <domain> --type master --soa_email <email>
linode-cli domains delete <domain-id>
linode-cli domains records-list <domain-id>
linode-cli domains records-create <domain-id> --type A --name @ --target <ip>
linode-cli domains records-create <domain-id> --type CNAME --name www --target <target>
linode-cli domains records-create <domain-id> --type MX --name @ --target <mail-server> --priority <10>
linode-cli domains records-create <domain-id> --type TXT --name <name> --target <value>
linode-cli domains records-create <domain-id> --type NS --target <ns1.example.com>
linode-cli domains records-update <domain-id> --record-id <id> --target <new-target>
linode-cli domains records-delete <domain-id> --record-id <id>

# Firewalls
linode-cli firewalls list
linode-cli firewalls view <firewall-id>
linode-cli firewalls create --label <name> --rules-inbound <rules> --rules-outbound <rules>
linode-cli firewalls delete <firewall-id>
linode-cli firewalls update <firewall-id> --label <new-label>
linode-cli firewalls enable <firewall-id>
linode-cli firewalls disable <firewall-id>
linode-cli firewalls devices-list <firewall-id>
linode-cli firewalls device-add <firewall-id> --id <linode-id>
linode-cli firewalls device-remove <firewall-id> --device-id <device-id>
linode-cli firewalls rules-list <firewall-id>
linode-cli firewalls rules-update <firewall-id> --rules-inbound <rules> --rules-outbound <rules>

# LKE (Kubernetes)
linode-cli lke clusters-list
linode-cli lke clusters-view <cluster-id>
linode-cli lke clusters-create --label <name> --region <region> --k8s_version <version> --node_pools --type g6-standard-2 --count 3
linode-cli lke clusters-delete <cluster-id>
linode-cli lke clusters-update <cluster-id> --label <new-label>
linode-cli lke pools-list <cluster-id>
linode-cli lke pools-create <cluster-id> --type g6-standard-2 --count 3
linode-cli lke pools-view <cluster-id> --pool-id <pool-id>
linode-cli lke pools-update <cluster-id> --pool-id <pool-id> --count 5
linode-cli lke pools-delete <cluster-id> --pool-id <pool-id>
linode-cli lke kubeconfig-view <cluster-id>
linode-cli lke dashboard-url <cluster-id>

# Databases
linode-cli databases mysql-instances-list
linode-cli databases postgresql-instances-list
linode-cli databases mongodb-instances-list
linode-cli databases view <cluster-id>
linode-cli databases create --type mysql --engine <engine> --version <version> --nodes <count> --plan <plan> --region <region> --label <name>
linode-cli databases delete <cluster-id>
linode-cli databases update <cluster-id> --label <new-label>
linode-cli databases backups-list <cluster-id>
linode-cli databases credentials <cluster-id>
linode-cli databases connection-pools-list <cluster-id>
linode-cli databases connection-pools-create <cluster-id> --name <name> --database <db> --user <user>
linode-cli databases connection-pools-delete <cluster-id> --pool-id <pool-id>
linode-cli databases users-list <cluster-id>
linode-cli databases users-create <cluster-id> --username <username>
linode-cli databases users-delete <cluster-id> --username <username>
linode-cli databases ssl <cluster-id>

# Object Storage
linode-cli object-storage keys-list
linode-cli object-storage keys-create --label <name>
linode-cli object-storage keys-delete <key-id>
linode-cli object-storage clusters-list
linode-cli object-storage buckets-list --cluster <cluster-id>
linode-cli object-storage buckets-create --cluster <cluster-id> --label <bucket>
linode-cli object-storage buckets-delete --cluster <cluster-id> --label <bucket>
linode-cli object-storage objects-list --cluster <cluster-id> --bucket <bucket>
linode-cli object-storage objects-upload --cluster <cluster-id> --bucket <bucket> --name <key> --file <path>
linode-cli object-storage objects-delete --cluster <cluster-id> --bucket <bucket> --name <key>

# Images
linode-cli images list
linode-cli images view <image-id>
linode-cli images create --label <name> --region <region> --description <desc>
linode-cli images delete <image-id>
linode-cli images update <image-id> --label <new-label>

# StackScripts
linode-cli stackscripts list
linode-cli stackscripts view <script-id>
linode-cli stackscripts create --label <name> --script <script> --images <image1,image2>
linode-cli stackscripts delete <script-id>
linode-cli stackscripts update <script-id> --label <new-label>

# SSH Keys
linode-cli sshkeys list
linode-cli sshkeys view <key-id>
linode-cli sshkeys create --label <name> --public_key "ssh-rsa AAAA..."
linode-cli sshkeys delete <key-id>

# Tags
linode-cli tags list
linode-cli tags create --label <tag>
linode-cli tags delete <tag>

# VPCs
linode-cli vpcs list
linode-cli vpcs view <vpc-id>
linode-cli vpcs create --label <name> --region <region> --ipv4 <cidr>
linode-cli vpcs delete <vpc-id>
linode-cli vpcs update <vpc-id> --label <new-label>
linode-cli vpcs subnets-list <vpc-id>
linode-cli vpcs subnets-view <vpc-id> --subnet-id <subnet-id>

# Regions / Types
linode-cli regions list
linode-cli linodes types
linode-cli linodes images

# Events
linode-cli events list
linode-cli events view <event-id>

# Longview
linode-cli longview list
linode-cli longview create --label <name>
linode-cli longview delete <client-id>

# StackScripts
linode-cli stackscripts list

# Output Format
linode-cli linodes list --json
linode-cli linodes list --text
linode-cli linodes list --all

# Object Storage (S3-compatible via AWS CLI)
aws --endpoint-url https://<cluster-id>.linodeobjects.com s3 ls
aws --endpoint-url https://<cluster-id>.linodeobjects.com s3 ls s3://<bucket>
aws --endpoint-url https://<cluster-id>.linodeobjects.com s3 cp ./file.txt s3://<bucket>/file.txt
aws --endpoint-url https://<cluster-id>.linodeobjects.com s3 cp s3://<bucket>/file.txt ./file.txt
aws --endpoint-url https://<cluster-id>.linodeobjects.com s3 rm s3://<bucket>/file.txt
aws --endpoint-url https://<cluster-id>.linodeobjects.com s3 rb s3://<bucket>
aws --endpoint-url https://<cluster-id>.linodeobjects.com s3 sync ./dir s3://<bucket>/dir
aws --endpoint-url https://<cluster-id>.linodeobjects.com s3 presign s3://<bucket>/file.txt --expires-in 3600

# Marketplace
linode-cli marketplace list
linode-cli marketplace view <label>

# Shell Completions
linode-cli completion bash
linode-cli completion zsh
linode-cli completion fish
