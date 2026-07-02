# AWS CLI commands

# Install
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip && sudo ./aws/install

# Authentication
aws configure
aws configure set aws_access_key_id <key>
aws configure set aws_secret_access_key <secret>
aws configure set region <region>
aws configure set output json
aws sts get-caller-identity
aws iam list-users

# EC2 (Compute)
aws ec2 describe-instances
aws ec2 describe-instances --query "Reservations[*].Instances[*].{ID:InstanceId,Type:InstanceType,State:State.Name,IP:PublicIpAddress}"
aws ec2 run-instances --image-id <ami> --instance-type <type> --key-name <key> --security-group-ids <sg> --subnet-id <subnet>
aws ec2 run-instances --image-id ami-0c55b159cbfafe1f0 --instance-type t2.micro --key-name mykey --count 1
aws ec2 terminate-instances --instance-ids <id>
aws ec2 stop-instances --instance-ids <id>
aws ec2 start-instances --instance-ids <id>
aws ec2 reboot-instances --instance-ids <id>
aws ec2 describe-instance-status --instance-ids <id>
aws ec2 create-tags --resources <id> --tags Key=Name,Value=<name>
aws ec2 describe-images --owners amazon
aws ec2 describe-instance-types
aws ec2 describe-availability-zones

# Key Pairs
aws ec2 describe-key-pairs
aws ec2 create-key-pair --key-name <name>
aws ec2 delete-key-pair --key-name <name>
aws ec2 import-key-pair --key-name <name> --public-key-material <b64>

# Security Groups
aws ec2 describe-security-groups
aws ec2 create-security-group --group-name <name> --description <desc> --vpc-id <vpc>
aws ec2 delete-security-group --group-id <sg>
aws ec2 authorize-security-group-ingress --group-id <sg> --protocol tcp --port 80 --cidr 0.0.0.0/0
aws ec2 revoke-security-group-ingress --group-id <sg> --protocol tcp --port 80 --cidr 0.0.0.0/0

# VPC
aws ec2 describe-vpcs
aws ec2 create-vpc --cidr-block 10.0.0.0/16
aws ec2 delete-vpc --vpc-id <vpc>
aws ec2 describe-subnets --filters Name=vpc-id,Values=<vpc>
aws ec2 create-subnet --vpc-id <vpc> --cidr-block 10.0.1.0/24 --availability-zone <az>
aws ec2 delete-subnet --subnet-id <subnet>
aws ec2 describe-internet-gateways
aws ec2 create-internet-gateway
aws ec2 attach-internet-gateway --internet-gateway-id <igw> --vpc-id <vpc>
aws ec2 describe-route-tables --filters Name=vpc-id,Values=<vpc>
aws ec2 create-route --route-table-id <rt> --destination-cidr-block 0.0.0.0/0 --gateway-id <igw>

# Elastic IPs
aws ec2 describe-addresses
aws ec2 allocate-address --domain vpc
aws ec2 release-address --allocation-id <eip>
aws ec2 associate-address --instance-id <instance> --allocation-id <eip>
aws ec2 disassociate-address --allocation-id <eip>

# Volumes (EBS)
aws ec2 describe-volumes
aws ec2 create-volume --availability-zone <az> --size <size> --volume-type gp3
aws ec2 delete-volume --volume-id <vol>
aws ec2 attach-volume --volume-id <vol> --instance-id <instance> --device /dev/sdf
aws ec2 detach-volume --volume-id <vol>
aws ec2 create-snapshot --volume-id <vol> --description <desc>
aws ec2 describe-snapshots --owner-ids self
aws ec2 delete-snapshot --snapshot-id <snap>
aws ec2 modify-volume --volume-id <vol> --size <new-size>

# AMIs
aws ec2 describe-images --owners self
aws ec2 create-image --instance-id <instance> --name <name> --no-reboot
aws ec2 deregister-image --image-id <ami>
aws ec2 copy-image --source-image-id <ami> --source-region <region> --name <name>

