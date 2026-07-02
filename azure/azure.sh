# Azure CLI commands

# Install
curl -sL https://aka.ms/InstallAzureCLI | bash

# Authentication
az login
az login --service-principal -u <app-id> -p <password> --tenant <tenant>
az logout
az account show
az account set --subscription <sub-id>
az account list --output table
az ad sp create-for-rbac --name <name> --password <pw>
az ad sp reset-credentials --name <app-id>

# VMs (Compute)
az vm list --output table
az vm show --resource-group <rg> --name <vm> --output table
az vm create --resource-group <rg> --name <vm> --image Ubuntu2204 --size Standard_B1s --admin-username azureuser --ssh-key-value ~/.ssh/id_rsa.pub
az vm create --resource-group <rg> --name <vm> --image Ubuntu2204 --size Standard_B1s --admin-username azureuser --generate-ssh-keys
az vm delete --resource-group <rg> --name <vm>
az vm start --resource-group <rg> --name <vm>
az vm stop --resource-group <rg> --name <vm>
az vm restart --resource-group <rg> --name <vm>
az vm deallocate --resource-group <rg> --name <vm>
az vm resize --resource-group <rg> --name <vm> --size Standard_B2s
az vm update --resource-group <rg> --name <vm> --set tags.env=prod
az vm open-port --resource-group <rg> --name <vm> --port 80
az vm list-ip-addresses --resource-group <rg> --name <vm>
az vm extension set --resource-group <rg> --vm-name <vm> --name customScript --command-file script.sh
az vm run-command invoke --resource-group <rg> --name <vm> --command-id RunShellScript --scripts "ls -la"
az vm capture --resource-group <rg> --name <vm> --vhd-name-prefix <prefix>
az vm generalize --resource-group <rg> --name <vm>

# VM Scale Sets
az vmss list --output table
az vmss create --resource-group <rg> --name <vmss> --image Ubuntu2204 --instance-count 2 --admin-username azureuser --generate-ssh-keys
az vmss delete --resource-group <rg> --name <vmss>
az vmss start --resource-group <rg> --name <vmss>
az vmss stop --resource-group <rg> --name <vmss>
az vmss restart --resource-group <rg> --name <vmss>
az vmss scale --resource-group <rg> --name <vmss> --new-capacity 5
az vmss update --resource-group <rg> --name <vmss> --set tags.env=prod

# Disks
az disk list --resource-group <rg> --output table
az disk create --resource-group <rg> --name <disk> --size-gb 100 --sku Premium_LRS
az disk delete --resource-group <rg> --name <disk>
az disk update --resource-group <rg> --name <disk> --set diskSizeGb=200
az disk snapshot create --resource-group <rg> --name <snap> --source <disk>
az disk snapshot list --resource-group <rg> --output table
az disk snapshot delete --resource-group <rg> --name <snap>

# Snapshots
az snapshot list --resource-group <rg> --output table
az snapshot create --resource-group <rg> --name <snap> --source <disk-id>
az snapshot delete --resource-group <rg> --name <snap>

# Images
az image list --resource-group <rg> --output table
az image create --resource-group <rg> --name <img> --source <vhd-uri>
az image delete --resource-group <rg> --name <img>

# NICs (Network Interfaces)
az network nic list --resource-group <rg> --output table
az network nic create --resource-group <rg> --name <nic> --vnet-name <vnet> --subnet <subnet>
az network nic delete --resource-group <rg> --name <nic>
az network nic ip-config list --resource-group <rg> --nic-name <nic> --output table
az network nic ip-config add --resource-group <rg> --nic-name <nic> --name <name> --public-ip-address <pip>
az network nic ip-config remove --resource-group <rg> --nic-name <nic> --name <name> --public-ip-address <pip>

# Public IPs
az network public-ip list --resource-group <rg> --output table
az network public-ip create --resource-group <rg> --name <pip> --sku Standard --allocation-method Static
az network public-ip delete --resource-group <rg> --name <pip>
az network public-ip show --resource-group <rg> --name <pip> --query ipAddress

