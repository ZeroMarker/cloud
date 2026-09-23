# Volcengine (ByteDance Cloud) CLI commands
# CLI: ve  |  Docs: https://github.com/volcengine/volcengine-cli
# Format: ve <service-code> <Action> --Param value --Param value
# System flags (--profile/--region/--output/--query) come after the Action.

# Install
npm install -g @volcengine/cli
ve version
ve upgrade
curl -fsSL https://github.com/volcengine/volcengine-cli/releases/download/v1.0.20/volcengine-cli_1.0.20_linux_amd64.zip -o ve.zip
unzip ve.zip && sudo mv ve /usr/local/bin/

# Authentication
ve configure set --profile default --region cn-beijing --access-key <key> --secret-key <secret>
ve configure set --profile sts-dev --region cn-beijing --access-key <key> --secret-key <secret> --session-token <token>
ve sts GetCallerIdentity
ve login
ve login --profile <name> --region cn-beijing --no-browser
ve logout
export VOLCENGINE_ACCESS_KEY=<key>
export VOLCENGINE_SECRET_KEY=<secret>
export VOLCENGINE_REGION=cn-beijing

# Profiles
ve configure get
ve configure get --profile <name>
ve configure list
ve configure profile --profile <name>
ve configure set --profile <name> --region cn-shanghai
ve configure set --profile <name> --endpoint ecs.cn-beijing.volcengineapi.com
ve configure delete --profile <name>
ve ecs DescribeInstances --profile <name>

# SSO
ve configure sso-session --name <session> --start-url https://<tenant>.volccloudidentity.com/userportal --region cn-beijing
ve configure sso --profile <name> --sso-session <session> --no-browser
ve sso login --sso-session <session> --no-browser
ve sso logout --sso-session <session>

# Discover Services And APIs
ve --help
ve <service-code> --help
ve ecs --help
ve ecs DescribeInstances --help
ve ecs DescribeInstances -h --detail
ve docs search "object storage quick start" --service-code tos --limit 3
ve docs fetch "https://www.volcengine.com/docs/6349/74830" --max-length 1000

# STS (Identity)
ve sts GetCallerIdentity
ve sts GetCallerIdentity --query 'Result.AccountId' --output text

# ECS (Compute)
ve ecs DescribeInstances
ve ecs DescribeInstances --InstanceIds.1 <instance-id>
ve ecs DescribeInstances --query 'Result.Instances[].{Id:InstanceId,Name:InstanceName,Status:Status,Zone:ZoneId}' --output table
ve ecs DescribeInstanceTypes
ve ecs DescribeAvailableResource
ve ecs RunInstances --ZoneId <zone-id> --NetworkInterfaces.1.SubnetId <subnet-id> --Password <password> --Tags.1.Key env --Tags.1.Value prod
ve ecs RunInstances --ZoneId <zone-id> --NetworkInterfaces.1.SubnetId <subnet-id> --KeyPairName <keypair> --DryRun true
ve ecs StartInstances --InstanceIds.1 <instance-id>
ve ecs StopInstances --InstanceIds.1 <instance-id>
ve ecs RebootInstances --InstanceIds.1 <instance-id>
ve ecs ModifyInstanceAttribute --InstanceIds.1 <instance-id> --InstanceName <name>
ve ecs DeleteInstances --InstanceIds.1 <instance-id>
ve ecs RenewInstance --InstanceIds.1 <instance-id> --Period 1
ve ecs GetConsoleOutput --InstanceId <instance-id>

# ECS Images
ve ecs DescribeImages
ve ecs DescribeImages --ImageIds.1 <image-id>
ve ecs CreateImage --InstanceId <instance-id> --ImageName <name>
ve ecs DeleteImages --ImageIds.1 <image-id>

# ECS Key Pairs
ve ecs DescribeKeyPairs
ve ecs CreateKeyPair --KeyPairName <name>
ve ecs ImportKeyPair --KeyPairName <name> --PublicKeyBody <public-key>
ve ecs DeleteKeyPairs --KeyPairNames <name>

# ECS Tags
ve ecs DescribeTags
ve ecs CreateTags --ResourceType instance --ResourceIds.1 <instance-id> --Tags.1.Key env --Tags.1.Value prod
ve ecs DeleteTags --ResourceType instance --ResourceIds.1 <instance-id> --Tags.1.Key env

