# Huawei Cloud CLI (hcloud) commands

# Configuration
hcloud configure init
hcloud configure list

# ECS (Elastic Cloud Server)
hcloud ECS NovaListServers
hcloud ECS NovaShowServer --server_id <server-id>
hcloud ECS NovaCreateServers --cli-jsonInput ecs-create-server.json
hcloud ECS NovaDeleteServer --server_id <server-id>
hcloud ECS NovaStartServer --server_id <server-id>
hcloud ECS NovaStopServer --server_id <server-id>
hcloud ECS NovaRebootServer --server_id <server-id>
hcloud ECS NovaResizeServer --server_id <server-id> --flavor_id <flavor-id>
hcloud ECS NovaCreateServerSnapshot --server_id <server-id> --name <snapshot-name>

# EVS (Elastic Volume Service)
hcloud EVS CinderListVolumes
hcloud EVS CinderShowVolume --volume_id <volume-id>
hcloud EVS CinderCreateVolume --size <size-gb> --volume_type <type> --name <name>
hcloud EVS CinderDeleteVolume --volume_id <volume-id>
hcloud EVS CinderAttachVolume --volume_id <volume-id> --instance_id <server-id>
hcloud EVS CinderDetachVolume --volume_id <volume-id>
hcloud EVS CinderResizeVolume --volume_id <volume-id> --size <new-size-gb>

# VPC (Virtual Private Cloud)
hcloud VPC ListVpcs
hcloud VPC ShowVpc --vpc_id <vpc-id>
hcloud VPC CreateVpc --name <name> --cidr <cidr>
hcloud VPC DeleteVpc --vpc_id <vpc-id>
hcloud VPC ListSubnets
hcloud VPC ShowSubnet --subnet_id <subnet-id>
hcloud VPC CreateSubnet --vpc_id <vpc-id> --name <name> --cidr <cidr>
hcloud VPC DeleteSubnet --subnet_id <subnet-id>
hcloud VPC ListSecurityGroups
hcloud VPC ShowSecurityGroup --security_group_id <sg-id>
hcloud VPC CreateSecurityGroup --vpc_id <vpc-id> --name <name>
hcloud VPC DeleteSecurityGroup --security_group_id <sg-id>
hcloud VPC CreateSecurityGroupRule --security_group_id <sg-id> --direction ingress --protocol tcp --port_range 80 --remote_ip_prefix 0.0.0.0/0
hcloud VPC DeleteSecurityGroupRule --security_group_rule_id <rule-id>

# NAT Gateway
hcloud NAT ListNatGateways
hcloud NAT ShowNatGateway --nat_gateway_id <nat-gw-id>
hcloud NAT CreateNatGateway --vpc_id <vpc-id> --name <name>
hcloud NAT DeleteNatGateway --nat_gateway_id <nat-gw-id>
hcloud NAT ListSnatRules --nat_gateway_id <nat-gw-id>
hcloud NAT CreateSnatRule --nat_gateway_id <nat-gw-id> --floating_ip_id <eip-id> --network_id <subnet-id>
hcloud NAT DeleteSnatRule --snat_rule_id <rule-id>
hcloud NAT ListDnatRules --nat_gateway_id <nat-gw-id>
hcloud NAT CreateDnatRule --nat_gateway_id <nat-gw-id> --floating_ip_id <eip-id> --port <port> --private_ip <ip> --protocol tcp
hcloud NAT DeleteDnatRule --dnat_rule_id <rule-id>

# ELB (Elastic Load Balancer)
hcloud ELB ListLoadBalancers
hcloud ELB ShowLoadBalancer --loadbalancer_id <lb-id>
hcloud ELB CreateLoadBalancer --name <name> --vpc_id <vpc-id> --listeners '{"protocol":"HTTP","port":80}'
hcloud ELB DeleteLoadBalancer --loadbalancer_id <lb-id>
hcloud ELB ListListeners --loadbalancer_id <lb-id>
hcloud ELB CreateListener --loadbalancer_id <lb-id> --protocol HTTP --port 80
hcloud ELB DeleteListener --listener_id <listener-id>
hcloud ELB ListMembers --listener_id <listener-id>
hcloud ELB AddMembers --listener_id <listener-id> --members '[{"address":"10.0.0.10","port":8080}]'
hcloud ELB RemoveMembers --listener_id <listener-id> --members '[{"address":"10.0.0.10"}]'

# OBS (Object Storage Service)
hcloud OBS ListBuckets
hcloud OBS CreateBucket --bucket <bucket-name>
hcloud OBS DeleteBucket --bucket <bucket-name>
hcloud OBS ListObjects --bucket <bucket-name>
hcloud OBS PutObject --bucket <bucket-name> --key <key> --file <local-file>
hcloud OBS GetObject --bucket <bucket-name> --key <key> --output <local-file>
hcloud OBS DeleteObject --bucket <bucket-name> --key <key>
hcloud OBS SetBucketPolicy --bucket <bucket-name> --policy-file <policy.json>

