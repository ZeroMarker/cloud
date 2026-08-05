# Bitiful S4 object storage commands
# Documentation: https://docs.bitiful.com/
#
# S4 is S3-compatible. These examples use AWS CLI v2 with a dedicated profile
# so Bitiful credentials do not replace credentials for other providers.

# Install AWS CLI v2 first:
# https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html

# Credentials and endpoint
# Create a sub-account/access key in the Bitiful console and grant only the
# bucket permissions it needs. Never commit real keys to this repository.
aws configure --profile bitiful
aws configure set region cn-east-1 --profile bitiful
aws configure set s3.addressing_style virtual --profile bitiful

export BITIFUL_ENDPOINT="https://s3.bitiful.net"
export BITIFUL_PROFILE="bitiful"
export BITIFUL_BUCKET="<bucket-name>"

# Verify access
aws s3api list-buckets --endpoint-url "$BITIFUL_ENDPOINT" --profile "$BITIFUL_PROFILE"
aws s3 ls "s3://$BITIFUL_BUCKET" --endpoint-url "$BITIFUL_ENDPOINT" --profile "$BITIFUL_PROFILE"

# Object operations
aws s3 cp ./file.txt "s3://$BITIFUL_BUCKET/path/file.txt" --endpoint-url "$BITIFUL_ENDPOINT" --profile "$BITIFUL_PROFILE"
aws s3 cp "s3://$BITIFUL_BUCKET/path/file.txt" ./file.txt --endpoint-url "$BITIFUL_ENDPOINT" --profile "$BITIFUL_PROFILE"
aws s3 mv "s3://$BITIFUL_BUCKET/old-name.txt" "s3://$BITIFUL_BUCKET/new-name.txt" --endpoint-url "$BITIFUL_ENDPOINT" --profile "$BITIFUL_PROFILE"
aws s3 rm "s3://$BITIFUL_BUCKET/path/file.txt" --endpoint-url "$BITIFUL_ENDPOINT" --profile "$BITIFUL_PROFILE"

# Directory copy and synchronization
aws s3 cp ./assets/ "s3://$BITIFUL_BUCKET/assets/" --recursive --endpoint-url "$BITIFUL_ENDPOINT" --profile "$BITIFUL_PROFILE"
aws s3 sync ./public/ "s3://$BITIFUL_BUCKET/public/" --endpoint-url "$BITIFUL_ENDPOINT" --profile "$BITIFUL_PROFILE"
aws s3 sync "s3://$BITIFUL_BUCKET/backups/" ./backups/ --endpoint-url "$BITIFUL_ENDPOINT" --profile "$BITIFUL_PROFILE"
# Destructive: --delete removes destination objects absent from the source.
aws s3 sync ./public/ "s3://$BITIFUL_BUCKET/public/" --delete --dryrun --endpoint-url "$BITIFUL_ENDPOINT" --profile "$BITIFUL_PROFILE"

# Metadata and content type
aws s3api head-object --bucket "$BITIFUL_BUCKET" --key path/file.txt --endpoint-url "$BITIFUL_ENDPOINT" --profile "$BITIFUL_PROFILE"
aws s3api put-object --bucket "$BITIFUL_BUCKET" --key index.html --body ./index.html --content-type text/html --cache-control "public,max-age=300" --endpoint-url "$BITIFUL_ENDPOINT" --profile "$BITIFUL_PROFILE"
aws s3api copy-object --bucket "$BITIFUL_BUCKET" --copy-source "$BITIFUL_BUCKET/index.html" --key index.html --metadata-directive REPLACE --content-type text/html --cache-control "public,max-age=300" --endpoint-url "$BITIFUL_ENDPOINT" --profile "$BITIFUL_PROFILE"

# Listings and filters
aws s3api list-objects-v2 --bucket "$BITIFUL_BUCKET" --prefix assets/ --max-items 100 --endpoint-url "$BITIFUL_ENDPOINT" --profile "$BITIFUL_PROFILE"
aws s3api list-objects-v2 --bucket "$BITIFUL_BUCKET" --query 'Contents[?Size > `10485760`].[Key,Size]' --output table --endpoint-url "$BITIFUL_ENDPOINT" --profile "$BITIFUL_PROFILE"

# Multipart uploads
aws s3api list-multipart-uploads --bucket "$BITIFUL_BUCKET" --endpoint-url "$BITIFUL_ENDPOINT" --profile "$BITIFUL_PROFILE"
aws s3api abort-multipart-upload --bucket "$BITIFUL_BUCKET" --key <object-key> --upload-id <upload-id> --endpoint-url "$BITIFUL_ENDPOINT" --profile "$BITIFUL_PROFILE"

# Temporary download URL
aws s3 presign "s3://$BITIFUL_BUCKET/private/file.zip" --expires-in 3600 --endpoint-url "$BITIFUL_ENDPOINT" --profile "$BITIFUL_PROFILE"

# S4 usage and access logs API
# Create a console API token at https://console.bitiful.com/apiToken.
export BITIFUL_API_TOKEN="<api-token>"
curl --fail --silent --show-error \
  -H "Authorization: $BITIFUL_API_TOKEN" \
  "https://api.bitiful.com/s4/data/$BITIFUL_BUCKET/usage"

# Logs are retained for three days. start_time is a nanosecond timestamp;
# codes accepts 2XX, 3XX, 4XX, 5XX, or ALL; limit is at most 1000.
curl --fail --silent --show-error --get \
  -H "Authorization: $BITIFUL_API_TOKEN" \
  --data-urlencode "start_time=<nanosecond-timestamp>" \
  --data-urlencode "codes=ALL" \
  --data-urlencode "limit=100" \
  "https://api.bitiful.com/s4/data/$BITIFUL_BUCKET/logs"

# Public object and CoreIX media processing examples
curl --head "https://$BITIFUL_BUCKET.s3.bitiful.net/path/file.txt"
curl --head "https://$BITIFUL_BUCKET.s3.bitiful.net/image.jpg?fmt=webp&w=1200"

# Cleanup preview, then remove. Review the generated list before omitting
# --dryrun because object deletion may be irreversible.
aws s3 rm "s3://$BITIFUL_BUCKET/tmp/" --recursive --dryrun --endpoint-url "$BITIFUL_ENDPOINT" --profile "$BITIFUL_PROFILE"
