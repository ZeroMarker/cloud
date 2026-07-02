# Google Cloud Platform (gcloud) CLI commands

# Install
curl https://sdk.cloud.google.com | bash
# or
brew install --cask google-cloud-sdk

# Authentication
gcloud auth login
gcloud auth activate-service-account --key-file=key.json
gcloud auth list
gcloud config set account <account>
gcloud config set project <project-id>
gcloud config set compute/region <region>
gcloud config set compute/zone <zone>
gcloud config list

# Compute Engine (VMs)
gcloud compute instances list
gcloud compute instances describe <instance> --zone=<zone>
gcloud compute instances create <instance> --zone=<zone> --machine-type=<type> --image-family=<image> --image-project=ubuntu-os-cloud
gcloud compute instances create <instance> --zone=<zone> --machine-type=e2-micro --image-family=ubuntu-2204-lts --image-project=ubuntu-os-cloud --boot-disk-size=10GB
gcloud compute instances delete <instance> --zone=<zone>
gcloud compute instances start <instance> --zone=<zone>
gcloud compute instances stop <instance> --zone=<zone>
gcloud compute instances reset <instance> --zone=<zone>
gcloud compute instances update <instance> --zone=<zone> --update-labels=key=value
gcloud compute instances add-tags <instance> --zone=<zone> --tags=tag1,tag2
gcloud compute instances remove-tags <instance> --zone=<zone> --tags=tag1
gcloud compute instances set-machine-type <instance> --zone=<zone> --machine-type=<type>
gcloud compute instances add-metadata <instance> --zone=<zone> --metadata=key=value
gcloud compute ssh <instance> --zone=<zone>
gcloud compute scp <file> <instance>:<path> --zone=<zone>
gcloud compute scp <instance>:<path> <file> --zone=<zone>
gcloud compute instances disk-utils <instance> --zone=<zone>
gcloud compute instances snapshot <instance> --zone=<zone> --snapshot-names=<name>

# Instance Templates
gcloud compute instance-templates list
gcloud compute instance-templates describe <template>
gcloud compute instance-templates create <template> --machine-type=<type> --image-family=<image> --image-project=ubuntu-os-cloud
gcloud compute instance-templates delete <template>

# Instance Groups
gcloud compute instance-groups list
gcloud compute instance-groups unmanaged list
gcloud compute instance-groups managed list
gcloud compute instance-groups managed create <group> --template=<template> --size=<count> --zone=<zone>
gcloud compute instance-groups managed resize <group> --size=<count> --zone=<zone>
gcloud compute instance-groups managed delete <group> --zone=<zone>

# Disks
gcloud compute disks list
gcloud compute disks describe <disk> --zone=<zone>
gcloud compute disks create <disk> --zone=<zone> --size=<size> --type=<type>
gcloud compute disks delete <disk> --zone=<zone>
gcloud compute disks resize <disk> --zone=<zone> --size=<new-size>
gcloud compute disks snapshot <disk> --zone=<zone> --snapshot-names=<name>
gcloud compute disks snapshot <disk> --zone=<zone> --device-name=<device>
gcloud compute disks add-labels <disk> --zone=<zone> --labels=key=value

# Snapshots
gcloud compute snapshots list
gcloud compute snapshots describe <snapshot>
gcloud compute snapshots delete <snapshot>
gcloud compute snapshots create <snapshot> --source-disk=<disk> --source-disk-zone=<zone>
gcloud compute snapshots add-labels <snapshot> --labels=key=value
gcloud compute snapshots export <snapshot> --image-uri=<gcs-path>

# Images
gcloud compute images list
gcloud compute images describe <image>
gcloud compute images create <image> --source-uri=<gcs-path> --family=<family>
gcloud compute images delete <image>
gcloud compute images add-labels <image> --labels=key=value
gcloud compute images deprecate <image>

# Machine Types
gcloud compute machine-types list --zones=<zone>
gcloud compute machine-types zones list

# Zones / Regions
gcloud compute zones list
gcloud compute regions list
gcloud compute regions describe <region>
gcloud compute regions list-unavailable