# VNet (Virtual Network)
az network vnet list --resource-group <rg> --output table
az network vnet create --resource-group <rg> --name <vnet> --address-prefix 10.0.0.0/16
az network vnet delete --resource-group <rg> --name <vnet>
az network vnet show --resource-group <rg> --name <vnet>
az network vnet subnet list --resource-group <rg> --vnet-name <vnet> --output table
az network vnet subnet create --resource-group <rg> --vnet-name <vnet> --name <subnet> --address-prefix 10.0.1.0/24
az network vnet subnet update --resource-group <rg> --vnet-name <vnet> --name <subnet> --service-endpoints Microsoft.Storage Microsoft.KeyVault
az network vnet subnet delete --resource-group <rg> --vnet-name <vnet> --name <subnet>

# Network Security Groups (NSG)
az network nsg list --resource-group <rg> --output table
az network nsg create --resource-group <rg> --name <nsg>
az network nsg delete --resource-group <rg> --name <nsg>
az network nsg rule list --resource-group <rg> --nsg-name <nsg> --output table
az network nsg rule create --resource-group <rg> --nsg-name <nsg> --name <rule> --priority 100 --access Allow --protocol Tcp --direction Inbound --source-address-prefixes 0.0.0.0/0 --destination-port-ranges 80
az network nsg rule update --resource-group <rg> --nsg-name <nsg> --name <rule> --priority 100 --access Allow --protocol Tcp --direction Inbound --source-address-prefixes 0.0.0.0/0 --destination-port-ranges 80 443
az network nsg rule delete --resource-group <rg> --nsg-name <nsg> --name <rule>

# Application Security Groups
az network asg list --resource-group <rg> --output table
az network asg create --resource-group <rg> --name <asg>
az network asg delete --resource-group <rg> --name <asg>

# Load Balancers
az network lb list --resource-group <rg> --output table
az network lb create --resource-group <rg> --name <lb> --frontend-ip-name <pip> --backend-pool-name <pool> --public-ip-address <pip>
az network lb delete --resource-group <rg> --name <lb>
az network lb address-pool list --resource-group <rg> --lb-name <lb> --output table
az network lb address-pool update --resource-group <rg> --lb-name <lb> --name <pool> --vm <vm> --vm-scale-set <vmss>
az network lb probe create --resource-group <rg> --lb-name <lb> --name <probe> --protocol tcp --port 80
az network lb rule create --resource-group <rg> --lb-name <lb> --name <rule> --frontend-port 80 --backend-port 80 --protocol tcp
az network lb rule delete --resource-group <rg> --lb-name <lb> --name <rule>

# Application Gateways
az network application-gateway list --resource-group <rg> --output table
az network application-gateway create --resource-group <rg> --name <appgw> --sku Standard_v2 --capacity 2 --frontend-subnet <subnet> --routing-rule-type Basic --backend-pool-name <pool>

# Firewalls
az network firewall list --resource-group <rg> --output table
az network firewall create --resource-group <rg> --name <fw> --sku AZFW_VNet --tier Standard
az network firewall delete --resource-group <rg> --name <fw>
az network firewall ip-config create --resource-group <rg> --firewall-name <fw> --name <config> --public-ip-address <pip> --vnet-name <vnet>
az network firewall application-rule create --resource-group <rg> --firewall-name <fw> --collection-name <coll> --name <rule> --source-addresses 10.0.0.0/16 --target-fqdns google.com --protocols http=80 https=443 --action Allow
az network firewall network-rule create --resource-group <rg> --firewall-name <fw> --collection-name <coll> --name <rule> --source-addresses 10.0.0.0/16 --destination-addresses * --destination-ports 80 443 --protocols TCP --action Allow
az network firewall nat-rule create --resource-group <rg> --firewall-name <fw> --collection-name <coll> --name <rule> --source-addresses 10.0.0.0/16 --destination-addresses <pip> --destination-ports 3389 --protocols TCP --translated-address <vm-ip> --translated-port 3389 --action Dnat

