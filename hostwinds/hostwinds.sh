# Hostwinds: US network

export HOSTWINDS_API_EMAIL="you@example.com"
export HOSTWINDS_API_KEY="api-key"
export HOSTWINDS_API_URL="https://clients.hostwinds.com/includes/api.php"

curl -X POST "$HOSTWINDS_API_URL" -d "action=GetClientsProducts" -d "username=$HOSTWINDS_API_EMAIL" -d "password=$HOSTWINDS_API_KEY" -d "responsetype=json"

curl -X POST "$HOSTWINDS_API_URL" -d "action=GetClientsProducts" -d "username=$HOSTWINDS_API_EMAIL" -d "password=$HOSTWINDS_API_KEY" -d "responsetype=json" -d "pid=PRODUCT_ID"

curl -X POST "$HOSTWINDS_API_URL" -d "action=GetInvoices" -d "username=$HOSTWINDS_API_EMAIL" -d "password=$HOSTWINDS_API_KEY" -d "responsetype=json"

curl -X POST "$HOSTWINDS_API_URL" -d "action=GetTickets" -d "username=$HOSTWINDS_API_EMAIL" -d "password=$HOSTWINDS_API_KEY" -d "responsetype=json"

ssh root@SERVER_IP

scp ./myfile.txt root@SERVER_IP:/root/

rsync -avz ./site/ root@SERVER_IP:/var/www/site/

ssh root@SERVER_IP "systemctl status hwagent"

ssh root@SERVER_IP "systemctl restart hwagent"
