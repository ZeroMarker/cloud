# Tencent Cloud CLI (tencentcloud) commands

# Configuration
tencentcloud configure
tencentcloud configure list

# CVM (Cloud Virtual Machine)
tencentcloud cvm DescribeInstances
tencentcloud cvm DescribeInstanceStatus --zone ap-guangzhou-6
tencentcloud cvm DescribeInstanceAttributes --InstanceIds '["ins-xxxxxx"]'
tencentcloud cvm RunInstances --Placement.Zone ap-guangzhou-6 --InstanceType S5.MEDIUM2 --ImageId img-pi0ii46r
tencentcloud cvm TerminateInstances --InstanceIds '["ins-xxxxxx"]'
tencentcloud cvm StartInstances --InstanceIds '["ins-xxxxxx"]'
tencentcloud cvm StopInstances --InstanceIds '["ins-xxxxxx"]'
tencentcloud cvm RebootInstances --InstanceIds '["ins-xxxxxx"]'
tencentcloud cvm ResetInstance --InstanceId ins-xxxxxx --ImageId img-pi0ii46r
tencentcloud cvm ResizeInstance --InstanceId ins-xxxxxx --InstanceType S5.LARGE8
tencentcloud cvm DescribeInstanceVncUrl --InstanceId ins-xxxxxx

# CVM - Key Pairs
tencentcloud cvm DescribeKeyPairs
tencentcloud cvm ImportKeyPair --KeyName mykey --PublicKey "ssh-rsa AAAA..."
tencentcloud cvm DeleteKeyPairs --KeyIds '["skey-xxxxxx"]'

# CVM - Security Groups
tencentcloud cvm DescribeSecurityGroups
tencentcloud cvm DescribeSecurityGroupAttribute --SecurityGroupId sg-xxxxxx
tencentcloud cvm CreateSecurityGroup --GroupName my-sg --GroupDescription "desc" --VpcId vpc-xxxxxx
tencentcloud cvm DeleteSecurityGroups --SecurityGroupIds '["sg-xxxxxx"]'
tencentcloud cvm CreateSecurityGroupPolicy --SecurityGroupId sg-xxxxxx --SecurityGroupPolicySet.Version 1 --SecurityGroupPolicySet.Ingress '[{"Protocol":"tcp","Port":"80","CidrBlock":"0.0.0.0/0","Action":"accept"}]'
tencentcloud cvm DeleteSecurityGroupPolicy --SecurityGroupId sg-xxxxxx --SecurityGroupPolicySet.Version 1 --SecurityGroupPolicySet.Ingress '[{"Protocol":"tcp","Port":"80","CidrBlock":"0.0.0.0/0","Action":"accept"}]'

# CBS (Cloud Block Storage)
tencentcloud cbs DescribeDisks
tencentcloud cbs DescribeDiskAttributes --DiskIds '["disk-xxxxxx"]'
tencentcloud cbs CreateDisk --DiskType CLOUD_PREMIUM --DiskSize 100 --Zone ap-guangzhou-6
tencentcloud cbs TerminateDisks --DiskIds '["disk-xxxxxx"]'
tencentcloud cbs ResizeDisk --DiskId disk-xxxxxx --DiskSize 200
tencentcloud cbs AttachDisk --InstanceId ins-xxxxxx --DiskId disk-xxxxxx --DeleteWithInstance true
tencentcloud cbs DetachDisk --InstanceId ins-xxxxxx --DiskId disk-xxxxxx
tencentcloud cbs CreateSnapshot --DiskId disk-xxxxxx --SnapshotName my-snap
tencentcloud cbs DescribeSnapshots --DiskId disk-xxxxxx
tencentcloud cbs ApplySnapshot --DiskId disk-xxxxxx --SnapshotId snap-xxxxxx
tencentcloud cbs DeleteSnapshots --SnapshotIds '["snap-xxxxxx"]'

# VPC (Virtual Private Cloud)
tencentcloud vpc DescribeVpcs
tencentcloud vpc DescribeVpcAttributes --VpcId vpc-xxxxxx
tencentcloud vpc CreateVpc --CidrBlock 10.0.0.0/16 --VpcName my-vpc
tencentcloud vpc DeleteVpc --VpcId vpc-xxxxxx
tencentcloud vpc DescribeSubnets --VpcId vpc-xxxxxx
tencentcloud vpc CreateSubnet --VpcId vpc-xxxxxx --CidrBlock 10.0.1.0/24 --SubnetName my-subnet --Zone ap-guangzhou-6
tencentcloud vpc DeleteSubnet --SubnetId subnet-xxxxxx
tencentcloud vpc DescribeRouteTables --VpcId vpc-xxxxxx
tencentcloud vpc CreateRouteTable --VpcId vpc-xxxxxx --RouteTableName my-rt
tencentcloud vpc DeleteRouteTable --RouteTableId rtb-xxxxxx
tencentcloud vpc CreateRoute --RouteTableId rtb-xxxxxx --DestinationCidrBlock 0.0.0.0/0 --GatewayType NEXT_HOP && --NextHopType CVM && --NextHop "ins-xxxxxx"

