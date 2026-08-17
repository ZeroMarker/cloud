# Bitiful S4 (缤纷云) object storage commands
# Official docs: https://docs.bitiful.com/  (mirror: https://bitiful-docs.mintlify.app/)
#
# S4 (Smart Simple Storage Service) is an S3-compatible object storage
# (endpoint https://s3.bitiful.net, region cn-east-1). Official tooling:
#   - Bitifs  : official mount tool (BETA), maps a bucket to a local directory
#   - Rclone  : official setup guide for sync / copy / mount
#   - REST API: usage, logs, traffic, CDN cache refresh (control-plane stats)
#   - S3 SDKs : Go / Java / PHP / Python3 (boto3) / Android / Node.js

# ---------------------------------------------------------------------------
# 0. Account preparation (console)
# ---------------------------------------------------------------------------
# 1. Register and complete real-name verification:
#    https://console.bitiful.com/  ->  https://console.bitiful.com/users
# 2. Create a bucket: https://console.bitiful.com/buckets
#    - Bucket names: 4-63 chars, only lowercase a-z, 0-9, '-';
#      must start and end with a letter or digit; globally unique.
# 3. Create a SUB-ACCOUNT, grant ONLY the buckets/permissions it needs,
#    then create an AccessKey for it. Never use the main account key here.
# 4. (For REST calls) get an API token: https://console.bitiful.com/apiToken

export S4_ENDPOINT="https://s3.bitiful.net"
export S4_REGION="cn-east-1"
export S4_BUCKET="<bucket-name>"
export AWS_ACCESS_KEY_ID="<sub-account-access-key-id>"
export AWS_SECRET_ACCESS_KEY="<sub-account-access-key-secret>"
export BITIFUL_API_TOKEN="<api-token-from-console>"

# ---------------------------------------------------------------------------
# 1. Bitifs — official mount tool (BETA)
#    Docs: https://docs.bitiful.com/best-practice/solutions/bitifs
# ---------------------------------------------------------------------------
# Downloads (pick your platform):
#   Linux  AMD64: https://tools.bitiful.com/bitifs/bitifs_linux_amd64
#   Linux  ARM64: https://tools.bitiful.com/bitifs/bitifs_linux_arm64
#   macOS  Intel: https://tools.bitiful.com/bitifs/bitifs_macos_amd64
#   macOS  Apple: https://tools.bitiful.com/bitifs/bitifs_macos_arm64
#   Windows:      https://tools.bitiful.com/bitifs/bitifs.exe
# Linux/macOS need FUSE (macFUSE); Windows needs WinFsp.

curl -fL https://tools.bitiful.com/bitifs/bitifs_linux_amd64 -o bitifs
chmod +x bitifs

# Mount a bucket as a local directory.
# Uses AWS_ACCESS_KEY_ID / AWS_SECRET_ACCESS_KEY from the environment above.
mkdir -p ~/bitiful-mount
./bitifs bitifsmount ~/bitiful-mount

# Windows (CMD): set AWS_ACCESS_KEY_ID / AWS_SECRET_ACCESS_KEY, then:
#   bitifs.exe <bucket-name> B:
# Bitifs is a mount tool. For one-off upload / download / sync, use Rclone below.

# ---------------------------------------------------------------------------
# 2. Rclone — official recommended sync / copy / mount solution
#    Docs: https://docs.bitiful.com/best-practice/solutions/rclone
# ---------------------------------------------------------------------------
# Install: https://rclone.org/install/  (e.g. `sudo apt install rclone`)

# Add this remote to ~/.config/rclone/rclone.conf (or run `rclone config`):
#   [s4-demo]
#   type = s3
#   provider = Other
#   env_auth = false
#   access_key_id = <access-key>
#   secret_access_key = <secret-key>
#   endpoint = https://s3.bitiful.net

rclone config

# Bucket and object listing
rclone lsd s4-demo:                 # list all buckets
rclone mkdir s4-demo:mybucket       # create a bucket
rclone ls  s4-demo:mybucket         # list objects (with sizes)
rclone lsl s4-demo:mybucket         # list objects with modtime + size
rclone tree s4-demo:mybucket        # directory tree

# Copy / sync
rclone copy  ./file.png s4-demo:mybucket/path/                 # upload
rclone copy  s4-demo:mybucket/path/file.png ./                 # download
rclone sync  ./public/ s4-demo:mybucket                        # one-way mirror upload
rclone sync  s4-demo:mybucket ./backups/                       # one-way mirror download
# Destructive: sync --delete removes target objects absent from the source.
rclone sync ./public/ s4-demo:mybucket --delete --dry-run

# Move / rename (S4 natively supports Move/Rename; no copy+delete round trip)
rclone move ./old.txt s4-demo:mybucket/new.txt