# Load Balancing
gcloud compute backend-services list
gcloud compute backend-services create <name> --protocol=http --global
gcloud compute backend-services add-backend <name> --instance-group=<group> --instance-group-zone=<zone> --global
gcloud compute url-maps list
gcloud compute url-maps create <name> --default-service=<backend>
gcloud compute target-http-proxies list
gcloud compute target-http-proxies create <name> --url-map=<url-map>
gcloud compute forwarding-rules list --global
gcloud compute forwarding-rules create <name> --global --target-http-proxy=<proxy> --ports=80
gcloud compute health-checks create http <name> --port=80
gcloud compute health-checks create tcp <name> --port=22

# Firewall Rules
gcloud compute firewall-rules list
gcloud compute firewall-rules describe <rule>
gcloud compute firewall-rules create <rule> --allow=tcp:80,tcp:443 --source-ranges=0.0.0.0/0
gcloud compute firewall-rules create <rule> --allow=tcp:22 --source-ranges=0.0.0.0/0 --target-tags=web
gcloud compute firewall-rules delete <rule>
gcloud compute firewall-rules update <rule> --allow=tcp:80,tcp:443,tcp:8080

# Networks
gcloud compute networks list
gcloud compute networks describe <network>
gcloud compute networks create <network> --subnet-mode=auto
gcloud compute networks create <network> --subnet-mode=custom
gcloud compute networks delete <network>
gcloud compute networks subnets list
gcloud compute networks subnets describe <subnet> --region=<region>
gcloud compute networks subnets create <subnet> --network=<network> --region=<region> --range=<cidr>
gcloud compute networks subnets update <subnet> --region=<region> --enable-private-ip-google-access

# Static IPs
gcloud compute addresses list
gcloud compute addresses describe <address> --region=<region>
gcloud compute addresses create <address> --region=<region>
gcloud compute addresses delete <address> --region=<region>

# Routers
gcloud compute routers list
gcloud compute routers create <router> --network=<network> --region=<region>
gcloud compute routers nats list --router=<router> --region=<region>
gcloud compute routers nats create <nat> --router=<router> --region=<region> --nat-auto-allocate-ip-addresses --nat-all-subnet-ip-ranges

# VPN
gcloud compute vpn-tunnels list --region=<region>
gcloud compute vpn-gateways list --region=<region>
gcloud compute vpn-gateways create <name> --network=<network> --region=<region>
gcloud compute target-vpn-gateways list --region=<region>

# Persistent Disk Snapshots
gcloud compute resource-policies list
gcloud compute resource-policies create snapshot-schedule <name> --region=<region> --max-retention-days=7 --daily-schedule

# Target Pools
gcloud compute target-pools list --regions=<region>
gcloud compute target-pools create <name> --region=<region>
gcloud compute target-pools add-instances <name> --instances=<instance> --instances-zone=<zone>

# HTTP(S) SSL Certificates
gcloud compute ssl-certificates list
gcloud compute ssl-certificates create <name> --certificate=<cert-file> --private-key=<key-file>

# Managed Instance Groups (MIGs)
gcloud compute instance-groups managed list
gcloud compute instance-groups managed create <group> --base-instance-name=<name> --template=<template> --size=<count> --zone=<zone>
gcloud compute instance-groups managed resize <group> --size=<count> --zone=<zone>
gcloud compute instance-groups managed set-autoscaling <group> --zone=<zone> --min-num-replicas=1 --max-num-replicas=10 --target-cpu-utilization=0.7
gcloud compute instance-groups managed rolling-action replace <group> --zone=<zone> --max-unavailable=1
gcloud compute instance-groups managed rolling-action start-update <group> --version template=<template> --zone=<zone>
gcloud compute instance-groups managed describe <group> --zone=<zone>

# Cloud Storage (GCS)
gsutil ls
gsutil ls gs://<bucket>
gsutil ls -lh gs://<bucket>/<path>
gsutil cp <file> gs://<bucket>/<path>
gsutil cp gs://<bucket>/<path> <file>
gsutil cp -r <dir> gs://<bucket>/
gsutil mv <file> gs://<bucket>/<path>
gsutil rm gs://<bucket>/<path>
gsutil rm -r gs://<bucket>/<path>
gsutil mkdir gs://<bucket>
gsutil rb gs://<bucket>
gsutil defstorageclass set <class> gs://<bucket>
gsutil versioning set on gs://<bucket>
gsutil lifecycle set <json-file> gs://<bucket>
gsutil cors set <json-file> gs://<bucket>
gsutil iam get gs://<bucket>
gsutil iam ch allUsers:objectViewer gs://<bucket>
gsutil signurl -d 1h <file> gs://<bucket>/<path>

