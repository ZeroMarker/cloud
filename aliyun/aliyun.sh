# Alibaba Cloud (Aliyun) CLI commands

# Install
curl -fsSL https://aliyuncli.alicdn.com/aliyun-cli-linux-latest-amd64.tgz | tar xz
sudo mv aliyun /usr/local/bin/

# Authentication
aliyun configure
aliyun configure list
aliyun configure get --profile <name>
aliyun sts GetCallerIdentity

# ECS (Compute)
aliyun ecs DescribeInstances --RegionId <region>
aliyun ecs DescribeInstanceAttribute --InstanceId <id>
aliyun ecs CreateInstance --RegionId <region> --ImageId <image> --InstanceType <type> --SecurityGroupId <sg>
aliyun ecs CreateInstance --RegionId cn-hangzhou --ImageId ubuntu_22_04_x64_20G_alibase_20230907.vhd --InstanceType ecs.t6-c1m1.large --SecurityGroupId sg-xxx
aliyun ecs DeleteInstance --InstanceId <id>
aliyun ecs StartInstance --InstanceId <id>
aliyun ecs StopInstance --InstanceId <id>
aliyun ecs RebootInstance --InstanceId <id>
aliyun ecs UpdateInstanceAttribute --InstanceId <id> --InstanceName <name>
aliyun ecs AddTags --InstanceId <id> --Tag.1.Key=env --Tag.1.Value=prod
aliyun ecs RemoveTags --InstanceId <id> --Tag.1.Key=env
aliyun ecs DescribeInstanceStatus --RegionId <region>
aliyun ecs DescribeInstanceAutoRenewAttribute --InstanceId <id>
aliyun ecs ModifyInstanceAutoRenewAttribute --InstanceId <id> --Duration 1 --AutoRenew true
aliyun ecs CreateInstance --RegionId <region> --ImageId <image> --InstanceType <type> --InternetChargeType PayByTraffic --InternetMaxBandwidthOut 10
aliyun ecs AllocatePublicIpAddress --InstanceId <id>
aliyun ecs ReleasePublicIpAddress --InstanceId <id> --IpAddress <ip>
aliyun ecs CreateSecurityGroup --RegionId <region> --VpcId <vpc> --Description <desc>
aliyun ecs DeleteSecurityGroup --SecurityGroupId <sg>
aliyun ecs AuthorizeSecurityGroup --SecurityGroupId <sg> --IpProtocol tcp --PortRange 80/80 --SourceCidrIp 0.0.0.0/0
aliyun ecs RevokeSecurityGroup --SecurityGroupId <sg> --IpProtocol tcp --PortRange 80/80 --SourceCidrIp 0.0.0.0/0
aliyun ecs DescribeSecurityGroups --RegionId <region> --VpcId <vpc>

# SSH Key Pairs
aliyun ecs DescribeKeyPairs --RegionId <region>
aliyun ecs CreateKeyPair --RegionId <region> --KeyPairName <name>
aliyun ecs DeleteKeyPairs --KeyPairNames <name>
aliyun ecs ImportKeyPair --RegionId <region> --KeyPairName <name> --PublicKeyBody <key>

# Disks
aliyun ecs DescribeDisks --InstanceId <id>
aliyun ecs CreateDisk --RegionId <region> --Size <size> --DiskCategory cloud_essd --Category cloud_essd
aliyun ecs DeleteDisk --DiskId <disk>
aliyun ecs AttachDisk --InstanceId <id> --DiskId <disk>
aliyun ecs DetachDisk --InstanceId <id> --DiskId <disk>
aliyun ecs ResizeDisk --DiskId <disk> --NewSize <size> --Type online
aliyun ecs CreateSnapshot --DiskId <disk> --SnapshotName <name>
aliyun ecs DescribeSnapshots --RegionId <region>
aliyun ecs DeleteSnapshot --SnapshotId <snap>
aliyun ecs ReNewInstance --InstanceId <id> --Period <months>

# Images
aliyun ecs DescribeImages --RegionId <region> --OsName ubuntu
aliyun ecs DescribeImages --RegionId <region> --ImageId <id>
aliyun ecs CreateImage --RegionId <region> --InstanceId <id> --ImageName <name>
aliyun ecs DeleteImage --ImageId <id>

# Security Groups Rules
aliyun ecs DescribeSecurityGroupAttribute --SecurityGroupId <sg> --RegionId <region>
aliyun ecs AuthorizeSecurityGroup --SecurityGroupId <sg> --IpProtocol tcp --PortRange 22/22 --SourceCidrIp 0.0.0.0/0
aliyun ecs AuthorizeSecurityGroup --SecurityGroupId <sg> --IpProtocol tcp --PortRange 80/80 --SourceCidrIp 10.0.0.0/8