# Mount as a local directory (optional; Bitifs is the simpler official option)
rclone mount s4-demo:/ ~/s4mnt --vfs-cache-mode full --daemon

# ---------------------------------------------------------------------------
# 3. S3-compatible SDKs and clients
#    Docs: https://docs.bitiful.com/developer/sdk/intro
# ---------------------------------------------------------------------------
# S4 speaks the S3 protocol, so any S3 client or SDK works with
# endpoint https://s3.bitiful.net, region cn-east-1, and a per-bucket AK/SK.
# Official SDK demos: Go (aws-sdk-go-v2), Java, PHP, Python3 (boto3),
# Android, Node.js (OpenAPI spec: developer/sdk/openapi.json).
# Best practice: browsers/clients must NOT embed AK/SK; issue presigned URLs
# instead: https://docs.bitiful.com/best-practice/web-uploads

# Minimal boto3 connectivity check
python3 - <<'PY'
import os, boto3
s3 = boto3.client(
    "s3",
    aws_access_key_id=os.environ["AWS_ACCESS_KEY_ID"],
    aws_secret_access_key=os.environ["AWS_SECRET_ACCESS_KEY"],
    endpoint_url=os.environ["S4_ENDPOINT"],
    region_name=os.environ["S4_REGION"],
)
print([b["Name"] for b in s3.list_buckets()["Buckets"]])
PY

# ---------------------------------------------------------------------------
# 4. Official REST API (control-plane stats, uses the console API token)
#    Docs: https://docs.bitiful.com/developer/api/s4
#          https://docs.bitiful.com/developer/api/cdn
# ---------------------------------------------------------------------------

# S4: capacity and object count of a bucket
curl -H "Authorization: $BITIFUL_API_TOKEN" \
  "https://api.bitiful.com/s4/data/$S4_BUCKET/usage"

# S4: real-time logs (only last 3 days)
#   start_time: timestamp in NANOSECONDS, used as pagination cursor
#   codes:      2XX / 3XX / 4XX / 5XX / ALL (default ALL)
#   limit:      max 1000 per response
curl --get -H "Authorization: $BITIFUL_API_TOKEN" \
  "https://api.bitiful.com/s4/data/$S4_BUCKET/logs" \
  --data-urlencode start_time="<timestamp-ns>" \
  --data-urlencode codes=ALL \
  --data-urlencode limit=1000

# CDN: edge / origin traffic and requests
#   start_time / end_time: timestamp in SECONDS;  period: hourly|daily|monthly
curl --get -H "Authorization: $BITIFUL_API_TOKEN" \
  "https://api.bitiful.com/cdn/data/<cdn-domain>/traffic" \
  --data-urlencode start_time="<ts-seconds>" \
  --data-urlencode end_time="<ts-seconds>" \
  --data-urlencode period=daily
#  .../traffic_origin   edge traffic origin
#  .../request          edge request count
#  .../request_origin   origin request count

# CDN: purge cache (type: url | directory; max 20 entries per call;
# URL-encode any '%' or other special chars in the URLs)
curl -X POST -H "Authorization: $BITIFUL_API_TOKEN" \
  -H "Content-Type: application/json" \
  "https://api.bitiful.com/cdn/cache/refresh" \
  -d '{"type":"url","url_list":["https://example.com/img/a.png","https://example.com/img/b.png"]}'

# ---------------------------------------------------------------------------
# 5. Limits & free tier (official docs)
#    Docs: https://docs.bitiful.com/bitiful-s4/limits
#          https://docs.bitiful.com/prices/basic
# ---------------------------------------------------------------------------
# - Quotas: 10 buckets / main account; 10 CDNs; 50 certs. Unlimited objects per bucket.
# - Uploads: simple upload up to 20 GiB; multipart up to 195.2 TiB
#   (note: Simul-Transfer does not support multipart uploads).
# - Native Move/Rename is supported; Simul-Transfer makes an object downloadable
#   as soon as the upload starts.
# - Not yet available: lifecycle rules, server-side encryption, WORM, versioning.
# - Free tier (verified account): 50 GiB storage, 3x10 GB egress / month,
#   3x100k requests / month, 5 Let's Encrypt single-domain auto certs.
# - Pricing is hourly pay-as-you-go; compare with the cost calculator:
#   https://tools.bitiful.com/prices/index.html

# ---------------------------------------------------------------------------
# Safety notes
# ---------------------------------------------------------------------------
# - Use scoped sub-account keys, not the main account key; never commit them.
# - Review `rclone sync --delete`, `rclone delete`, `rclone purge` before running.
# - Client-side uploads: presign URLs; never ship AK/SK to browsers/apps.