# Kubernetes Engine (GKE)
gcloud container clusters list
gcloud container clusters describe <cluster> --zone=<zone>
gcloud container clusters create <cluster> --zone=<zone> --num-nodes=<count> --machine-type=<type>
gcloud container clusters create <cluster> --zone=<zone> --num-nodes=3 --machine-type=e2-standard-2 --enable-autoscaling --min-nodes=1 --max-nodes=5
gcloud container clusters delete <cluster> --zone=<zone>
gcloud container clusters get-credentials <cluster> --zone=<zone>
gcloud container clusters resize <cluster> --zone=<zone> --num-nodes=<count>
gcloud container clusters update <cluster> --zone=<zone> --enable-autoscaling --min-nodes=1 --max-nodes=10
gcloud container node-pools list --cluster=<cluster> --zone=<zone>
gcloud container node-pools create <pool> --cluster=<cluster> --zone=<zone> --num-nodes=<count> --machine-type=<type>
gcloud container node-pools delete <pool> --cluster=<cluster> --zone=<zone>
gcloud container node-pools resize <pool> --cluster=<cluster> --zone=<zone> --num-nodes=<count>
gcloud container operations list
gcloud container get-server-config --zone=<zone>

# Cloud SQL
gcloud sql instances list
gcloud sql instances describe <instance>
gcloud sql instances create <instance> --database-version=MYSQL_8_0 --tier=db-f1-micro --region=<region>
gcloud sql instances create <instance> --database-version=POSTGRES_14 --tier=db-f1-micro --region=<region>
gcloud sql instances delete <instance>
gcloud sql instances start <instance>
gcloud sql instances stop <instance>
gcloud sql instances patch <instance> --tier=db-g1-small
gcloud sql databases list --instance=<instance>
gcloud sql databases create <db> --instance=<instance>
gcloud sql databases delete <db> --instance=<instance>
gcloud sql users list --instance=<instance>
gcloud sql users create <user> --instance=<instance> --password=<password>
gcloud sql users delete <user> --instance=<instance>
gcloud sql backups list --instance=<instance>
gcloud sql backups create --instance=<instance> --description=<desc>
gcloud sql export sql <instance> gs://<bucket>/<file> --database=<db>
gcloud sql import sql <instance> gs://<bucket>/<file> --database=<db>
gcloud sql connect <instance> --user=<user>
gcloud sql ssl-cert create --instance=<instance> --name=<cert-name>
gcloud sql ssl-cert list --instance=<instance>

# Cloud Spanner
gcloud spanner instances list
gcloud spanner instances describe <instance>
gcloud spanner instances create <instance> --display-name=<name> --num-nodes=<count> --config=regional-<region>
gcloud spanner instances delete <instance>
gcloud spanner instances update <instance> --num-nodes=<count>
gcloud spanner databases list --instance=<instance>
gcloud spanner databases create <db> --instance=<instance>
gcloud spanner databases delete <db> --instance=<instance>
gcloud spanner databases ddl update <db> --instance=<instance> --ddl=<sql>
gcloud spanner databases sessions list --database=<db> --instance=<instance>

# Cloud Firestore
gcloud firestore databases list
gcloud firestore export gs://<bucket>/
gcloud firestore import gs://<bucket>/<path>

# Cloud Functions
gcloud functions list
gcloud functions describe <function>
gcloud functions deploy <function> --runtime=nodejs20 --trigger-http --allow-unauthenticated
gcloud functions deploy <function> --runtime=python311 --trigger-bucket=gs://<bucket>
gcloud functions deploy <function> --runtime=nodejs20 --trigger-topic=<topic>
gcloud functions delete <function>
gcloud functions call <function> --data='{"key": "value"}'
gcloud functions logs read <function> --limit=50

# Cloud Run
gcloud run services list
gcloud run services describe <service> --region=<region>
gcloud run services deploy <service> --image=<image> --region=<region> --allow-unauthenticated
gcloud run services deploy <service> --image=<image> --region=<region> --min-instances=1 --max-instances=10 --memory=512Mi
gcloud run services delete <service> --region=<region>
gcloud run services update-traffic <service> --region=<region> --to-latest
gcloud run revisions list --service=<service> --region=<region>
gcloud run revisions delete <revision> --service=<service> --region=<region>
gcloud run domains list --service=<service> --region=<region>
gcloud run domains create --service=<service> --region=<region> --domain=<domain>
gcloud run jobs list --region=<region>
gcloud run jobs run <job> --region=<region>

