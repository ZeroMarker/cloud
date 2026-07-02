# Hetzner Cloud (hcloud) CLI commands

# Install
brew install hetzner-cli/hcloud/hcloud
# or
curl -L https://github.com/hetznercloud/cli/releases/latest/download/hcloud-linux-amd64.tar.gz | tar xz
sudo mv hcloud-linux-amd64 /usr/local/bin/hcloud

# Authentication
export HCLOUD_TOKEN=<token>
hcloud context create my-context
hcloud context use my-context
hcloud context active
hcloud context delete my-context

# Servers (Compute)
hcloud server list
hcloud server describe <server>
hcloud server create --name <name> --type <type> --image <image> --location <location>
hcloud server create --name my-server --type cx11 --image ubuntu-22.04 --location fsn1
hcloud server create --name my-server --type cax11 --image ubuntu-22.04 --location fsn1 --ssh-key <key>
hcloud server delete <server>
hcloud server poweron <server>
hcloud server poweroff <server>
hcloud server shutdown <server>
hcloud server reboot <server>
hcloud server reset <server>
hcloud server reset-password <server>
hcloud server rename <server> --to <new-name>
hcloud server update <server> --name <new-name>
hcloud server enable-backups <server>
hcloud server disable-backups <server>
hcloud server rebuild <server> --image <image>
hcloud server attach-to-network <server> --network <network> --ip 10.0.0.1
hcloud server detach-from-network <server> --network <network>
hcloud server ssh <server>

# Server Types
hcloud server-type list
hcloud server-type describe <type>

# Images
hcloud image list
hcloud image describe <image>
hcloud image delete <image>
hcloud image update <image> --description <desc>
hcloud image enable-protection <image> --level yes
hcloud image disable-protection <image> --level yes

# SSH Keys
hcloud ssh-key list
hcloud ssh-key describe <key>
hcloud ssh-key create --name <name> --public-key "ssh-rsa AAAA..."
hcloud ssh-key delete <key>
hcloud ssh-key update <key> --name <new-name>

# Volumes (Block Storage)
hcloud volume list
hcloud volume describe <volume>
hcloud volume create --name <name> --size <size> --location <location>
hcloud volume create --name my-volume --size 50 --location fsn1
hcloud volume delete <volume>
hcloud volume resize <volume> --size <new-size>
hcloud volume attach <volume> --server <server>
hcloud volume detach <volume>
hcloud volume enable-protection <volume>
hcloud volume disable-protection <volume>

# Floating IPs
hcloud floating-ip list
hcloud floating-ip describe <ip>
hcloud floating-ip create --type ipv4 --location <location>
hcloud floating-ip delete <ip>
hcloud floating-ip assign <ip> <server>
hcloud floating-ip unassign <ip>
hcloud floating-ip enable-protection <ip>
hcloud floating-ip disable-protection <ip>

# Networks (Private)
hcloud network list
hcloud network describe <network>
hcloud network create --name <name> --ip-range 10.0.0.0/16
hcloud network create --name my-network --ip-range 10.0.0.0/16
hcloud network delete <network>
hcloud network update <network> --name <new-name>
hcloud network add-subnet <network> --type server --network-zone eu-central --ip-range 10.0.1.0/24
hcloud network remove-subnet <network> --ip-range 10.0.1.0/24
hcloud network add-route <network> --destination 10.10.0.0/16 --gateway 10.0.1.1
hcloud network remove-route <network> --destination 10.10.0.0/16 --gateway 10.0.1.1
hcloud network enable-protection <network>
hcloud network disable-protection <network>