# VPN Gateway
az network vnet-gateway list --resource-group <rg> --output table
az network vnet-gateway create --resource-group <rg> --name <gw> --vnet <vnet> --public-ip-addresses <pip> --sku VpnGw1
az network vnet-gateway delete --resource-group <rg> --name <gw>
az network vnet-gateway list-connections --resource-group <rg> --name <gw> --output table
az network vnet-gateway connection create --resource-group <rg> --name <conn> --vnet-gateway <gw> --peer-remote-gateway <ip> --shared-key <key> --enable-bgp

# Route Tables
az network route-table list --resource-group <rg> --output table
az network route-table create --resource-group <rg> --name <rt>
az network route-table delete --resource-group <rg> --name <rt>
az network route-table route list --resource-group <rg> --route-table-name <rt> --output table
az network route-table route create --resource-group <rg> --route-table-name <rt> --name <route> --address-prefix 0.0.0.0/0 --next-hop-type VirtualAppliance --next-hop-ip-address <ip>

# DNS Zones
az network dns zone list --resource-group <rg> --output table
az network dns zone create --resource-group <rg> --name <domain>
az network dns zone delete --resource-group <rg> --name <domain>
az network dns record-set list -g <rg> -z <domain> --output table
az network dns record-set a add-record --resource-group <rg> --zone-name <domain> --record-set-name <sub> --ipv4-address <ip>
az network dns record-set cname add-record --resource-group <rg> --zone-name <domain> --record-set-name <sub> --cname <target>
az network dns record-set mx add-record --resource-group <rg> --zone-name <domain> --record-set-name @ --mail-server <mail> --priority 10
az network dns record-set txt add-record --resource-group <rg> --zone-name <domain> --record-set-name <sub> --value <value>
az network dns record-set a delete --resource-group <rg> --zone-name <domain> --record-set-name <sub>
az network dns record-set update --resource-group <rg> --zone-name <domain> --name <record> --ttl 3600

# Private DNS Zones
az network private-dns zone list --resource-group <rg> --output table
az network private-dns zone create --resource-group <rg> --name <domain>
az network private-dns zone delete --resource-group <rg> --name <domain>
az network private-dns record-set a add-record --resource-group <rg> --zone-name <domain> --record-set-name <sub> --ipv4-address <ip>
az network private-dns link create --resource-group <rg> --zone-name <domain> --name <link> --virtual-network <vnet>

# Storage Accounts
az storage account list --resource-group <rg> --output table
az storage account create --resource-group <rg> --name <name> --sku Standard_LRS --kind StorageV2
az storage account delete --resource-group <rg> --name <name>
az storage account show --resource-group <rg> --name <name> --query primaryEndpoints.blob
az storage account update --resource-group <rg> --name <name> --access-tier Hot
az storage container list --account-name <name> --output table
az storage container create --account-name <name> --name <container>
az storage container delete --account-name <name> --name <container>
az storage container set-permission --account-name <name> --name <container> --public-blob
az storage blob list --account-name <name> --container-name <container> --output table
az storage blob upload --account-name <name> --container-name <container> --name <blob> --file <path>
az storage blob download --account-name <name> --container-name <container> --name <blob> --file <path>
az storage blob delete --account-name <name> --container-name <container> --name <blob>
az storage blob copy start --account-name <name> --destination-container <container> --destination-blob <blob> --source-uri <url>

# SQL Database
az sql server list --resource-group <rg> --output table
az sql server create --resource-group <rg> --name <server> --location <location> --admin-user adminuser --admin-password <pw>
az sql server delete --resource-group <rg> --name <server>
az sql db list --resource-group <rg> --server <server> --output table
az sql db create --resource-group <rg> --server <server> --name <db> --service-tier Basic
az sql db delete --resource-group <rg> --server <server> --name <db>
az sql db show --resource-group <rg> --server <server> --name <db> --query connectionString

# Cosmos DB
az cosmosdb list --resource-group <rg> --output table
az cosmosdb create --resource-group <rg> --name <name> --kind GlobalDocumentDB
az cosmosdb delete --resource-group <rg> --name <name>
az cosmosdb list-keys --resource-group <rg> --name <name>