# Load Balancing (ELB/ALB/NLB)
aws elbv2 describe-load-balancers
aws elbv2 create-load-balancer --name <name> --subnets <subnet1> <subnet2> --security-groups <sg> --scheme internet-facing --type application
aws elbv2 delete-load-balancer --load-balancer-arn <arn>
aws elbv2 describe-target-groups
aws elbv2 create-target-group --name <name> --protocol HTTP --port 80 --vpc-id <vpc>
aws elbv2 register-targets --target-group-arn <tg> --targets Id=<instance>
aws elbv2 deregister-targets --target-group-arn <tg> --targets Id=<instance>
aws elbv2 describe-listeners --load-balancer-arn <arn>
aws elbv2 create-listener --load-balancer-arn <arn> --protocol HTTP --port 80 --default-actions Type=forward,TargetGroupArn=<tg>
aws elbv2 delete-listener --listener-arn <arn>
aws elbv2 create-rule --listener-arn <arn> --priority <n> --conditions Field=path-pattern,Values=<pattern> --actions Type=forward,TargetGroupArn=<tg>

# Auto Scaling
aws autoscaling describe-auto-scaling-groups
aws autoscaling create-auto-scaling-group --auto-scaling-group-name <name> --launch-configuration-name <lc> --min-size 1 --max-size 5 --desired-capacity 2
aws autoscaling delete-auto-scaling-group --auto-scaling-group-name <name>
aws autoscaling set-desired-capacity --auto-scaling-group-name <name> --desired-capacity <n>
aws autoscaling suspend-processes --auto-scaling-group-name <name>
aws autoscaling resume-processes --auto-scaling-group-name <name>

# S3 (Object Storage)
aws s3 ls
aws s3 ls s3://<bucket>
aws s3 ls s3://<bucket>/<prefix>
aws s3 mb s3://<bucket>
aws s3 rb s3://<bucket> --force
aws s3 cp <file> s3://<bucket>/<path>
aws s3 cp s3://<bucket>/<path> <file>
aws s3 cp --recursive <dir> s3://<bucket>/<prefix>
aws s3 mv <file> s3://<bucket>/<path>
aws s3 rm s3://<bucket>/<path>
aws s3 rm --recursive s3://<bucket>/<prefix>
aws s3 sync <dir> s3://<bucket>/<prefix>
aws s3 sync s3://<bucket>/<prefix> <dir>
aws s3 website s3://<bucket> --index-document index.html --error-document error.html
aws s3api get-bucket-policy --bucket <bucket>
aws s3api put-bucket-policy --bucket <bucket> --policy <json>
aws s3api delete-bucket-policy --bucket <bucket>
aws s3api get-bucket-acl --bucket <bucket>
aws s3api put-bucket-acl --bucket <bucket> --acl public-read
aws s3api get-bucket-versioning --bucket <bucket>
aws s3api put-bucket-versioning --bucket <bucket> --versioning-configuration Status=Enabled
aws s3api get-bucket-lifecycle-configuration --bucket <bucket>
aws s3api put-bucket-lifecycle-configuration --bucket <bucket> --lifecycle-configuration <json>
aws s3api get-bucket-encryption --bucket <bucket>
aws s3api put-bucket-encryption --bucket <bucket> --server-side-encryption-configuration <json>
aws s3api put-object --bucket <bucket> --key <key> --body <file> --acl public-read
aws s3api head-object --bucket <bucket> --key <key>
aws s3api delete-object --bucket <bucket> --key <key>
aws s3api list-objects-v2 --bucket <bucket> --prefix <prefix>

# RDS (Databases)
aws rds describe-db-instances
aws rds create-db-instance --db-instance-identifier <id> --db-instance-class db.t3.micro --engine mysql --master-username admin --master-user-password <pw> --allocated-storage 20
aws rds create-db-instance --db-instance-identifier <id> --db-instance-class db.t3.micro --engine postgres --master-username postgres --master-user-password <pw> --allocated-storage 20
aws rds delete-db-instance --db-instance-identifier <id> --skip-final-snapshot
aws rds stop-db-instance --db-instance-identifier <id>
aws rds start-db-instance --db-instance-identifier <id>
aws rds modify-db-instance --db-instance-identifier <id> --db-instance-class db.t3.small
aws rds describe-db-snapshots --db-instance-identifier <id>
aws rds create-db-snapshot --db-instance-identifier <id> --db-snapshot-identifier <snap>
aws rds delete-db-snapshot --db-snapshot-identifier <snap>
aws rds restore-db-instance-from-db-snapshot --db-instance-identifier <id> --db-snapshot-identifier <snap>
aws rds create-db-cluster --db-cluster-identifier <id> --engine aurora-mysql --master-username admin --master-user-password <pw>
aws rds describe-db-clusters
aws rds delete-db-cluster --db-cluster-identifier <id> --skip-final-snapshot