# VPC
aliyun vpc DescribeVpcs --RegionId <region>
aliyun vpc CreateVpc --RegionId <region> --CidrBlock 172.16.0.0/12
aliyun vpc DeleteVpc --VpcId <vpc>
aliyun vpc DescribeVSwitches --RegionId <region> --VpcId <vpc>
aliyun vpc CreateVSwitch --VpcId <vpc> --ZoneId <zone> --CidrBlock 172.16.0.0/24
aliyun vpc DeleteVSwitch --VSwitchId <vswitch>
aliyun vpc DescribeRouteTables --RegionId <region> --VpcId <vpc>
aliyun vpc CreateRouteEntry --RouteTableId <rt> --DestinationCidrBlock 0.0.0.0/0 --NextHopId <nat>

# EIP (Elastic IP)
aliyun vpc DescribeEipAddresses --RegionId <region>
aliyun vpc AllocateEipAddress --RegionId <region> --Bandwidth 10 --InternetChargeType PayByTraffic
aliyun vpc ReleaseEipAddress --AllocationId <eip>
aliyun vpc AssociateEipAddress --AllocationId <eip> --InstanceId <instance> --InstanceType EcsInstance
aliyun vpc UnassociateEipAddress --AllocationId <eip>

# NAT Gateway
aliyun vpc DescribeNatGateways --RegionId <region>
aliyun vpc CreateNatGateway --RegionId <region> --VpcId <vpc> --Name <name>
aliyun vpc DeleteNatGateway --NatGatewayId <nat>
aliyun vpc CreateForwardEntry --ForwardTableId <table> --ExternalIp <eip> --ExternalPort 80 --InternalIp <ip> --InternalPort 80 --IpProtocol tcp
aliyun vpc DeleteForwardEntry --ForwardTableId <table> --ExternalIp <eip> --ExternalPort 80 --InternalIp <ip> --InternalPort 80 --IpProtocol tcp
aliyun vpc CreateSnatEntry --SnatTableId <table> --SnatIp <ip> --SourceVSwitchId <vswitch>
aliyun vpc DeleteSnatEntry --SnatTableId <table> --SnatIp <ip> --SourceVSwitchId <vswitch>

# SLB (Load Balancing)
aliyun slb DescribeLoadBalancers --RegionId <region>
aliyun slb CreateLoadBalancer --RegionId <region> --LoadBalancerName <name> --AddressType internet
aliyun slb DeleteLoadBalancer --LoadBalancerId <slb>
aliyun slb DescribeLoadBalancerListeners --LoadBalancerId <slb>
aliyun slb CreateLoadBalancerHTTPListener --LoadBalancerId <slb> --ListenerPort 80 --BackendServerPort 80 --Bandwidth -1
aliyun slb CreateLoadBalancerHTTPSListener --LoadBalancerId <slb> --ListenerPort 443 --BackendServerPort 80 --ServerCertificateId <cert>
aliyun slb DeleteLoadBalancerListener --LoadBalancerId <slb> --ListenerPort 80
aliyun slb AddBackendServers --LoadBalancerId <slb> --BackendServers '[{"ServerId":"<id>","Weight":"100"}]'
aliyun slb RemoveBackendServers --LoadBalancerId <slb> --BackendServers '[{"ServerId":"<id>"}]'
aliyun slb SetBackendServers --LoadBalancerId <slb> --BackendServers '[{"ServerId":"<id>","Weight":"50"}]'

# CLB (Classic Load Balancer)
aliyun slb DescribeLoadBalancerAttribute --LoadBalancerId <slb>

# ALB (Application Load Balancer)
aliyun albs DescribeLoadBalancers --RegionId <region>
aliyun albs CreateLoadBalancer --RegionId <region> --LoadBalancerName <name> --AddressType Internet
aliyun albs DeleteLoadBalancer --LoadBalancerId <alb>
aliyun albs CreateListener --LoadBalancerId <alb> --ListenerProtocol HTTPS --ListenerPort 443 --DefaultActions '[{"Type":"ForwardGroup","ForwardGroupConfig":{"ServerGroupInfos":[{"ServerGroupId":"<sg>","Weight":100}]}}]'
aliyun albs DeleteListener --ListenerId <listener>

# OSS (Object Storage)
aliyun oss ls
aliyun oss ls oss://<bucket>
aliyun oss ls oss://<bucket>/<prefix>
aliyun oss mb oss://<bucket>
aliyun oss rb oss://<bucket> --force
aliyun oss cp <file> oss://<bucket>/<path>
aliyun oss cp oss://<bucket>/<path> <file>
aliyun oss cp -r <dir> oss://<bucket>/<prefix>
aliyun oss mv <file> oss://<bucket>/<path>
aliyun oss rm oss://<bucket>/<path>
aliyun oss rm -r oss://<bucket>/<prefix>
aliyun oss sign oss://<bucket>/<path> --timeout 3600
aliyun oss stat oss://<bucket>
aliyun oss set-acl oss://<bucket> public-read
aliyun oss set-logging oss://<bucket> --target-bucket <target> --target-prefix <prefix>
aliyun oss bucket-versioning --method put oss://<bucket> --versioning-config '{"Status":"Enabled"}'
aliyun oss lifecycle --method put oss://<bucket> --lifecycle-config '<json>'