# EBS (Block Storage)
# OpenAPI ServiceCode is storage_ebs; some CLI builds accept storageebs without the underscore.
ve storageebs DescribeVolumes
ve storageebs DescribeVolumes --VolumeIds.1 <volume-id>
ve storageebs CreateVolume --ZoneId <zone-id> --VolumeType ESSD_PL1 --SizeGB <size> --VolumeName <name>
ve storageebs AttachVolume --VolumeId <volume-id> --InstanceId <instance-id>
ve storageebs DetachVolume --VolumeId <volume-id>
ve storageebs ExtendVolume --VolumeId <volume-id> --NewSizeGB <size>
ve storageebs DeleteVolume --VolumeId <volume-id>
ve storageebs CreateSnapshot --VolumeId <volume-id> --SnapshotName <name>
ve storageebs DescribeSnapshots
ve storageebs DeleteSnapshot --SnapshotId <snapshot-id>

# VPC
ve vpc DescribeVpcs
ve vpc DescribeVpcs --VpcIds.1 <vpc-id>
ve vpc DescribeSubnets --VpcIds.1 <vpc-id>
ve vpc CreateVpc --Name <name> --CidrBlock <cidr>
ve vpc CreateSubnet --VpcId <vpc-id> --Name <name> --CidrBlock <cidr>
ve vpc DescribeRouteTables --VpcIds.1 <vpc-id>
ve vpc DeleteSubnet --SubnetId <subnet-id>
ve vpc DeleteVpc --VpcId <vpc-id>

# Security Groups
ve vpc DescribeSecurityGroups
ve vpc DescribeSecurityGroups --SecurityGroupIds.1 <sg-id>
ve vpc CreateSecurityGroup --SecurityGroupName <name> --VpcId <vpc-id> --Description <desc>
ve vpc AuthorizeSecurityGroupIngress --SecurityGroupId <sg-id>
ve vpc RevokeSecurityGroupIngress --SecurityGroupId <sg-id>
ve vpc DeleteSecurityGroup --SecurityGroupId <sg-id>

# EIP
ve vpc DescribeEipAddresses
ve vpc AllocateEipAddress --Name <name> --Bandwidth <mbps>
ve vpc AssociateEipAddress --AllocationId <eip-id> --InstanceId <instance-id>
ve vpc DisassociateEipAddress --AllocationId <eip-id>
ve vpc ReleaseEipAddress --AllocationId <eip-id>

# NAT Gateway
ve natgateway DescribeNatGateways
ve natgateway CreateNatGateway --Name <name> --VpcId <vpc-id>
ve natgateway DeleteNatGateway --NatGatewayId <nat-id>

# CLB (Load Balancer)
ve clb DescribeLoadBalancers
ve clb DescribeLoadBalancers --LoadBalancerIds.1 <clb-id>
ve clb CreateLoadBalancer --LoadBalancerName <name> --VpcId <vpc-id>
ve clb DeleteLoadBalancer --LoadBalancerId <clb-id>

# ALB (Application Load Balancer)
ve alb DescribeLoadBalancers
ve alb DeleteLoadBalancer --LoadBalancerId <alb-id>

# TOS (Object Storage)
# tosutil is a separate tool; ve proxies it as a subcommand.
ve tosutil help
ve tosutil mb tos://<bucket> -acl=private -sc=STANDARD
ve tosutil ls
ve tosutil ls tos://<bucket> -s --limited-num 20
ve tosutil cp ./dist/app.tar.gz tos://<bucket>/artifacts/app.tar.gz
ve tosutil cp tos://<bucket>/artifacts/app.tar.gz ./
ve tosutil stat tos://<bucket>/artifacts/app.tar.gz
ve tosutil presign tos://<bucket>/artifacts/app.tar.gz -vp=15min
ve tosutil rm tos://<bucket>/artifacts/app.tar.gz

# RDS MySQL
ve rds_mysql DescribeDBInstances
ve rds_mysql DescribeDBInstances --DBInstanceId <instance-id>
ve rds_mysql ListDBInstanceIPLists --InstanceId <instance-id> --GroupName default
ve rds_mysql ModifyDBInstanceIPList --InstanceId <instance-id> --GroupName default --IPList '["10.20.30.40","50.60.70.80"]'
ve rds_mysql ModifyDBInstanceIPList --body '{"InstanceId":"<instance-id>","GroupName":"default","IPList":["10.20.30.40","50.60.70.80"]}'
ve rds_mysql CreateDBInstance --help
ve rds_mysql DeleteDBInstance --help

