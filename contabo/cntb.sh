# Contabo CLI (cntb) commands — low-cost VPS

# Authentication
cntb config set-credentials --oauth2-clientid CLIENT_ID --oauth2-client-secret CLIENT_SECRET --oauth2-user API_USER --oauth2-password API_PASSWORD

cntb help

# Instances
cntb get instances
cntb get instance INSTANCE_ID
cntb create instance --imageId IMAGE_ID --productId PRODUCT_ID --region EU --sshKeys SSH_KEY_ID
cntb delete instance INSTANCE_ID
cntb update instance INSTANCE_ID --productId NEW_PRODUCT_ID
cntb start instance INSTANCE_ID
cntb stop instance INSTANCE_ID
cntb restart instance INSTANCE_ID

# Products / Regions
cntb get products
cntb get regions

# Images
cntb get images

# SSH Keys
cntb get ssh-keys
cntb create ssh-key --name KEY_NAME --publicKey "ssh-rsa AAAA..."
cntb delete ssh-key SSH_KEY_ID

# Private Networks
cntb get private-networks
cntb create private-network --name NETWORK_NAME --region EU
cntb delete private-network NETWORK_ID
cntb attach private-network INSTANCE_ID NETWORK_ID
cntb detach private-network INSTANCE_ID NETWORK_ID

# Object Storage
cntb get object-storages
cntb create object-storage --region EU
cntb delete object-storage STORAGE_ID
cntb get object-storage-credentials STORAGE_ID
cntb create object-storage-credential STORAGE_ID --name CRED_NAME
cntb delete object-storage-credential STORAGE_ID CRED_ID

# Load Balancers
cntb get load-balancers
cntb create load-balancer --name LB_NAME --region EU --targets TARGET_INSTANCE_IDS
cntb delete load-balancer LB_ID
cntb add target load-balancer LB_ID --instanceId INSTANCE_ID
cntb remove target load-balancer LB_ID --instanceId INSTANCE_ID

# Firewall
cntb get firewalls
cntb create firewall --name FW_NAME --rules '{"ingress":[{"protocol":"tcp","port_from":80,"port_to":80,"cidr":"0.0.0.0/0"}]}'
cntb delete firewall FW_ID
cntb add rule firewall FW_ID --direction ingress --protocol tcp --portFrom 80 --portTo 80 --cidr "0.0.0.0/0"
cntb remove rule firewall FW_ID --ruleId RULE_ID
cntb attach firewall FW_ID --instanceId INSTANCE_ID
cntb detach firewall FW_ID --instanceId INSTANCE_ID

# Snapshots
cntb get snapshots
cntb create snapshot INSTANCE_ID --name SNAPSHOT_NAME
cntb delete snapshot SNAPSHOT_ID
cntb restore snapshot SNAPSHOT_ID