# RDS (Databases)
aliyun rds DescribeDBInstances --RegionId <region>
aliyun rds DescribeDBInstanceAttribute --DBInstanceId <id>
aliyun rds CreateDBInstance --RegionId <region> --Engine MySQL --EngineVersion 8.0 --DBInstanceClass rds.mysql.t1.small --DBInstanceStorage 20
aliyun rds DeleteDBInstance --DBInstanceId <id>
aliyun rds StartDBInstance --DBInstanceId <id>
aliyun rds StopDBInstance --DBInstanceId <id>
aliyun rds ModifyDBInstanceClass --DBInstanceId <id> --DBInstanceClass rds.mysql.s2.large
aliyun rds DescribeDatabases --DBInstanceId <id>
aliyun rds CreateDatabase --DBInstanceId <id> --DBName <db>
aliyun rds DeleteDatabase --DBInstanceId <id> --DBName <db>
aliyun rds DescribeAccounts --DBInstanceId <id>
aliyun rds CreateAccount --DBInstanceId <id> --AccountName <user> --AccountPassword <pw>
aliyun rds DeleteAccount --DBInstanceId <id> --AccountName <user>
aliyun rds DescribeBackups --DBInstanceId <id>
aliyun rds CreateBackup --DBInstanceId <id> --BackupMethod Physical
aliyun rds DeleteBackup --BackupId <backup>
aliyun rds RestoreDBInstanceFromBackup --DBInstanceId <id> --BackupId <backup>
aliyun rds CreateReadOnlyDBInstance --DBInstanceId <id> --EngineVersion 8.0 --DBInstanceClass rds.mysql.t1.small --DBInstanceStorage 20

# PolarDB
aliyun polardb DescribeDBClusters --RegionId <region>
aliyun polardb CreateDBCluster --RegionId <region> --Engine polardb-mysql --EngineVersion 8.0 --DBNodeClass polar.mysql.x2.large --DBClusterNetworkType VPC --PayType Postpaid
aliyun polardb DeleteDBCluster --DBClusterId <id>
aliyun polardb DescribeDBNodeClasses --RegionId <region> --Engine polardb-mysql

# ApsaraDB for Redis
aliyun r-kvstore DescribeInstances --RegionId <region>
aliyun r-kvstore CreateInstance --RegionId <region> --InstanceClass redis.master.small.default --InstanceType Redis --EngineVersion 6.0
aliyun r-kvstore DeleteInstance --InstanceId <id>
aliyun r-kvstore DescribeInstanceAttribute --InstanceId <id>

# Kubernetes (ACK)
aliyun cs DescribeClusters --RegionId <region>
aliyun cs GetClusterConfig --ClusterId <id>
aliyun cs CreateCluster --ClusterType kubernetes --RegionId <region> --Name <name> --WorkerInstanceType <type> --NumOfNodes 3
aliyun cs DeleteCluster --ClusterId <id>
aliyun cs ScaleCluster --ClusterId <id> --count 5
aliyun cs DescribeClusterNodePools --ClusterId <id>
aliyun cs CreateNodePool --ClusterId <id> --NodePoolName <name> --InstanceTypes <type> --Count 3
aliyun cs DeleteNodePool --ClusterId <id> --NodepoolId <pool>
aliyun cs ScaleClusterNodePool --ClusterId <id> --NodepoolId <pool> --count 5
aliyun cs DescribeClusterUserKubeconfig --ClusterId <id>

# Function Compute
aliyun fc ListServices --region <region>
aliyun fc CreateService --region <region> --serviceName <name> --description <desc>
aliyun fc DeleteService --region <region> --serviceName <name>
aliyun fc ListFunctions --region <region> --serviceName <service>
aliyun fc CreateFunction --region <region> --serviceName <service> --functionName <name> --handler index.handler --runtime nodejs18 --code fileb://code.zip
aliyun fc DeleteFunction --region <region> --serviceName <service> --functionName <name>
aliyun fc InvokeFunction --region <region> --serviceName <service> --functionName <name> --event '{"key":"value"}'
aliyun fc ListTriggers --region <region> --serviceName <service> --functionName <name>
aliyun fc CreateTrigger --region <region> --serviceName <service> --functionName <name> --triggerName <name> --triggerType http --triggerConfig '{"authType":"anonymous"}'
aliyun fc DeleteTrigger --region <region> --serviceName <service> --functionName <name> --triggerName <name>

