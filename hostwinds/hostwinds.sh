# Hostwinds API — US network (REST API via curl)

export HOSTWINDS_API_EMAIL="you@example.com"
export HOSTWINDS_API_KEY="api-key"
export HOSTWINDS_API_URL="https://clients.hostwinds.com/includes/api.php"

# Products & Services
curl -X POST "$HOSTWINDS_API_URL" -d "action=GetClientsProducts" -d "username=$HOSTWINDS_API_EMAIL" -d "password=$HOSTWINDS_API_KEY" -d "responsetype=json"
curl -X POST "$HOSTWINDS_API_URL" -d "action=GetClientsProducts" -d "username=$HOSTWINDS_API_EMAIL" -d "password=$HOSTWINDS_API_KEY" -d "responsetype=json" -d "pid=PRODUCT_ID"
curl -X POST "$HOSTWINDS_API_URL" -d "action=GetClientProducts" -d "username=$HOSTWINDS_API_EMAIL" -d "password=$HOSTWINDS_API_KEY" -d "responsetype=json" -d "serviceid=SERVICE_ID"

# Server Management
curl -X POST "$HOSTWINDS_API_URL" -d "action=ClientAddVirtualServer" -d "username=$HOSTWINDS_API_EMAIL" -d "password=$HOSTWINDS_API_KEY" -d "responsetype=json" -d "plan=PLAN_ID" -d "os=OS_ID"
curl -X POST "$HOSTWINDS_API_URL" -d "action=ClientSuspendService" -d "username=$HOSTWINDS_API_EMAIL" -d "password=$HOSTWINDS_API_KEY" -d "responsetype=json" -d "serviceid=SERVICE_ID"
curl -X POST "$HOSTWINDS_API_URL" -d "action=ClientUnsuspendService" -d "username=$HOSTWINDS_API_EMAIL" -d "password=$HOSTWINDS_API_KEY" -d "responsetype=json" -d "serviceid=SERVICE_ID"
curl -X POST "$HOSTWINDS_API_URL" -d "action=ClientTerminateService" -d "username=$HOSTWINDS_API_EMAIL" -d "password=$HOSTWINDS_API_KEY" -d "responsetype=json" -d "serviceid=SERVICE_ID"
curl -X POST "$HOSTWINDS_API_URL" -d "action=ClientRebootService" -d "username=$HOSTWINDS_API_EMAIL" -d "password=$HOSTWINDS_API_KEY" -d "responsetype=json" -d "serviceid=SERVICE_ID"
curl -X POST "$HOSTWINDS_API_URL" -d "action=ClientPowerOnService" -d "username=$HOSTWINDS_API_EMAIL" -d "password=$HOSTWINDS_API_KEY" -d "responsetype=json" -d "serviceid=SERVICE_ID"
curl -X POST "$HOSTWINDS_API_URL" -d "action=ClientPowerOffService" -d "username=$HOSTWINDS_API_EMAIL" -d "password=$HOSTWINDS_API_KEY" -d "responsetype=json" -d "serviceid=SERVICE_ID"

# DNS
curl -X POST "$HOSTWINDS_API_URL" -d "action=ClientGetDNSZones" -d "username=$HOSTWINDS_API_EMAIL" -d "password=$HOSTWINDS_API_KEY" -d "responsetype=json" -d "clientid=CLIENT_ID"
curl -X POST "$HOSTWINDS_API_URL" -d "action=ClientGetDNSZoneRecords" -d "username=$HOSTWINDS_API_EMAIL" -d "password=$HOSTWINDS_API_KEY" -d "responsetype=json" -d "zoneid=ZONE_ID"
curl -X POST "$HOSTWINDS_API_URL" -d "action=ClientAddDNSRecord" -d "username=$HOSTWINDS_API_EMAIL" -d "password=$HOSTWINDS_API_KEY" -d "responsetype=json" -d "zoneid=ZONE_ID" -d "type=A" -d "record=www" -d "value=1.2.3.4" -d "ttl=300"
curl -X POST "$HOSTWINDS_API_URL" -d "action=ClientDeleteDNSRecord" -d "username=$HOSTWINDS_API_EMAIL" -d "password=$HOSTWINDS_API_KEY" -d "responsetype=json" -d "recordid=RECORD_ID"