# Pub/Sub
gcloud pubsub topics list
gcloud pubsub topics describe <topic>
gcloud pubsub topics create <topic>
gcloud pubsub topics delete <topic>
gcloud pubsub topics publish <topic> --message=<message>
gcloud pubsub subscriptions list
gcloud pubsub subscriptions create <sub> --topic=<topic>
gcloud pubsub subscriptions create <sub> --topic=<topic> --push-endpoint=<url>
gcloud pubsub subscriptions delete <sub>
gcloud pubsub subscriptions pull <sub> --auto-ack
gcloud pubsub schemas list
gcloud pubsub schemas create <schema> --type=avro --definition-file=<file>

# Cloud Tasks
gcloud tasks queues list --location=<region>
gcloud tasks queues create <queue> --location=<region>
gcloud tasks queues delete <queue> --location=<region>
gcloud tasks create --queue=<queue> --location=<region> --http-endpoint=<url> --http-method=POST --payload-body=<data>
gcloud tasks describe --queue=<queue> --location=<region> --task=<task>

# Cloud Build
gcloud builds list
gcloud builds describe <build-id>
gcloud builds submit --config=<config-file> --substitutions=<vars>
gcloud builds triggers list
gcloud builds triggers create github --repo-name=<repo> --repo-owner=<owner> --branch-pattern=<pattern> --build-config=<file>
gcloud builds triggers delete <trigger-id>

# Artifact Registry
gcloud artifacts repositories list
gcloud artifacts repositories describe <repo> --location=<region>
gcloud artifacts repositories create <repo> --repository-format=docker --location=<region>
gcloud artifacts repositories create <repo> --repository-format=maven --location=<region>
gcloud artifacts repositories delete <repo> --location=<region>
gcloud artifacts docker images list <repo>-docker.pkg.dev/<project>/<repo>
gcloud artifacts docker images delete <image>
gcloud artifacts maven artifacts list <repo>-maven.pkg.dev/<project>/<repo>

# Cloud Endpoints
gcloud endpoints services list
gcloud endpoints services describe <service>
gcloud endpoints services deploy <api-file>

# Cloud Logging
gcloud logging logs list
gcloud logging read "resource.type=gce_instance" --limit=100
gcloud logging write <log-name> "message" --severity=INFO
gcloud logging sinks list
gcloud logging sinks create <sink> storage.googleapis.com/<bucket> --log-filter=<filter>

# Cloud Monitoring
gcloud monitoring policies list
gcloud monitoring policies create --notification-channels=<channels> --condition-display-name=<name> --condition-filter=<filter>
gcloud monitoring channels list
gcloud monitoring channels create --display-name=<name> --type=email

# Cloud DNS
gcloud dns managed-zones list
gcloud dns managed-zones describe <zone>
gcloud dns managed-zones create <zone> --dns-name=<domain>. --description=<desc>
gcloud dns managed-zones delete <zone>
gcloud dns record-sets list --zone=<zone>
gcloud dns record-sets transaction start --zone=<zone>
gcloud dns record-sets transaction add @ A <ip> --name=<domain>. --zone=<zone> --ttl=300
gcloud dns record-sets transaction add www CNAME <target>. --name=<domain>. --zone=<zone> --ttl=300
gcloud dns record-sets transaction execute --zone=<zone>

# Cloud KMS
gcloud kms keyrings list --location=<location>
gcloud kms keyrings create <keyring> --location=<location>
gcloud kms keys list --keyring=<keyring> --location=<location>
gcloud kms keys create <key> --keyring=<keyring> --location=<location> --purpose=encryption
gcloud kms keys versions list --keyring=<keyring> --location=<location> --key=<key>
gcloud kms encrypt --key=<key> --keyring=<keyring> --location=<location> --plaintext-file=<in> --cipher-file=<out>
gcloud kms decrypt --key=<key> --keyring=<keyring> --location=<location> --cipher-file=<in> --plaintext-file=<out>

# Secret Manager
gcloud secrets list
gcloud secrets describe <secret>
gcloud secrets create <secret> --data-file=<file>
gcloud secrets versions access --secret=<secret>
gcloud secrets versions add <secret> --data-file=<file>
gcloud secrets add-iam-policy-binding <secret> --member=serviceAccount:<sa> --role=roles/secretmanager.secretAccessor

