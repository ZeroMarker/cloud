# Kamatera: flexible scaling

export KAMATERA_CLIENT_ID="client-id"
export KAMATERA_SECRET="secret"
export KAMATERA_API_URL="https://console.kamatera.com/service"

curl -X POST "$KAMATERA_API_URL/authenticate" -d "clientId=$KAMATERA_CLIENT_ID" -d "secret=$KAMATERA_SECRET"

curl -X GET "$KAMATERA_API_URL/servers" -H "content-type: application/json" -H "clientId: $KAMATERA_CLIENT_ID" -H "secret: $KAMATERA_SECRET"

curl -X GET "$KAMATERA_API_URL/server/SERVER_ID" -H "content-type: application/json" -H "clientId: $KAMATERA_CLIENT_ID" -H "secret: $KAMATERA_SECRET"

curl -X POST "$KAMATERA_API_URL/server" -H "content-type: application/json" -H "clientId: $KAMATERA_CLIENT_ID" -H "secret: $KAMATERA_SECRET" -d '{"name":"my-server","datacenter":"US-NY2","cpu":"2B","ram":2048,"disk":"20","image":"ubuntu_server_24.04_64-bit"}'

curl -X PUT "$KAMATERA_API_URL/server/SERVER_ID/power" -H "content-type: application/json" -H "clientId: $KAMATERA_CLIENT_ID" -H "secret: $KAMATERA_SECRET" -d '{"power":"on"}'

curl -X PUT "$KAMATERA_API_URL/server/SERVER_ID/power" -H "content-type: application/json" -H "clientId: $KAMATERA_CLIENT_ID" -H "secret: $KAMATERA_SECRET" -d '{"power":"off"}'

curl -X PUT "$KAMATERA_API_URL/server/SERVER_ID" -H "content-type: application/json" -H "clientId: $KAMATERA_CLIENT_ID" -H "secret: $KAMATERA_SECRET" -d '{"cpu":"4B","ram":8192}'

curl -X GET "$KAMATERA_API_URL/datacenters" -H "content-type: application/json" -H "clientId: $KAMATERA_CLIENT_ID" -H "secret: $KAMATERA_SECRET"

curl -X GET "$KAMATERA_API_URL/images" -H "content-type: application/json" -H "clientId: $KAMATERA_CLIENT_ID" -H "secret: $KAMATERA_SECRET"
