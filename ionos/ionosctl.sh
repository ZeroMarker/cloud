# IONOS CLI (ionosctl) commands — managed-friendly

# Authentication
ionosctl login
ionosctl logout
ionosctl whoami

# Datacenter
ionosctl datacenter list
ionosctl datacenter get --datacenter-id DATACENTER_ID
ionosctl datacenter create --name DC_NAME --location de/txl
ionosctl datacenter update --datacenter-id DATACENTER_ID --name NEW_NAME
ionosctl datacenter delete --datacenter-id DATACENTER_ID

# Server
ionosctl server list --datacenter-id DATACENTER_ID
ionosctl server get --datacenter-id DATACENTER_ID --server-id SERVER_ID
ionosctl server create --datacenter-id DATACENTER_ID --name my-server --cores 2 --ram 4096 --availability-zone AUTO
ionosctl server update --datacenter-id DATACENTER_ID --server-id SERVER_ID --name new-name --cores 4 --ram 8192
ionosctl server delete --datacenter-id DATACENTER_ID --server-id SERVER_ID
ionosctl server start --datacenter-id DATACENTER_ID --server-id SERVER_ID
ionosctl server stop --datacenter-id DATACENTER_ID --server-id SERVER_ID
ionosctl server reboot --datacenter-id DATACENTER_ID --server-id SERVER_ID
ionosctl server rebuild --datacenter-id DATACENTER_ID --server-id SERVER_ID --image-id IMAGE_ID

# Volume
ionosctl volume list --datacenter-id DATACENTER_ID
ionosctl volume get --datacenter-id DATACENTER_ID --volume-id VOLUME_ID
ionosctl volume create --datacenter-id DATACENTER_ID --name VOL_NAME --size 50 --type HDD --licence-type LINUX
ionosctl volume update --datacenter-id DATACENTER_ID --volume-id VOLUME_ID --name NEW_NAME --size 100
ionosctl volume delete --datacenter-id DATACENTER_ID --volume-id VOLUME_ID
ionosctl volume attach --datacenter-id DATACENTER_ID --volume-id VOLUME_ID --server-id SERVER_ID
ionosctl volume detach --datacenter-id DATACENTER_ID --volume-id VOLUME_ID

# LAN
ionosctl lan list --datacenter-id DATACENTER_ID
ionosctl lan get --datacenter-id DATACENTER_ID --lan-id LAN_ID
ionosctl lan create --datacenter-id DATACENTER_ID --name LAN_NAME --public true
ionosctl lan update --datacenter-id DATACENTER_ID --lan-id LAN_ID --name NEW_NAME --public false
ionosctl lan delete --datacenter-id DATACENTER_ID --lan-id LAN_ID

# NIC
ionosctl nic list --datacenter-id DATACENTER_ID --server-id SERVER_ID
ionosctl nic get --datacenter-id DATACENTER_ID --server-id SERVER_ID --nic-id NIC_ID
ionosctl nic create --datacenter-id DATACENTER_ID --server-id SERVER_ID --name NIC_NAME --lan LAN_ID --ip 10.0.0.10
ionosctl nic update --datacenter-id DATACENTER_ID --server-id SERVER_ID --nic-id NIC_ID --name NEW_NAME --ip 10.0.0.20
ionosctl nic delete --datacenter-id DATACENTER_ID --server-id SERVER_ID --nic-id NIC_ID

# IP Block
ionosctl ipblock list
ionosctl ipblock get --ipblock-id IPBLOCK_ID
ionosctl ipblock create --ipblock-count 1 --location de/txl
ionosctl ipblock release --ipblock-id IPBLOCK_ID

# Firewall Rules
ionosctl firewallrule list --datacenter-id DATACENTER_ID --server-id SERVER_ID --nic-id NIC_ID
ionosctl firewallrule get --datacenter-id DATACENTER_ID --server-id SERVER_ID --nic-id NIC_ID --firewallrule-id FW_ID
ionosctl firewallrule create --datacenter-id DATACENTER_ID --server-id SERVER_ID --nic-id NIC_ID --name "Allow HTTP" --protocol TCP --port-range 80 --source-ip "0.0.0.0" --target-ip "10.0.0.10"
ionosctl firewallrule update --datacenter-id DATACENTER_ID --server-id SERVER_ID --nic-id NIC_ID --firewallrule-id FW_ID --name "Allow HTTPS" --port-range 443
ionosctl firewallrule delete --datacenter-id DATACENTER_ID --server-id SERVER_ID --nic-id NIC_ID --firewallrule-id FW_ID

# Load Balancer
ionosctl loadbalancer list --datacenter-id DATACENTER_ID
ionosctl loadbalancer get --datacenter-id DATACENTER_ID --loadbalancer-id LB_ID
ionosctl loadbalancer create --datacenter-id DATACENTER_ID --name LB_NAME --ip 10.0.0.5 --dhcp true
ionosctl loadbalancer update --datacenter-id DATACENTER_ID --loadbalancer-id LB_ID --name NEW_NAME
ionosctl loadbalancer delete --datacenter-id DATACENTER_ID --loadbalancer-id LB_ID