# VPC - NAT Gateway
tencentcloud vpc DescribeNatGateways --VpcId vpc-xxxxxx
tencentcloud vpc CreateNatGateway --VpcId vpc-xxxxxx --NatGatewayName my-nat --Type 1
tencentcloud vpc DeleteNatGateway --NatGatewayId nat-xxxxxx
tencentcloud vpc DescribeNatGatewayDestinationIpFilters --NatGatewayId nat-xxxxxx
tencentcloud vpc CreateNatGatewayDestinationIpFilter --NatGatewayId nat-xxxxxx --Ip 1.2.3.4
tencentcloud vpc DeleteNatGatewayDestinationIpFilter --NatGatewayId nat-xxxxxx --Ip 1.2.3.4

# CLB (Cloud Load Balancer)
tencentcloud clb DescribeLoadBalancers
tencentcloud clb DescribeLoadBalancerAttributes --LoadBalancerId lb-xxxxxx
tencentcloud clb CreateLoadBalancer --LoadBalancerType 1 --VpcId vpc-xxxxxx --LoadBalancerName my-clb
tencentcloud clb DeleteLoadBalancers --LoadBalancerIds '["lb-xxxxxx"]'
tencentcloud clb DescribeListeners --LoadBalancerId lb-xxxxxx
tencentcloud clb DescribeListenerAttributes --ListenerId lbl-xxxxxx
tencentcloud clb CreateListener --LoadBalancerId lb-xxxxxx --Protocol HTTP --Port 80
tencentcloud clb DeleteListeners --ListenerIds '["lbl-xxxxxx"]'
tencentcloud clb DescribeTargets --LoadBalancerId lb-xxxxxx --ListenerId lbl-xxxxxx
tencentcloud clb RegisterTargets --LoadBalancerId lb-xxxxxx --ListenerId lbl-xxxxxx --Targets '[{"InstanceId":"ins-xxxxxx","Port":8080}]'
tencentcloud clb DeregisterTargets --LoadBalancerId lb-xxxxxx --ListenerId lbl-xxxxxx --Targets '[{"InstanceId":"ins-xxxxxx","Port":8080}]'

# COS (Cloud Object Storage)
tencentcloud cos ListBuckets
tencentcloud cos CreateBucket --Bucket my-bucket --Region ap-guangzhou
tencentcloud cos DeleteBucket --Bucket my-bucket
tencentcloud cos ListObjects --Bucket my-bucket
tencentcloud cos PutObject --Bucket my-bucket --Key my-file.txt --Body ./local-file.txt
tencentcloud cos GetObject --Bucket my-bucket --Key my-file.txt --Output ./local-file.txt
tencentcloud cos DeleteObject --Bucket my-bucket --Key my-file.txt
tencentcloud cos HeadBucket --Bucket my-bucket
tencentcloud cos PutBucketPolicy --Bucket my-bucket --PolicyFile policy.json

# TKE (Tencent Kubernetes Engine)
tencentcloud tke DescribeClusters
tencentcloud tke DescribeCluster --ClusterId cls-xxxxxx
tencentcloud tke CreateCluster --ClusterName my-cluster --ClusterType Managed && --ClusterVersion 1.27 --VpcId vpc-xxxxxx
tencentcloud tke DeleteCluster --ClusterId cls-xxxxxx --InstanceDeleteMode keep
tencentcloud tke DescribeNodePools --ClusterId cls-xxxxxx
tencentcloud tke CreateNodePool --ClusterId cls-xxxxxx --NodePoolName my-pool --InstanceTypes '["S5.MEDIUM4"]' --AutoScalingGroupSize 0,10,0
tencentcloud tke DeleteNodePool --ClusterId cls-xxxxxx --NodePoolId np-xxxxxx
tencentcloud tke ScaleInNodePool --ClusterId cls-xxxxxx --NodePoolId np-xxxxxx --InstanceIds '["ins-xxxxxx"]'
tencentcloud tke GetClusterKubeconfig --ClusterId cls-xxxxxx

# SCF (Serverless Cloud Function)
tencentcloud scf ListFunctions --Namespace default
tencentcloud scf GetFunction --FunctionName my-func --Namespace default
tencentcloud scf CreateFunction --FunctionName my-func --Handler index.main --Runtime Python3.9 --Code '{"ZipFile":"base64..."}' --Namespace default
tencentcloud scf DeleteFunction --FunctionName my-func --Namespace default
tencentcloud scf Invoke --FunctionName my-func --Namespace default --Event '{"key":"value"}'
tencentcloud scf ListTriggers --FunctionName my-func --Namespace default
tencentcloud scf CreateTrigger --FunctionName my-func --Namespace default --TriggerName my-trigger --Type timer --TriggerDesc '{"cron":"0 0 * * * * *"}'
tencentcloud scf DeleteTrigger --FunctionName my-func --Namespace default --TriggerName my-trigger
tencentcloud scf UpdateFunctionCode --FunctionName my-func --Namespace default --Code '{"ZipFile":"base64..."}'
tencentcloud scf UpdateFunctionConfiguration --FunctionName my-func --Namespace default --MemorySize 256 --Timeout 30

