# Kamatera API — flexible scaling (REST API via curl)

export KAMATERA_CLIENT_ID="client-id"
export KAMATERA_SECRET="secret"
export KAMATERA_API_URL="https://console.kamatera.com/service"

# Authenticate
curl -X POST "$KAMATERA_API_URL/authenticate" -d "clientId=$KAMATERA_CLIENT_ID" -d "secret=$KAMATERA_SECRET"

# Servers
curl -X GET "$KAMATERA_API_URL/servers" -H "content-type: application/json" -H "clientId: $KAMATERA_CLIENT_ID" -H "secret: $KAMATERA_SECRET"

curl -X GET "$KAMATERA_API_URL/server/SERVER_ID" -H "content-type: application/json" -H "clientId: $KAMATERA_CLIENT_ID" -H "secret: $KAMATERA_SECRET"

curl -X POST "$KAMATERA_API_URL/server" -H "content-type: application/json" -H "clientId: $KAMATERA_CLIENT_ID" -H "secret: $KAMATERA_SECRET" -d '{"name":"my-server","datacenter":"US-NY2","cpu":"2B","ram":2048,"disk":"20","image":"ubuntu_server_24.04_64-bit"}'

curl -X DELETE "$KAMATERA_API_URL/server/SERVER_ID" -H "content-type: application/json" -H "clientId: $KAMATERA_CLIENT_ID" -H "secret: $KAMATERA_SECRET"

curl -X PUT "$KAMATERA_API_URL/server/SERVER_ID" -H "content-type: application/json" -H "clientId: $KAMATERA_CLIENT_ID" -H "secret: $KAMATERA_SECRET" -d '{"cpu":"4B","ram":8192}'

curl -X POST "$KAMATERA_API_URL/server/SERVER_ID/clone" -H "content-type: application/json" -H "clientId: $KAMATERA_CLIENT_ID" -H "secret: $KAMATERA_SECRET" -d '{"name":"cloned-server","cpu":"2B","ram":2048}'

curl -X PUT "$KAMATERA_API_URL/server/SERVER_ID/rebuild" -H "content-type: application/json" -H "clientId: $KAMATERA_CLIENT_ID" -H "secret: $KAMATERA_SECRET" -d '{"image":"ubuntu_server_24.04_64-bit"}'

# Power
curl -X PUT "$KAMATERA_API_URL/server/SERVER_ID/power" -H "content-type: application/json" -H "clientId: $KAMATERA_CLIENT_ID" -H "secret: $KAMATERA_SECRET" -d '{"power":"on"}'

curl -X PUT "$KAMATERA_API_URL/server/SERVER_ID/power" -H "content-type: application/json" -H "clientId: $KAMATERA_CLIENT_ID" -H "secret: $KAMATERA_SECRET" -d '{"power":"off"}'

curl -X PUT "$KAMATERA_API_URL/server/SERVER_ID/power" -H "content-type: application/json" -H "clientId: $KAMATERA_CLIENT_ID" -H "secret: $KAMATERA_SECRET" -d '{"power":"restart"}'

# Firewall
curl -X GET "$KAMATERA_API_URL/server/SERVER_ID/firewall" -H "content-type: application/json" -H "clientId: $KAMATERA_CLIENT_ID" -H "secret: $KAMATERA_SECRET"

curl -X POST "$KAMATERA_API_URL/server/SERVER_ID/firewall" -H "content-type: application/json" -H "clientId: $KAMATERA_CLIENT_ID" -H "secret: $KAMATERA_SECRET" -d '{"rules":[{"direction":"inbound","protocol":"tcp","ports":"80","sourceIp":"0.0.0.0/0","action":"allow"},{"direction":"inbound","protocol":"tcp","ports":"443","sourceIp":"0.0.0.0/0","action":"allow"}]}'

curl -X DELETE "$KAMATERA_API_URL/server/SERVER_ID/firewall/RULE_INDEX" -H "content-type: application/json" -H "clientId: $KAMATERA_CLIENT_ID" -H "secret: $KAMATERA_SECRET"

# Snapshots
curl -X GET "$KAMATERA_API_URL/server/SERVER_ID/snapshots" -H "content-type: application/json" -H "clientId: $KAMATERA_CLIENT_ID" -H "secret: $KAMATERA_SECRET"

curl -X POST "$KAMATERA_API_URL/server/SERVER_ID/snapshot" -H "content-type: application/json" -H "clientId: $KAMATERA_CLIENT_ID" -H "secret: $KAMATERA_SECRET" -d '{"name":"my-snapshot"}'