# Load Balancers
hcloud load-balancer list
hcloud load-balancer describe <lb>
hcloud load-balancer create --name <name> --type lb11 --location <location>
hcloud load-balancer create --name my-lb --type lb11 --location fsn1
hcloud load-balancer delete <lb>
hcloud load-balancer update <lb> --name <new-name>
hcloud load-balancer enable-protection <lb>
hcloud load-balancer disable-protection <lb>
hcloud load-balancer add-server <lb> --server <server>
hcloud load-balancer remove-server <lb> --server <server>
hcloud load-balancer add-target <lb> --type server --server <server>
hcloud load-balancer remove-target <lb> --type server --server <server>
hcloud load-balancer add-service <lb> --protocol http --http-port 80 --http-sticky-sessions=false --health-check-http-port 80 --health-check-http-path /
hcloud load-balancer remove-service <lb> --protocol http --http-port 80
hcloud load-balancer add-listener <lb> --protocol tcp --listen-port 80 --destination-port 80
hcloud load-balancer remove-listener <lb> --protocol tcp --listen-port 80
hcloud load-balancer-type list
hcloud load-balancer-type describe <type>

# Firewalls
hcloud firewall list
hcloud firewall describe <fw>
hcloud firewall create --name <name>
hcloud firewall create --name my-fw
hcloud firewall delete <fw>
hcloud firewall update <fw> --name <new-name>
hcloud firewall add-rule <fw> --direction in --protocol tcp --port 80 --source-ips 0.0.0.0/0
hcloud firewall add-rule <fw> --direction in --protocol tcp --port 22 --source-ips 0.0.0.0/0
hcloud firewall add-rule <fw> --direction in --protocol tcp --port 80 --destination-ips 10.0.0.0/8
hcloud firewall remove-rule <fw> --direction in --protocol tcp --port 80 --source-ips 0.0.0.0/0
hcloud firewall apply-to-server <fw> --server <server>
hcloud firewall remove-from-server <fw> --server <server>
hcloud firewall apply-to-label-selector <fw> --label-selector env=prod

# Floating IPs
hcloud floating-ip enable-protection <ip>
hcloud floating-ip disable-protection <ip>

# Certificates (SSL/TLS)
hcloud certificate list
hcloud certificate describe <cert>
hcloud certificate create --name <name> --type managed --domain <domain> --domain <www-domain>
hcloud certificate create --name <name> --type uploaded --certificate-file <cert-file> --key-file <key-file>
hcloud certificate delete <cert>
hcloud certificate update <cert> --name <new-name>

# Primary IPs
hcloud primary-ip list
hcloud primary-ip describe <ip>
hcloud primary-ip create --name <name> --type ipv4 --location <location> --assignee-type server
hcloud primary-ip delete <ip>
hcloud primary-ip assign <ip> --server <server>
hcloud primary-ip unassign <ip>
hcloud primary-ip enable-protection <ip>
hcloud primary-ip disable-protection <ip>

# Locations / Datacenters
hcloud location list
hcloud location describe <location>
hcloud datacenter list
hcloud datacenter describe <datacenter>

# ISOs
hcloud iso list
hcloud iso describe <iso>

# Images (Snapshot/Backup)
hcloud image list --type snapshot
hcloud image list --type backup
hcloud image create --server <server> --type snapshot --description <desc>

# Server Actions
hcloud server action list <server>
hcloud server action describe <server> --action-id <id>

# Labels
hcloud server add-label <server> env=prod
hcloud server remove-label <server> env
hcloud server list --label-selector env=prod

# Protection
hcloud server enable-protection <server> --level delete
hcloud server disable-protection <server> --level delete

# Output
hcloud server list -o columns=id,name,status,ipv4
hcloud server list -o json

# Placement Groups
hcloud placement-group list
hcloud placement-group describe <group>
hcloud placement-group create --name <name> --type spread
hcloud placement-group create --name <name> --type fill
hcloud placement-group delete <group>
hcloud placement-group update <group> --name <new-name>
hcloud server create --name <name> --type <type> --image <image> --location <location> --placement-group <group>

# Robot (Dedicated Servers)
hcloud server describe <robot-id>
hcloud server update <robot-id> --name <new-name>
hcloud server enable-rescue <robot-id> --type linux64 --ssh-keys <key-id>
hcloud server reset <robot-id>
hcloud server rebuild <robot-id> --image <image-id>

# Pagination
hcloud server list --page 1 --per-page 10