# Billing
curl -X POST "$HOSTWINDS_API_URL" -d "action=GetInvoices" -d "username=$HOSTWINDS_API_EMAIL" -d "password=$HOSTWINDS_API_KEY" -d "responsetype=json"
curl -X POST "$HOSTWINDS_API_URL" -d "action=GetInvoiceDetails" -d "username=$HOSTWINDS_API_EMAIL" -d "password=$HOSTWINDS_API_KEY" -d "responsetype=json" -d "invoiceid=INVOICE_ID"
curl -X POST "$HOSTWINDS_API_URL" -d "action=GetPaymentMethods" -d "username=$HOSTWINDS_API_EMAIL" -d "password=$HOSTWINDS_API_KEY" -d "responsetype=json"
curl -X POST "$HOSTWINDS_API_URL" -d "action=AddPaymentMethod" -d "username=$HOSTWINDS_API_EMAIL" -d "password=$HOSTWINDS_API_KEY" -d "responsetype=json" -d "cardnumber=XXXX" -d "expirymonth=MM" -d="expiryyear=YY" -d "cccvv=CVV"

# Tickets
curl -X POST "$HOSTWINDS_API_URL" -d "action=GetTickets" -d "username=$HOSTWINDS_API_EMAIL" -d "password=$HOSTWINDS_API_KEY" -d "responsetype=json"
curl -X POST "$HOSTWINDS_API_URL" -d "action=OpenTicket" -d "username=$HOSTWINDS_API_EMAIL" -d "password=$HOSTWINDS_API_KEY" -d "responsetype=json" -d "deptid=1" -d "subject=Issue" -d "message=Description" -d "urgency=medium"
curl -X POST "$HOSTWINDS_API_URL" -d "action=ReplyTicket" -d "username=$HOSTWINDS_API_EMAIL" -d "password=$HOSTWINDS_API_KEY" -d "responsetype=json" -d "ticketid=TICKET_ID" -d "message=Reply text"
curl -X POST "$HOSTWINDS_API_URL" -d "action=CloseTicket" -d "username=$HOSTWINDS_API_EMAIL" -d "password=$HOSTWINDS_API_KEY" -d "responsetype=json" -d "ticketid=TICKET_ID"

# Monitoring
curl -X POST "$HOSTWINDS_API_URL" -d "action=GetMonitoringServices" -d "username=$HOSTWINDS_API_EMAIL" -d "password=$HOSTWINDS_API_KEY" -d "responsetype=json"
curl -X POST "$HOSTWINDS_API_URL" -d "action=AddMonitoringService" -d "username=$HOSTWINDS_API_EMAIL" -d "password=$HOSTWINDS_API_KEY" -d "responsetype=json" -d "type=http" -d "value=http://example.com" -d "interval=5"
curl -X POST "$HOSTWINDS_API_URL" -d "action=DeleteMonitoringService" -d "username=$HOSTWINDS_API_EMAIL" -d "password=$HOSTWINDS_API_KEY" -d "responsetype=json" -d "monitoringid=MONITOR_ID"

# SSH Access
ssh root@SERVER_IP
ssh -p PORT user@SERVER_IP
ssh -i ~/.ssh/custom_key root@SERVER_IP
ssh root@SERVER_IP "uname -a && df -h"
ssh root@SERVER_IP "systemctl status hwagent"
ssh root@SERVER_IP "systemctl restart hwagent"
ssh root@SERVER_IP "tail -f /var/log/syslog"
ssh root@SERVER_IP "docker ps -a"
ssh root@SERVER_IP "netstat -tlnp"

# File Transfer
scp ./myfile.txt root@SERVER_IP:/root/
scp root@SERVER_IP:/var/log/syslog ./
rsync -avz ./site/ root@SERVER_IP:/var/www/site/
rsync -avz --delete ./site/ root@SERVER_IP:/var/www/site/
rsync -avz -e "ssh -p PORT" ./site/ root@SERVER_IP:/var/www/site/
scp -r ./dir/ root@SERVER_IP:/root/dir/
scp -P PORT ./file.txt user@SERVER_IP:/path/