# Azure Database for MySQL
az mysql server list --resource-group <rg> --output table
az mysql server create --resource-group <rg> --name <server> --admin-user adminuser --admin-password <pw> --sku-name Standard_B1ms
az mysql server delete --resource-group <rg> --name <server>
az mysql db list --resource-group <rg> --server <server> --output table
az mysql db create --resource-group <rg> --server <server> --name <db>

# Azure Database for PostgreSQL
az postgres server list --resource-group <rg> --output table
az postgres server create --resource-group <rg> --name <server> --admin-user adminuser --admin-password <pw> --sku-name Standard_B1ms
az postgres server delete --resource-group <rg> --name <server>
az postgres db list --resource-group <rg> --server <server> --output table
az postgres db create --resource-group <rg> --server <server> --name <db>

# AKS (Kubernetes)
az aks list --resource-group <rg> --output table
az aks create --resource-group <rg> --name <cluster> --node-count 3 --enable-addons monitoring
az aks create --resource-group <rg> --name <cluster> --node-count 3 --node-vm-size Standard_B2s --enable-addons monitoring --generate-ssh-keys
az aks delete --resource-group <rg> --name <cluster>
az aks get-credentials --resource-group <rg> --name <cluster>
az aks show --resource-group <rg> --name <cluster>
az aks scale --resource-group <rg> --name <cluster> --node-count 5
az aks nodepool list --resource-group <rg> --cluster-name <cluster> --output table
az aks nodepool add --resource-group <rg> --cluster-name <cluster> --name <pool> --node-count 3 --node-vm-size Standard_B2s
az aks nodepool delete --resource-group <rg> --cluster-name <cluster> --name <pool>
az aks nodepool scale --resource-group <rg> --cluster-name <cluster> --name <pool> --node-count 5
az aks enable-addons --resource-group <rg> --name <cluster> --addons monitoring
az aks disable-addons --resource-group <rg> --name <cluster> --addons monitoring
az aks upgrade --resource-group <rg> --name <cluster> --kubernetes-version <version>

# Container Registry
az acr list --resource-group <rg> --output table
az acr create --resource-group <rg> --name <registry> --sku Basic
az acr delete --resource-group <rg> --name <registry>
az acr show --resource-group <rg> --name <registry>
az acr login --name <registry>
az acr repository list --name <registry> --output table
az acr repository delete --name <registry> --repository <repo>
az acr repository show-tags --name <registry> --repository <repo> --output table

# Function Apps
az functionapp list --resource-group <rg> --output table
az functionapp create --resource-group <rg> --name <app> --storage-account <sa> --consumption-plan-location <location> --runtime node
az functionapp delete --resource-group <rg> --name <app>
az functionapp show --resource-group <rg> --name <app>
az functionapp config appsettings list --resource-group <rg> --name <app>
az functionapp config appsettings set --resource-group <rg> --name <app> --settings KEY=VALUE

# App Service (Web Apps)
az webapp list --resource-group <rg> --output table
az webapp create --resource-group <rg> --name <app> --plan <plan> --runtime "NODE:18-lts"
az webapp delete --resource-group <rg> --name <app>
az webapp show --resource-group <rg> --name <app>
az webapp config appsettings list --resource-group <rg> --name <app>
az webapp config appsettings set --resource-group <rg> --name <app> --settings KEY=VALUE
az webapp config connection-string list --resource-group <rg> --name <app>
az webapp config connection-string set --resource-group <rg> --name <app> --connection-string-name <name> --connection-string-type SQLAzure --connection-string "Server=tcp:..."
az webapp deployment source config --resource-group <rg> --name <app> --repo-url <url> --branch main --manual-integration

# App Service Plans
az appservice plan list --resource-group <rg> --output table
az appservice plan create --resource-group <rg> --name <plan> --sku B1
az appservice plan delete --resource-group <rg> --name <plan>
az appservice plan show --resource-group <rg> --name <plan>

# Traffic Manager
az network traffic-manager profile list --resource-group <rg> --output table
az network traffic-manager profile create --resource-group <rg> --name <tm> --routing-method Priority --unique-dns-name <dns>
az network traffic-manager profile delete --resource-group <rg> --name <tm>
az network traffic-manager endpoint create --resource-group <rg> --profile-name <tm> --name <ep> --type azureEndpoints --target-resource-id <vm-id> --priority 1