# RDS (Relational Database Service)
hcloud RDS ListInstances
hcloud RDS ShowInstance --instance_id <db-id>
hcloud RDS CreateInstance --name <name> --flavor <flavor> --volume_size <gb> --datastore_type mysql --password <pass>
hcloud RDS DeleteInstance --instance_id <db-id>
hcloud RDS ListBackups --instance_id <db-id>
hcloud RDS CreateBackup --instance_id <db-id> --backup_name <name>
hcloud RDS RestoreBackup --instance_id <db-id> --backup_id <backup-id>
hcloud RDS ListParameters --instance_id <db-id>
hcloud RDS UpdateParameter --instance_id <db-id> --param_file <params.json>

# FunctionGraph (Serverless)
hcloud FunctionGraph ListFunctions
hcloud FunctionGraph ShowFunction --function_urn <function-urn>
hcloud FunctionGraph CreateFunction --func_name <name> --handler <handler> --runtime Python3.9 --code_type zip --file <code.zip>
hcloud FunctionGraph DeleteFunction --function_urn <function-urn>
hcloud FunctionGraph InvokeFunction --function_urn <function-urn> --input '{"key":"value"}'
hcloud FunctionGraph ListTriggers --function_urn <function-urn>
hcloud FunctionGraph CreateTrigger --function_urn <function-urn> --trigger_type TIMER --event_id <timer-id>
hcloud FunctionGraph DeleteTrigger --function_urn <function-urn> --trigger_type TIMER --event_id <timer-id>

# CCE (Cloud Container Engine - Kubernetes)
hcloud CCE ListClusters
hcloud CCE ShowCluster --cluster_id <cluster-id>
hcloud CCE CreateCluster --name <name> --flavor <flavor> --version 1.27 --vpc_id <vpc-id> --subnet_id <subnet-id>
hcloud CCE DeleteCluster --cluster_id <cluster-id>
hcloud CCE ListNodePools --cluster_id <cluster-id>
hcloud CCE CreateNodePool --cluster_id <cluster-id> --name <pool-name> --flavor <flavor> --initial_node_count 3
hcloud CCE DeleteNodePool --cluster_id <cluster-id> --nodepool_id <pool-id>
hcloud CCE ResizeNodePool --cluster_id <cluster-id> --nodepool_id <pool-id> --count 5
hcloud CCE GetClusterConfig --cluster_id <cluster-id>

# DNS
hcloud DNS ListPublicZones
hcloud DNS ShowPublicZone --zone_id <zone-id>
hcloud DNS CreatePublicZone --name <domain>
hcloud DNS DeletePublicZone --zone_id <zone-id>
hcloud DNS ListRecordSets --zone_id <zone-id>
hcloud DNS CreateRecordSet --zone_id <zone-id> --type A --name <subdomain> --records '<ip>' --ttl 300
hcloud DNS DeleteRecordSet --zone_id <zone-id> --recordset_id <record-id>
hcloud DNS ListPrivateZones
hcloud DNS CreatePrivateZone --name <domain> --vpc_id <vpc-id>

# Cloud Eye (Monitoring)
hcloud CES ListAlarms
hcloud CES CreateAlarm --alarm_name <name> --resources '[{"type":"AWS/EC2","dimensions":[{"name":"instanceId","value":"<id>"}]}]'
hcloud CES DeleteAlarm --alarm_id <alarm-id>
hcloud CES ListMetrics --namespace ECS
hcloud CES GetMetricData --namespace ECS --metric_name CPUUtilization --dimensions '[{"name":"instanceId","value":"<id>"}]'

# IAM
hcloud IAM ListUsers
hcloud IAM ShowUser --user_id <user-id>
hcloud IAM CreateUser --name <name> --password <password>
hcloud IAM DeleteUser --user_id <user-id>
hcloud IAM ListGroups
hcloud IAM CreateGroup --name <group-name>
hcloud IAM DeleteGroup --group_id <group-id>
hcloud IAM AddUserToGroup --user_id <user-id> --group_id <group-id>
hcloud IAM ListProjects

# Images
hcloud IMS ListImages
hcloud IMS ShowImage --image_id <image-id>
hcloud IMS CreateImage --name <name> --instance_id <server-id>
hcloud IMS DeleteImage --image_id <image-id>

# EIP (Elastic IP)
hcloud VPC ListPublicIps
hcloud VPC AssociatePublicIp --public_ip_id <eip-id> --instance_id <server-id> --port_id <port-id>
hcloud VPC DisassociatePublicIp --public_ip_id <eip-id>
hcloud VPC CreatePublicIp --type 5_bgp --bandwidth_name <name> --bandwidth_size <mbps>
hcloud VPC DeletePublicIp --public_ip_id <eip-id>