curl -X PUT "$KAMATERA_API_URL/server/SERVER_ID/snapshot/SNAPSHOT_NAME/restore" -H "content-type: application/json" -H "clientId: $KAMATERA_CLIENT_ID" -H "secret: $KAMATERA_SECRET"

curl -X DELETE "$KAMATERA_API_URL/server/SERVER_ID/snapshot/SNAPSHOT_NAME" -H "content-type: application/json" -H "clientId: $KAMATERA_CLIENT_ID" -H "secret: $KAMATERA_SECRET"

# Network (NICs)
curl -X GET "$KAMATERA_API_URL/server/SERVER_ID/networks" -H "content-type: application/json" -H "clientId: $KAMATERA_CLIENT_ID" -H "secret: $KAMATERA_SECRET"

curl -X POST "$KAMATERA_API_URL/server/SERVER_ID/network" -H "content-type: application/json" -H "clientId: $KAMATERA_CLIENT_ID" -H "secret: $KAMATERA_SECRET" -d '{"network":"MY_NETWORK"}'

curl -X DELETE "$KAMATERA_API_URL/server/SERVER_ID/network/NETWORK_NAME" -H "content-type: application/json" -H "clientId: $KAMATERA_CLIENT_ID" -H "secret: $KAMATERA_SECRET"

# Load Balancers
curl -X GET "$KAMATERA_API_URL/loadbalancers" -H "content-type: application/json" -H "clientId: $KAMATERA_CLIENT_ID" -H "secret: $KAMATERA_SECRET"

curl -X GET "$KAMATERA_API_URL/loadbalancer/LB_ID" -H "content-type: application/json" -H "clientId: $KAMATERA_CLIENT_ID" -H "secret: $KAMATERA_SECRET"

curl -X POST "$KAMATERA_API_URL/loadbalancer" -H "content-type: application/json" -H "clientId: $KAMATERA_CLIENT_ID" -H "secret: $KAMATERA_SECRET" -d '{"name":"my-lb","datacenter":"US-NY2","pool":{"port":80,"protocol":"http","healthCheck":{"interval":30,"urlPath":"/"},"servers":[{"ip":"10.0.0.10","weight":100}]}}'

curl -X DELETE "$KAMATERA_API_URL/loadbalancer/LB_ID" -H "content-type: application/json" -H "clientId: $KAMATERA_CLIENT_ID" -H "secret: $KAMATERA_SECRET"

curl -X PUT "$KAMATERA_API_URL/loadbalancer/LB_ID" -H "content-type: application/json" -H "clientId: $KAMATERA_CLIENT_ID" -H "secret: $KAMATERA_SECRET" -d '{"pool":{"servers":[{"ip":"10.0.0.10","weight":100},{"ip":"10.0.0.11","weight":100}]}}'

# Blocks (Volumes)
curl -X GET "$KAMATERA_API_URL/blocks" -H "content-type: application/json" -H "clientId: $KAMATERA_CLIENT_ID" -H "secret: $KAMATERA_SECRET"

curl -X POST "$KAMATERA_API_URL/block" -H "content-type: application/json" -H "clientId: $KAMATERA_CLIENT_ID" -H "secret: $KAMATERA_SECRET" -d '{"name":"my-block","datacenter":"US-NY2","size":100}'

curl -X DELETE "$KAMATERA_API_URL/block/BLOCK_ID" -H "content-type: application/json" -H "clientId: $KAMATERA_CLIENT_ID" -H "secret: $KAMATERA_SECRET"

curl -X PUT "$KAMATERA_API_URL/block/BLOCK_ID/attach" -H "content-type: application/json" -H "clientId: $KAMATERA_CLIENT_ID" -H "secret: $KAMATERA_SECRET" -d '{"server":"SERVER_ID"}'

curl -X PUT "$KAMATERA_API_URL/block/BLOCK_ID/detach" -H "content-type: application/json" -H "clientId: $KAMATERA_CLIENT_ID" -H "secret: $KAMATERA_SECRET"

# Datacenters
curl -X GET "$KAMATERA_API_URL/datacenters" -H "content-type: application/json" -H "clientId: $KAMATERA_CLIENT_ID" -H "secret: $KAMATERA_SECRET"

# Images
curl -X GET "$KAMATERA_API_URL/images" -H "content-type: application/json" -H "clientId: $KAMATERA_CLIENT_ID" -H "secret: $KAMATERA_SECRET"