# Front Door
az network front-door list --resource-group <rg> --output table
az network front-door create --resource-group <rg> --name <fd> --frontend-host-name <host> --backend-pool-name <pool> --backend-address <ip> --routing-rule-name <rule> --protocol HTTP

# Azure Cosmos DB
az cosmosdb list --resource-group <rg> --output table
az cosmosdb create --resource-group <rg> --name <name> --kind GlobalDocumentDB

# Key Vault
az keyvault list --resource-group <rg> --output table
az keyvault create --resource-group <rg> --name <vault> --enable-rbac-authorization false
az keyvault delete --resource-group <rg> --name <vault>
az keyvault secret set --vault-name <vault> --name <name> --value <value>
az keyvault secret show --vault-name <vault> --name <name>
az keyvault secret list --vault-name <vault> --output table
az keyvault key create --vault-name <vault> --name <name> --kty RSA --size 2048
az keyvault key list --vault-name <vault> --output table
az keyvault certificate create --vault-name <vault> --name <name> --policy @policy.json

# Service Bus
az servicebus namespace list --resource-group <rg> --output table
az servicebus namespace create --resource-group <rg> --name <ns> --sku Standard
az servicebus namespace delete --resource-group <rg> --name <ns>
az servicebus queue list --namespace-name <ns> --resource-group <rg> --output table
az servicebus queue create --namespace-name <ns> --resource-group <rg> --name <queue>
az servicebus queue delete --namespace-name <ns> --resource-group <rg> --name <queue>
az servicebus topic list --namespace-name <ns> --resource-group <rg> --output table
az servicebus topic create --namespace-name <ns> --resource-group <rg> --name <topic>
az servicebus topic delete --namespace-name <ns> --resource-group <rg> --name <topic>

# Event Hubs
az eventhubs namespace list --resource-group <rg> --output table
az eventhubs namespace create --resource-group <rg> --name <ns> --sku Standard
az eventhubs namespace delete --resource-group <rg> --name <ns>
az eventhubs eventhub list --namespace-name <ns> --resource-group <rg> --output table
az eventhubs eventhub create --namespace-name <ns> --resource-group <rg> --name <hub>
az eventhubs eventhub delete --namespace-name <ns> --resource-group <rg> --name <hub>

# Resource Groups
az group list --output table
az group create --name <rg> --location <location>
az group delete --name <rg>

# Resources
az resource list --resource-group <rg> --output table
az resource show --ids <resource-id>
az resource tag --ids <resource-id> --tags env=prod

# Role Assignments
az role assignment list --scope /subscriptions/<sub-id> --output table
az role assignment create --assignee <email> --role "Reader" --scope /subscriptions/<sub-id>
az role assignment delete --assignee <email> --role "Reader" --scope /subscriptions/<sub-id>

# Managed Identity
az identity list --resource-group <rg> --output table
az identity create --resource-group <rg> --name <name>
az identity delete --resource-group <rg> --name <name>
az identity show --resource-group <rg> --name <name>

# Monitor / Alerts
az monitor metrics list --resource <resource-id> --metric "Percentage CPU"
az monitor activity-log list --resource-group <rg>
az monitor action-group list --resource-group <rg> --output table
az monitor action-group create --resource-group <rg> --name <name> --short-name <short>
az monitor metric-alert create --resource-group <rg> --name <alert> --scopes <resource-id> --condition "avg Percentage CPU > 80" --action <action-group>

# Log Analytics
az monitor log-analytics workspace list --resource-group <rg> --output table
az monitor log-analytics workspace create --resource-group <rg> --workspace-name <workspace>
az monitor log-analytics workspace delete --resource-group <rg> --workspace-name <workspace>
az monitor log-analytics query --workspace <workspace> --analytics-query "Heartbeat | take 10"

# Output
az vm list --output json
az vm list --output table
az vm list --output tsv

# Filters
az vm list --query "[?tags.env=='prod']"

# Shell Completions
az completion bash >> ~/.bashrc
az completion zsh >> ~/.zshrc