# DNS (DNSPod)
tencentcloud dnspod DescribeRecordList --Domain example.com
tencentcloud dnspod DescribeDomainList
tencentcloud dnspod CreateDomain --Domain example.com
tencentcloud dnspod DeleteDomain --Domain example.com
tencentcloud dnspod CreateRecord --Domain example.com --RecordType A --RecordLine 默认 --Value 1.2.3.4 --SubDomain www --TTL 600
tencentcloud dnspod ModifyRecord --Domain example.com --RecordId 12345 --RecordType A --Value 5.6.7.8
tencentcloud dnspod DeleteRecord --Domain example.com --RecordId 12345
tencentcloud dnspod DescribeRecordFilterList --Domain example.com --RecordType A
tencentcloud dnspod ModifyRecordStatus --Domain example.com --RecordId 12345 --Status disable

# CDN (Content Delivery Network)
tencentcloud cdn DescribeCdnDataTotal --StartTime 2024-01-01T00:00:00+08:00 --EndTime 2024-01-02T00:00:00+08:00
tencentcloud cdn DescribeCdnDomains
tencentcloud cdn AddCdnHost --Host my-cdn.example.com --Origin 1.2.3.4
tencentcloud cdn DeleteCdnHost --HostId 12345
tencentcloud cdn UpdateCdnHostOrigin --HostId 12345 --Origin new-origin.com
tencentcloud cdn DescribeCdnDomainDetail --Host my-cdn.example.com
tencentcloud cdn PurgeUrlsCache --Urls '["https://my-cdn.example.com/path"]'
tencentcloud cdn PurgePathCache --Paths '["https://my-cdn.example.com/dir/"]'
tencentcloud cdn Describe PurgeRecords --StartTime 2024-01-01T00:00:00+08:00 --EndTime 2024-01-02T00:00:00+08:00
tencentcloud cdn AddCdnDomain --ServiceType web --Domain new-cdn.example.com --Origin '["1.2.3.4"]'
tencentcloud cdn StopCdnDomain --Domain my-cdn.example.com
tencentcloud cdn StartCdnDomain --Domain my-cdn.example.com

# Monitor
tencentcloud monitor DescribeAlarmPolicies
tencentcloud monitor CreateAlarmPolicy --PolicyName my-policy --MonitorType cloudMonitor --Namespace QCE/CVM
tencentcloud monitor DeleteAlarmPolicy --PolicyId policy-xxxxxx
tencentcloud monitor DescribeAlarmPolicy --PolicyId policy-xxxxxx
tencentcloud monitor UpdateAlarmPolicy --PolicyId policy-xxxxxx --PolicyName new-name
tencentcloud monitor DescribeProductEventList --Module cvm
tencentcloud monitor GetMetricData --Namespace QCE/CVM --MetricName CPUUtilization --Instances '[{"Dimensions":[{"Name":"InstanceId","Value":"ins-xxxxxx"}]}]'

# MongoDB (TencentDB for MongoDB)
tencentcloud mongo DescribeDBInstances
tencentcloud mongo DescribeDBInstanceDetail --InstanceId dds-xxxxxx
tencentcloud mongo CreateDBInstance --MongoNodeClass mongodb.S2.MEDIUM4 --Memory 4 --Volume 50 --EngineVersion MONGO_40_WT
tencentcloud mongo TerminateDBInstance --InstanceId dds-xxxxxx
tencentcloud mongo CreateBackup --InstanceId dds-xxxxxx
tencentcloud mongo DescribeBackups --InstanceId dds-xxxxxx
tencentcloud mongo RestoreDBInstance --InstanceId dds-xxxxxx --BackupId backup-xxxxxx

# Redis (TencentDB for Redis)
tencentcloud redis DescribeInstances
tencentcloud redis DescribeInstanceDetail --InstanceId crs-xxxxxx
tencentcloud redis CreateInstance --MemSize 4096 --Zone ap-guangzhou-6 --Type redis.master.micro.default
tencentcloud redis DestroyInstance --InstanceId crs-xxxxxx
tencentcloud redis DescribeInstanceBackups --InstanceId crs-xxxxxx
tencentcloud redis ManualBackupInstance --InstanceId crs-xxxxxx --BackupName my-backup
tencentcloud redis RestoreInstance --InstanceId crs-xxxxxx --BackupId 12345
tencentcloud redis DescribeTaskInfo --TaskId 12345
