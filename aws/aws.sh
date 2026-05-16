aws configure

aws ec2 describe-instances

aws ec2 describe-instances --query "Reservations[*].Instances[*].{ID:InstanceId,Type:InstanceType,State:State.Name,IP:PublicIpAddress}"

aws s3 ls

aws s3 cp myfile.txt s3://my-bucket/

aws s3 sync s3://my-bucket/ local-folder/

aws iam list-users

aws lambda list-functions

aws cloudformation list-stacks

aws ecs list-clusters

aws rds describe-db-instances

aws elbv2 describe-load-balancers