# Aurora Serverless
aws rds create-db-cluster --db-cluster-identifier <id> --engine aurora-mysql-serverless --scaling-configuration MinCapacity=1,MaxCapacity=8

# DynamoDB
aws dynamodb list-tables
aws dynamodb describe-table --table-name <table>
aws dynamodb create-table --table-name <table> --attribute-definitions AttributeName=pk,AttributeType=S --key-schema AttributeName=pk,KeyType=HASH --billing-mode PAY_PER_REQUEST
aws dynamodb delete-table --table-name <table>
aws dynamodb scan --table-name <table>
aws dynamodb get-item --table-name <table> --key '{"pk": {"S": "value"}}'
aws dynamodb put-item --table-name <table> --item '{"pk": {"S": "key"}, "data": {"S": "value"}}'
aws dynamodb update-item --table-name <table> --key '{"pk": {"S": "key"}}' --update-expression "SET data = :val" --expression-attribute-values '{":val": {"S": "new"}}'
aws dynamodb delete-item --table-name <table> --key '{"pk": {"S": "key"}}'
aws dynamodb query --table-name <table> --key-condition-expression "pk = :pk" --expression-attribute-values '{":pk": {"S": "value"}}'

# ECS (Containers)
aws ecs list-clusters
aws ecs describe-clusters --clusters <cluster>
aws ecs create-cluster --cluster-name <name>
aws ecs delete-cluster --cluster <cluster>
aws ecs list-services --cluster <cluster>
aws ecs describe-services --cluster <cluster> --services <service>
aws ecs create-service --cluster <cluster> --service-name <name> --task-definition <td> --desired-count 2 --launch-type FARGATE --network-configuration 'awsvpcConfiguration={subnets=[<subnet>],securityGroups=[<sg>],assignPublicIp=ENABLED}'
aws ecs update-service --cluster <cluster> --service <service> --desired-count <n>
aws ecs delete-service --cluster <cluster> --service <service>
aws ecs list-task-definitions
aws ecs describe-task-definition --task-definition <td>
aws ecs register-task-definition --cli-input-json file://task.json
aws ecs deregister-task-definition --task-definition <td>
aws ecs list-tasks --cluster <cluster>
aws ecs stop-task --cluster <cluster> --task <task>
aws ecs run-task --cluster <cluster> --task-definition <td> --launch-type FARGATE --network-configuration 'awsvpcConfiguration={subnets=[<subnet>],securityGroups=[<sg>]}'

# ECR (Container Registry)
aws ecr describe-repositories
aws ecr create-repository --repository-name <name>
aws ecr delete-repository --repository-name <name>
aws ecr get-login-password --region <region> | docker login --username AWS --password-stdin <account>.dkr.ecr.<region>.amazonaws.com
aws ecr describe-images --repository-name <name>
aws ecr batch-delete-image --repository-name <name> --image-ids imageTag=<tag>
aws ecr put-lifecycle-policy --repository-name <name> --lifecycle-policy-text <json>

# Lambda (Serverless)
aws lambda list-functions
aws lambda get-function --function-name <name>
aws lambda create-function --function-name <name> --runtime nodejs20.x --handler index.handler --role <role-arn> --zip-file fileb://function.zip
aws lambda update-function-code --function-name <name> --zip-file fileb://function.zip
aws lambda delete-function --function-name <name>
aws lambda invoke --function-name <name> --payload '{'key': 'value'}' response.json
aws lambda list-event-source-mappings --function-name <name>
aws lambda create-event-source-mapping --function-name <name> --event-source-arn <arn>
aws lambda delete-event-source-mapping --uuid <uuid>
aws lambda get-function-url-config --function-name <name>
aws lambda create-function-url-config --function-name <name> --AuthType NONE

# API Gateway
aws apigateway get-rest-apis
aws apigateway create-rest-api --name <name>
aws apigateway delete-rest-api --rest-api-id <id>
aws apigateway get-resources --rest-api-id <id>
aws apiggateway create-resource --rest-api-id <id> --parent-id <parent> --path-part <part>
aws apiggateway put-method --rest-api-id <id> --resource-id <res> --http-method GET --authorization-type NONE
aws apigateway put-integration --rest-api-id <id> --resource-id <res> --http-method GET --type AWS_PROXY --integration-http-method POST --uri <lambda-uri>
aws apiggateway create-deployment --rest-api-id <id> --stage-name prod
aws apigateway get-stages --rest-api-id <id>