# Redis
ve redis DescribeDBInstances
ve redis CreateDBInstance --body '{"InstanceName":"demo","RegionId":"cn-beijing","ConfigureNodes":[{"AZ":"cn-beijing-a"}],"NodeNumber":2,"ShardCapacity":1024,"ShardNumber":1,"EngineVersion":"6.0","SubnetId":"<subnet-id>","VpcId":"<vpc-id>","Password":"<secret>"}'
ve redis DeleteDBInstance --help

# VKE (Kubernetes)
ve vke ListClusters
ve vke CreateCluster --body '{"Name":"<cluster-name>","ClusterConfig":{"SubnetIds":["<subnet-id>"]},"PodsConfig":{"PodNetworkMode":"Flannel","FlannelConfig":{"PodCidrs":["172.16.0.0/16"]}},"ServicesConfig":{"ServiceCidrsv4":["172.20.0.0/16"]}}'
ve vke ListClusters --query 'Result.Items[].{Id:Id,Name:Name,Status:Status}' --output table
ve vke DeleteCluster --body '{"Id":"<cluster-id>","Force":true}'

# veFaaS (Serverless Functions)
ve vefaas --help
ve vefaas ListServices --help

# IAM
ve iam ListUsers
ve iam ListUsers --Limit 10 --Offset 0
ve iam ListUsersForGroup --UserGroupName <group>
ve iam CreateUser --help
ve iam DeleteUser --help

# DNS
ve dns ListZones
ve dns --help
ve privatezone ListPrivateZones

# CDN
ve CDN ListCdnDomains
ve CDN DescribeCdnConfig --Domain <example.com>
ve CDN AddCdnDomain --Domain <example.com>
ve CDN DeleteCdnDomain --Domain <example.com>

# Cloud Monitor
ve cloudmonitor ListRules
ve cloudmonitor ListAlertGroup
ve cloudmonitor ListContacts
ve cloudmonitor ListEventRules
ve cloudmonitor ListEvents
ve cloudmonitor GetMetricData --help
ve cloudmonitor CreateRule --help
ve cloudmonitor DeleteRulesByIds --help

# Tags
ve tag ListTagsForResources --help
ve ecs DescribeTags -- ResourceType instance

# Output And Filtering
ve sts GetCallerIdentity --output json
ve sts GetCallerIdentity --output table
ve ecs DescribeInstances --output table-num
ve ecs DescribeInstances --query 'Result.Instances[*].{Name:InstanceName,Id:InstanceId,Status:Status}' --output table
ve sts GetCallerIdentity --query 'Result.AccountId' --output text
ve sts GetCallerIdentity --output yaml
ve ecs DescribeInstances --output off
ve ecs DescribeInstances --region cn-shanghai
ve ecs DescribeInstances --lang EN
ve enable-color
ve disable-color

# Calling APIs Not Yet In CLI Metadata
ve newservice DescribeNewResource --version 2024-01-01 --endpoint open.volcengineapi.com --SomeParam value --force

# Shell Completion
source <(ve completion bash)
ve completion zsh > "${fpath[1]}/_ve"

# Debug Logging
VOLCENGINE_CLI_DEBUG=true ve sts GetCallerIdentity
tail -n 100 ~/.volcengine/logs/$(date +%Y%m%d%H).log

# MCP Server For Agents
ve mcp
ve mcp --transport streamable-http --host 127.0.0.1 --port 8888

# Cleanup (list before you delete)
ve ecs DescribeInstances
ve ecs DescribeVolumes
ve vpc DescribeEipAddresses
ve ecs DeleteInstances --InstanceIds.1 <instance-id>
ve storageebs DeleteVolume --VolumeId <volume-id>
ve vpc ReleaseEipAddress --AllocationId <eip-id>
ve clb DeleteLoadBalancer --LoadBalancerId <clb-id>
ve vpc DeleteSecurityGroup --SecurityGroupId <sg-id>
ve vpc DeleteSubnet --SubnetId <subnet-id>
ve vpc DeleteVpc --VpcId <vpc-id>
ve tosutil rm tos://<bucket>/<object-key>