# Application Load Balancer
ionosctl applicationloadbalancer list --datacenter-id DATACENTER_ID
ionosctl applicationloadbalancer get --datacenter-id DATACENTER_ID --alb-id ALB_ID
ionosctl applicationloadbalancer create --datacenter-id DATACENTER_ID --name ALB_NAME --ips 10.0.0.100
ionosctl applicationloadbalancer update --datacenter-id DATACENTER_ID --alb-id ALB_ID --name NEW_NAME
ionosctl applicationloadbalancer delete --datacenter-id DATACENTER_ID --alb-id ALB_ID

# Target Group (ALB)
ionosctl targetgroup list
ionosctl targetgroup get --targetgroup-id TG_ID
ionosctl targetgroup create --name TG_NAME --protocol HTTP --port 80 --balance-connections true
ionosctl targetgroup update --targetgroup-id TG_ID --name NEW_NAME --port 443
ionosctl targetgroup delete --targetgroup-id TG_ID
ionosctl targetgroup add-server --targetgroup-id TG_ID --server-id SERVER_ID --port 8080
ionosctl targetgroup remove-server --targetgroup-id TG_ID --server-id SERVER_ID

# Kubernetes
ionosctl k8s cluster list
ionosctl k8s cluster get --cluster-id CLUSTER_ID
ionosctl k8s cluster create --name K8S_NAME --k8s-version 1.27
ionosctl k8s cluster delete --cluster-id CLUSTER_ID
ionosctl k8s cluster update --cluster-id CLUSTER_ID --name NEW_NAME
ionosctl k8s nodepool list --cluster-id CLUSTER_ID
ionosctl k8s nodepool get --cluster-id CLUSTER_ID --nodepool-id NP_ID
ionosctl k8s nodepool create --cluster-id CLUSTER_ID --name NP_NAME --node-count 3 --node-size Small
ionosctl k8s nodepool update --cluster-id CLUSTER_ID --nodepool-id NP_ID --node-count 5
ionosctl k8s nodepool delete --cluster-id CLUSTER_ID --nodepool-id NP_ID
ionosctl k8s kubeconfig get --cluster-id CLUSTER_ID

# DBaaS PostgreSQL
ionosctl dbaas postgres cluster list
ionosctl dbaas postgres cluster get --cluster-id CLUSTER_ID
ionosctl dbaas postgres cluster create --name DB_NAME --cores 2 --ram 4 --storage-size 50 --connections 100
ionosctl dbaas postgres cluster delete --cluster-id CLUSTER_ID
ionosctl dbaas postgres cluster update --cluster-id CLUSTER_ID --cores 4 --ram 8
ionosctl dbaas postgres backup list --cluster-id CLUSTER_ID
ionosctl dbaas postgres backup restore --cluster-id CLUSTER_ID --backup-id BACKUP_ID
ionosctl dbaas postgres user list --cluster-id CLUSTER_ID
ionosctl dbaas postgres user create --cluster-id CLUSTER_ID --username USER --password PASS
ionosctl dbaas postgres user delete --cluster-id CLUSTER_ID --username USER
ionosctl dbaas postgres database list --cluster-id CLUSTER_ID
ionosctl dbaas postgres database create --cluster-id CLUSTER_ID --name DB_NAME
ionosctl dbaas postgres database delete --cluster-id CLUSTER_ID --name DB_NAME

# DNS
ionosctl dns zone list
ionosctl dns zone get --zone-id ZONE_ID
ionosctl dns zone create --zoneName example.com
ionosctl dns zone delete --zone-id ZONE_ID
ionosctl dns record list --zone-id ZONE_ID
ionosctl dns record get --zone-id ZONE_ID --record-id RECORD_ID
ionosctl dns record create --zone-id ZONE_ID --type A --name @ --content 1.2.3.4 --ttl 3600
ionosctl dns record update --zone-id ZONE_ID --record-id RECORD_ID --content 5.6.7.8
ionosctl dns record delete --zone-id ZONE_ID --record-id RECORD_ID

# Snapshots
ionosctl snapshot list --datacenter-id DATACENTER_ID
ionosctl snapshot get --datacenter-id DATACENTER_ID --snapshot-id SNAPSHOT_ID
ionosctl snapshot create --datacenter-id DATACENTER_ID --server-id SERVER_ID --name SNAPSHOT_NAME
ionosctl snapshot restore --datacenter-id DATACENTER_ID --snapshot-id SNAPSHOT_ID --server-id SERVER_ID
ionosctl snapshot delete --datacenter-id DATACENTER_ID --snapshot-id SNAPSHOT_ID
ionosctl snapshot update --datacenter-id DATACENTER_ID --snapshot-id SNAPSHOT_ID --name NEW_NAME