# Service Accounts
gcloud iam service-accounts list
gcloud iam service-accounts create <sa> --display-name=<name>
gcloud iam service-accounts delete <sa>
gcloud iam service-accounts keys create <key-file> --iam-account=<sa>
gcloud iam service-accounts keys delete <key-id> --iam-account=<sa>
gcloud iam service-accounts add-iam-policy-binding <sa> --member=serviceAccount:<sa> --role=roles/viewer

# IAM
gcloud projects get-iam-policy <project>
gcloud projects add-iam-policy-binding <project> --member=user:<email> --role=roles/viewer
gcloud projects remove-iam-policy-binding <project> --member=user:<email> --role=roles/viewer
gcloud iam roles list
gcloud iam roles describe <role>
gcloud iam roles create <role> --title=<title> --permissions=<perms>
gcloud iam roles update <role> --add-permissions=<perms>

# Projects
gcloud projects list
gcloud projects describe <project>
gcloud projects create <project> --name=<name>
gcloud projects delete <project>
gcloud projects update <project> --name=<new-name>
gcloud projects enable-service <project> --service=<api>

# Organizations
gcloud organizations list
gcloud organizations describe <org-id>

# Billing
gcloud billing accounts list
gcloud billing accounts describe <account-id>
gcloud billing projects link <project> --billing-account=<account-id>
gcloud billing projects unlink <project>

# Deploy
gcloud deploy releases list --service=<service> --region=<region>
gcloud deploy releases create <release> --service=<service> --region=<region> --delivery-pipeline=<pipeline>
gcloud deploy delivery-pipelines list --region=<region>
gcloud deploy targets list --delivery-pipeline=<pipeline> --region=<region>

# Cloud Composer
gcloud composer environments list
gcloud composer environments describe <env> --location=<region>
gcloud composer environments create <env> --location=<region> --environment-size=small
gcloud composer environments delete <env> --location=<region>
gcloud composer environments run <env> --location=<region> <command>

# Cloud Dataflow
gcloud dataflow jobs list --region=<region>
gcloud dataflow jobs describe <job-id> --region=<region>
gcloud dataflow jobs cancel <job-id> --region=<region>

# Cloud Dataproc
gcloud dataproc clusters list --region=<region>
gcloud dataproc clusters describe <cluster> --region=<region>
gcloud dataproc clusters create <cluster> --region=<region> --num-workers=<count>
gcloud dataproc clusters delete <cluster> --region=<region>
gcloud dataproc jobs submit spark --cluster=<cluster> --region=<region> --jars=<jar>
gcloud dataproc jobs list --cluster=<cluster> --region=<region>

# Compute Metadata
gcloud compute project-info describe
gcloud compute project-info update --metadata=enable-oslogin=TRUE

# Output Format
gcloud compute instances list --format=json
gcloud compute instances list --format="table(name, zone, status)"
gcloud compute instances list --format="value(name)"
gcloud compute instances list --format=yaml

# Filters
gcloud compute instances list --filter="status=RUNNING"
gcloud compute instances list --filter="zone:us-central1"
gcloud compute instances list --filter="labels.env=prod"

# Pagination
gcloud compute instances list --page-size=100
gcloud compute instances list --limit=50

# SSH
gcloud compute ssh <instance> --zone=<zone> --command="ls -la"
gcloud compute ssh <instance> --zone=<zone> --tunnel-through-iap

# Scopes
gcloud auth list --filter="account:service"
gcloud auth application-default login
gcloud auth application-default set-quota-project <project>

# Config
gcloud config configurations list
gcloud config configurations create <name>
gcloud config configurations activate <name>
gcloud config configurations delete <name>
gcloud config configurations describe <name>

# Component Manager
gcloud components list
gcloud components update
gcloud components install <component>
gcloud components remove <component>

# Docker
gcloud auth configure-docker
gcloud auth configure-docker us-central1-docker.pkg.dev
gcloud auth print-access-token

# Diagnose
gcloud compute diagnose <instance> --zone=<zone>
gcloud compute os-login ssh-keys list
gcloud compute os-login ssh-keys delete <key-fingerprint>

# Shell Completions
gcloud components install beta
gcloud components install docker-credential-gcr

# Version
gcloud --version
gcloud version