# CDN
aliyun cdn DescribeUserDomains
aliyun cdn AddDomain --Region <region> --DomainName <domain>
aliyun cdn DeleteDomain --DomainName <domain>
aliyun cdn DescribeDomainBpsData --DomainName <domain>
aliyun cdn DescribeDomainCertificateInfo --DomainName <domain>
aliyun cdn SetDomainServerCertificate --DomainName <domain> --ServerCertificate <cert> --PrivateKey <key>
aliyun cdn RefreshObjectCaches --ObjectPath <url> --ObjectType File
aliyun cdn PreloadObjectCaches --ObjectPath <url>

# DNS
aliyun alidns DescribeDomains
aliyun alidns DescribeDomainRecords --DomainName <domain>
aliyun alidns AddDomainRecord --DomainName <domain> --RR <subdomain> --Type A --Value <ip>
aliyun alidns UpdateDomainRecord --RecordId <id> --RR <subdomain> --Type A --Value <new-ip>
aliyun alidns DeleteDomainRecord --RecordId <id>
aliyun alidns AddDomainRecord --DomainName <domain> --RR <subdomain> --Type CNAME --Value <target>
aliyun alidns AddDomainRecord --DomainName <domain> --RR <subdomain> --Type MX --Value <mail> --Priority 10
aliyun alidns AddDomainRecord --DomainName <domain> --RR <subdomain> --Type TXT --Value <value>

# Container Service for Kubernetes (ACK)
aliyun cs DescribeClusters --RegionId <region>
aliyun cs GetClusterConfig --ClusterId <id>

# Container Registry
aliyun cr ListRepositories --RegionId <region>
aliyun cr CreateRepository --RegionId <region> --RepoNamespace <ns> --RepoName <name> --Summary <desc>
aliyun cr DeleteRepository --RegionId <region> --RepoNamespace <ns> --RepoName <name>
aliyun cr ListImages --RegionId <region> --RepoNamespace <ns> --RepoName <name>

# Message Queue
aliyun mq ListTopic --RegionId <region> --InstanceId <id>
aliyun mq CreateTopic --RegionId <region> --InstanceId <id> --Topic <name>
aliyun mq DeleteTopic --RegionId <region> --InstanceId <id> --Topic <name>
aliyun mq PublishMessage --RegionId <region> --InstanceId <id> --Topic <name> --MessageBody <msg>

# ActionTrail (Audit)
aliyun actiontrail DescribeTrails
aliyun actiontrail CreateTrail --Name <name> --OssBucketName <bucket>
aliyun actiontrail DeleteTrail --Name <name>
aliyun actiontrail LookupEvents --EventName <name>

# CloudMonitor
aliyun cms DescribeMetricList --Namespace <ns> --MetricName <metric>
aliyun cms PutMetricRuleTargets --RuleId <id> --Targets <json>
aliyun cms DescribeAlertHistoryList

# Resource Manager
aliyun rms ListResources --RegionId <region>
aliyun rms ListResourceGroups

# Tag
aliyun tag TagResources --RegionId <region> --ResourceType instance --ResourceId <id> --Tag.1.Key=env --Tag.1.Value=prod
aliyun tag UntagResources --RegionId <region> --ResourceType instance --ResourceId <id> --TagKey env

# KMS (Key Management)
aliyun kms ListKeys
aliyun kms CreateKey --Description <desc>
aliyun kms EnableKey --KeyId <id>
aliyun kms DisableKey --KeyId <id>
aliyun kms Encrypt --KeyId <id> --Plaintext <data>
aliyun kms Decrypt --CiphertextBlob <blob>

# RAM (Identity)
aliyun ram ListUsers
aliyun ram CreateUser --UserName <name>
aliyun ram DeleteUser --UserName <user>
aliyun ram ListPolicies --PolicyType Custom
aliyun ram CreatePolicy --PolicyName <name> --PolicyDocument <json>
aliyun ram AttachPolicyToUser --PolicyName <policy> --PolicyType Custom --UserName <user>
aliyun ram DetachPolicyFromUser --PolicyName <policy> --PolicyType Custom --UserName <user>
aliyun ram ListRoles
aliyun ram CreateRole --RoleName <name> --AssumeRolePolicyDocument <json>
aliyun ram DeleteRole --RoleName <role>
aliyun ram AttachPolicyToRole --PolicyName <policy> --PolicyType Custom --RoleName <role>
aliyun ram CreateAccessKey --UserName <user>
aliyun ram ListAccessKeys --UserName <user>
aliyun ram DeleteAccessKey --UserName <user> --UserAccessKeyId <id>

# Regions / Zones
aliyun ecs DescribeRegions
aliyun ecs DescribeZones --RegionId <region>

# Output
aliyun ecs DescribeRegions --output cols=RegionId,LocalName rows=Regions.Region
aliyun ecs DescribeInstances --output json
