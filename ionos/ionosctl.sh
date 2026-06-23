# IONOS: managed-friendly

ionosctl login

ionosctl whoami

ionosctl datacenter list

ionosctl datacenter get --datacenter-id DATACENTER_ID

ionosctl server list --datacenter-id DATACENTER_ID

ionosctl server get --datacenter-id DATACENTER_ID --server-id SERVER_ID

ionosctl server create --datacenter-id DATACENTER_ID --name my-server --cores 2 --ram 4096 --availability-zone AUTO

ionosctl volume list --datacenter-id DATACENTER_ID

ionosctl lan list --datacenter-id DATACENTER_ID

ionosctl ipblock list

ionosctl firewallrule list --datacenter-id DATACENTER_ID --server-id SERVER_ID --nic-id NIC_ID

ionosctl applicationloadbalancer list --datacenter-id DATACENTER_ID

ionosctl k8s cluster list

ionosctl dbaas postgres cluster list

ionosctl dns zone list
