# Mux CLI commands
# Documentation: https://www.mux.com/docs/integrations/mux-cli

# Install (choose one)
brew install muxinc/tap/mux
npm install -g @mux/cli
curl -fsSL https://raw.githubusercontent.com/muxinc/cli/main/install.sh | bash

# Authentication
mux login
mux login --name production
mux login --name staging --env-file .env.staging
mux env list
mux env switch staging
mux logout <environment-name>

# Non-interactive authentication. Create a least-privilege access token in the
# Mux dashboard and keep these values out of shell history and source control.
export MUX_TOKEN_ID="<token-id>"
export MUX_TOKEN_SECRET="<token-secret>"

# Assets: ingest from a URL or upload local files
mux assets create --url https://example.com/video.mp4 --playback-policy public --wait
mux assets create --upload ./video.mp4 --playback-policy public --wait
mux assets create --upload ./videos/*.mp4 --playback-policy public
mux assets create --file ./asset-config.json
mux assets list
mux assets get <asset-id>
mux assets update <asset-id> --title "Example video" --passthrough <application-id>
mux assets manage

# Direct uploads for browser/mobile clients
mux uploads create --cors-origin "https://example.com" --playback-policy public
mux uploads create --cors-origin "http://localhost:3000" --playback-policy public --test
mux uploads list
mux uploads get <upload-id>
mux uploads cancel <upload-id>

# Live streams (requires a plan that supports live video)
mux live create --playback-policy public --latency-mode low --reconnect-window 60
mux live list
mux live get <live-stream-id>
mux live disable <live-stream-id>
mux live enable <live-stream-id>
mux live complete <live-stream-id>
mux live reset-stream-key <live-stream-id>
# Publish from an encoder to rtmp://global-live.mux.com/app using the returned
# stream key. Treat stream keys as secrets.

# Playback URLs
export MUX_PLAYBACK_ID="<playback-id>"
curl --head "https://stream.mux.com/$MUX_PLAYBACK_ID.m3u8"
curl --head "https://image.mux.com/$MUX_PLAYBACK_ID/thumbnail.jpg?time=5"
curl --head "https://image.mux.com/$MUX_PLAYBACK_ID/animated.gif?start=2&end=5"
mux playback-ids "$MUX_PLAYBACK_ID" --expand

# Signed playback
mux signing-keys create
mux signing-keys list
mux sign "$MUX_PLAYBACK_ID" --expiration 24h
mux sign "$MUX_PLAYBACK_ID" --type thumbnail --param time=14 --param width=640

# Playback restrictions
mux playback-restrictions create --allowed-domains "example.com" --allowed-domains "*.example.com"
mux playback-restrictions list
mux playback-restrictions update-referrer <restriction-id> --allowed-domains "example.com" --allow-no-referrer

# Webhook development
mux webhooks listen --forward-to http://localhost:3000/api/webhooks/mux
mux webhooks events list --limit 50
mux webhooks events replay <event-id> --forward-to http://localhost:3000/api/webhooks/mux
mux webhooks trigger video.asset.ready --forward-to http://localhost:3000/api/webhooks/mux

# Mux Data
mux video-views list --timeframe "24:hours"
mux video-views get <view-id>
mux metrics list
mux metrics breakdown <metric-id> --group-by country --measurement median
mux metrics overall <metric-id> --measurement avg
mux metrics timeseries <metric-id> --group-by hour
mux monitoring dimensions
mux monitoring metrics

# JSON output and help
mux assets list --json
mux --help
mux assets create --help

# Destructive cleanup: inspect the resource first.
mux assets get <asset-id>
mux assets delete <asset-id>
mux live get <live-stream-id>
mux live delete <live-stream-id>