# CloudFront (CDN)
aws cloudfront list-distributions
aws cloudfront get-distribution --id <id>
aws cloudfront create-distribution --origin-domain-name <bucket>.s3.amazonaws.com
aws cloudfront delete-distribution --id <id>
aws cloudfront create-invalidation --distribution-id <id> --paths /<path>
aws cloudfront create-invalidation --distribution-id <id> --paths /*

# Route 53 (DNS)
aws route53 list-hosted-zones
aws route53 create-hosted-zone --name <domain> --caller-reference <ref>
aws route53 delete-hosted-zone --id <id>
aws route53 list-resource-record-sets --hosted-zone-id <id>
aws route53 change-resource-record-sets --hosted-zone-id <id> --change-batch file://records.json
aws route53 list-health-checks
aws route53 create-health-check --caller-reference <ref> --health-check-config '{"IPAddress": "<ip>", "Port": 80, "Type": "HTTP"}'
aws route53 delete-health-check --health-check-id <id>

# CloudWatch (Monitoring)
aws cloudwatch list-metrics
aws cloudwatch get-metric-statistics --namespace AWS/EC2 --metric-name CPUUtilization --start-time <time> --end-time <time> --period 300 --statistics Average --dimensions Name=InstanceId,Value=<id>
aws cloudwatch put-metric-alarm --alarm-name <name> --metric-name CPUUtilization --namespace AWS/EC2 --statistic Average --period 300 --threshold 80 --comparison-operator GreaterThanThreshold --evaluation-periods 2 --alarm-actions <sns-arn>
aws cloudwatch delete-alarms --alarm-names <name>
aws cloudwatch describe-alarms --alarm-names <name>
aws cloudwatch enable-alarm-actions --alarm-name <name>
aws cloudwatch disable-alarm-actions --alarm-name <name>

# IAM (Identity)
aws iam list-users
aws iam create-user --user-name <name>
aws iam delete-user --user-name <name>
aws iam list-access-keys --user-name <user>
aws iam create-access-key --user-name <user>
aws iam delete-access-key --user-name <user> --access-key-id <id>
aws iam list-groups
aws iam create-group --group-name <name>
aws iam delete-group --group-name <name>
aws iam add-user-to-group --user-name <user> --group-name <group>
aws iam remove-user-from-group --user-name <user> --group-name <group>
aws iam list-policies
aws iam attach-user-policy --user-name <user> --policy-arn <arn>
aws iam detach-user-policy --user-name <user> --policy-arn <arn>
aws iam list-attached-user-policies --user-name <user>
aws iam list-user-policies --user-name <user>
aws iam put-user-policy --user-name <user> --policy-name <name> --policy-document <json>
aws iam delete-user-policy --user-name <user> --policy-name <name>

# IAM Roles
aws iam list-roles
aws iam create-role --role-name <name> --assume-role-policy-document file://trust.json
aws iam delete-role --role-name <role>
aws iam attach-role-policy --role-name <role> --policy-arn <arn>
aws iam detach-role-policy --role-name <role> --policy-arn <arn>
aws iam list-attached-role-policies --role-name <role>
aws iam pass-role --role <role>

# IAM Policies
aws iam list-policies --scope Local
aws iam create-policy --policy-name <name> --policy-document file://policy.json
aws iam delete-policy --policy-arn <arn>
aws iam get-policy --policy-arn <arn>
aws iam get-policy-version --policy-arn <arn> --version-id <id>

# IAM Instance Profiles
aws iam list-instance-profiles
aws iam create-instance-profile --instance-profile-name <name>
aws iam delete-instance-profile --instance-profile-name <name>
aws iam add-role-to-instance-profile --instance-profile-name <profile> --role-name <role>
aws iam remove-role-from-instance-profile --instance-profile-name <profile> --role-name <role>

# STS (Security Token)
aws sts get-caller-identity
aws sts assume-role --role-arn <arn> --role-session-name <name>
aws sts get-session-token --duration-seconds 3600
aws sts assume-role-with-saml --role-arn <arn> --principal-arn <arn> --saml-assertion <assertion>

# SQS (Queues)
aws sqs list-queues
aws sqs create-queue --queue-name <name>
aws sqs delete-queue --queue-url <url>
aws sqs get-queue-attributes --queue-url <url> --attribute-names All
aws sqs set-queue-attributes --queue-url <url> --attributes VisibilityTimeout=30
aws sqs send-message --queue-url <url> --message-body <message>
aws sqs receive-message --queue-url <url> --max-number-of-messages 10
aws sqs delete-message --queue-url <url> --receipt-handle <handle>
aws sqs purge-queue --queue-url <url>
aws sqs add-permission --queue-url <url> --label <label> --aws-account-ids <id> --actions <action>

# SNS (Notifications)
aws sns list-topics
aws sns create-topic --name <name>
aws sns delete-topic --topic-arn <arn>
aws sns subscribe --topic-arn <arn> --protocol email --notification-endpoint <email>
aws sns unsubscribe --subscription-arn <arn>
aws sns publish --topic-arn <arn> --message <message>
aws sns set-topic-attributes --topic-arn <arn> --attribute-name DisplayName --attribute-value <name>
aws sns list-subscriptions

# CloudFormation (Infrastructure as Code)
aws cloudformation list-stacks
aws cloudformation describe-stacks --stack-name <name>
aws cloudformation create-stack --stack-name <name> --template-body file://template.json
aws cloudformation delete-stack --stack-name <name>
aws cloudformation update-stack --stack-name <name> --template-body file://template.json
aws cloudformation describe-stack-events --stack-name <name>
aws cloudformation wait stack-create-complete --stack-name <name>
aws cloudformation cancel-update-stack --stack-name <name>

# Systems Manager (SSM)
aws ssm describe-parameters
aws ssm get-parameter --name <name>
aws ssm put-parameter --name <name> --value <value> --type String
aws ssm delete-parameter --name <name>
aws ssm send-command --instance-ids <id> --document-name "AWS-RunShellScript" --parameters commands=["ls -la"]
aws ssm list-command-invocations --command-id <id>

# Secrets Manager
aws secretsmanager list-secrets
aws secretsmanager create-secret --name <name> --secret-string <value>
aws secretsmanager get-secret-value --secret-id <name>
aws secretsmanager update-secret --secret-id <name> --secret-string <new-value>
aws secretsmanager delete-secret --secret-id <name> --force-delete
aws secretsmanager rotate-secret --secret-id <name>

# EKS (Kubernetes)
aws eks list-clusters
aws eks describe-cluster --name <cluster>
aws eks create-cluster --name <name> --role-arn <arn> --resources-vpc-config subnetIds=<subnet>,securityGroupIds=<sg>
aws eks delete-cluster --name <cluster>
aws eks update-cluster-config --name <cluster> --logging '{"clusterLogging":[{"types":["api","audit","authenticator","controllerManager","scheduler"],"enabled":true}]}'
aws eks list-nodegroups --cluster-name <cluster>
aws eks create-nodegroup --cluster-name <cluster> --nodegroup-name <name> --node-role <arn> --instance-types <type> --scaling-config minSize=1,maxSize=5,desiredSize=2
aws eks delete-nodegroup --cluster-name <cluster> --nodegroup-name <name>
aws eks update-nodegroup-config --cluster-name <cluster> --nodegroup-name <name> --scaling-config minSize=2,maxSize=10,desiredSize=3
aws eks describe-nodegroup --cluster-name <cluster> --nodegroup-name <name>
aws eks list-addons --cluster-name <cluster>
aws eks create-addon --cluster-name <cluster> --addon-name <name>
aws eks update-addon --cluster-name <cluster> --addon-name <name>
aws eks delete-addon --cluster-name <cluster> --addon-name <name>
aws eks access-entry create --cluster-name <name> --principal-arn <arn> --type STANDARD
aws eks list-access-entries --cluster-name <name>
aws eks delete-access-entry --cluster-name <name> --principal-arn <arn>

# EKS Identity Provider Config
aws eks list-identity-provider-configs --cluster-name <name>

# EKS Access Policy Association
aws eks associate-access-policy --cluster-name <name> --principal-arn <arn> --policy-arn <arn> --access-scope type=namespace,namespaces=<ns>

# ElastiCache
aws elasticache describe-cache-clusters
aws elasticache create-cache-cluster --cache-cluster-id <id> --cache-node-type cache.t3.micro --engine redis --num-cache-nodes 1
aws elasticache delete-cache-cluster --cache-cluster-id <id>
aws elasticache describe-replication-groups
aws elasticache create-replication-group --replication-group-id <id> --description <desc> --num-cache-clusters 2

# CloudWatch Logs
aws logs describe-log-groups
aws logs create-log-group --log-group-name <name>
aws logs delete-log-group --log-group-name <name>
aws logs describe-log-streams --log-group-name <name>
aws logs get-log-events --log-group-name <name> --log-stream-name <stream>
aws logs filter-log-events --log-group-name <name> --filter-pattern <pattern>
aws logs put-log-events --log-group-name <name> --log-stream-name <stream> --log-events '[{"timestamp": 1234567890, "message": "test"}]'

# Cognito
aws cognito-idp list-user-pools
aws cognito-idp create-user-pool --pool-name <name>
aws cognito-idp delete-user-pool --user-pool-id <id>
aws cognito-idp list-user-pool-clients --user-pool-id <id>
aws cognito-idp create-user-pool-client --user-pool-id <id> --client-name <name>
aws cognito-idp sign-up --client-id <id> --username <user> --password <pw>
aws cognito-idp admin-create-user --user-pool-id <id> --username <user>
aws cognito-idp admin-delete-user --user-pool-id <id> --username <user>
aws cognito-idp admin-list-users --user-pool-id <id>

# CodePipeline
aws codepipeline list-pipelines
aws codepipeline create-pipeline --pipeline file://pipeline.json
aws codepipeline delete-pipeline --name <name>
aws codepipeline get-pipeline --name <name>
aws codepipeline start-pipeline-execution --name <name>

# CodeBuild
aws codebuild list-projects
aws codebuild create-project --name <name> --source type=S3,location=<bucket>/<path> --artifacts type=NO_ARTIFACTS --environment type=LINUX_CONTAINER,computeType=BUILD_GENERAL1_SMALL,image=aws/codebuild/standard:7.0
aws codebuild delete-project --name <name>
aws codebuild start-build --project-name <name>
aws codebuild batch-get-builds --ids <id>

# App Runner
aws apprunner list-services
aws apprunner create-service --service-name <name> --source-configuration '{"ImageRepository": {"ImageIdentifier": "<image>", "ImageRepositoryType": "ECR", "ImageConfiguration": {"Port": "8080"}}, "AutoDeploymentsEnabled": true, "AuthenticationConfiguration": {"AccessRoleArn": "<role>"}}'
aws apprunner delete-service --service-arn <arn>
aws apprunner describe-service --service-arn <arn>
aws apprunner start-deployment --service-arn <arn>

# Fargate
aws ecs list-clusters --include FARGATE
aws ecs list-services --cluster <cluster> --launch-type FARGATE

# Output Format
aws ec2 describe-instances --output json
aws ec2 describe-instances --output table
aws ec2 describe-instances --output text

# Filters
aws ec2 describe-instances --filters "Name=instance-state-name,Values=running"
aws ec2 describe-instances --filters "Name=tag:Name,Values=my*"

# Pagination
aws ec2 describe-instances --max-results 100
aws iam list-users --max-items 100

# Regions
aws ec2 describe-regions --output table
aws configure set default.region us-east-1

# Pricing
aws pricing get-products --service-code AmazonEC2 --filters "InstanceType=t2.micro"

# Cost Explorer
aws ce get-cost-and-usage --time-period Start=<start>,End=<end> --granularity MONTHLY --metrics "UnblendedCost"

# Budgets
aws budgets describe-budgets --account-id <id>
aws budgets create-budget --account-id <id> --budget file://budget.json

# Organizations
aws organizations list-accounts
aws organizations describe-organization

# GuardDuty
aws guardduty list-detectors
aws guardduty create-detector --enable
aws guardduty delete-detector --detector-id <id>

# Inspector
aws inspector list-assessment-targets
aws inspector2 list-findings
aws inspector2 create-findings-report --report-format JSON --s3-destination bucketArn=<arn>

# Config
aws configservice describe-configuration-recorders
aws configservice start-configuration-recorder --configuration-recorder-name <name>

# CloudTrail
aws cloudtrail describe-trails
aws cloudtrail create-trail --name <name> --s3-bucket-name <bucket>
aws cloudtrail delete-trail --name <name>
aws cloudtrail start-logging --name <name>
aws cloudtrail stop-logging --name <name>
aws cloudtrail lookup-events --lookup-attributes AttributeKey=EventName,AttributeValue=RunInstances

# Health
aws health describe-events
aws health describe-event-details --event-arns <arn>

# Trusted Advisor
aws support describe-trusted-advisor-checks

# Shell Completions
complete -C '/usr/local/bin/aws_completer' aws
