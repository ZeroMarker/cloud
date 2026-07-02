# Cloudflare unified CLI (cf) commands

# Install
npm install -g cf

# Authentication
cf auth login
cf auth logout
cf auth whoami

# Context Management
cf context list
cf context set <account-id>
cf context default-account

# Project Development
cf init my-project
cf dev
cf dev --port 8787
cf build
cf deploy
cf deploy --dry-run

# Accounts
cf accounts list
cf accounts get --account-id=<id>
cf accounts members list
cf accounts members add --email=<email> --role=<role>
cf accounts tokens create --name=<name> --permissions=<perms>

# DNS Management
cf dns records list -z <zone>
cf dns records get -z <zone> --record-id=<id>
cf dns records create -z <zone> --type=A --name=<subdomain> --content=<ip>
cf dns records create -z <zone> --type=CNAME --name=<subdomain> --content=<target>
cf dns records create -z <zone> --type=TXT --name=<subdomain> --content=<value>
cf dns records create -z <zone> --type=AAAA --name=<subdomain> --content=<ipv6>
cf dns records create -z <zone> --type=MX --name=<subdomain> --content=<mail-server> --priority=<10>
cf dns records create -z <zone> --type=SRV --name=_<service>._<proto> --content=<target>
cf dns records update -z <zone> --record-id=<id> --content=<new-ip>
cf dns records delete -z <zone> --record-id=<id>
cf dns dnssec status -z <zone>
cf dns dnssec enable -z <zone>
cf dns dnssec disable -z <zone>
cf dns analytics query -z <zone> --since=<time>
cf dns analytics timeseries -z <zone> --since=<time>

# Zones
cf zones list
cf zones create --name=<domain>
cf zones get -z <zone>
cf zones delete -z <zone>
cf zones settings list -z <zone>
cf zones settings update -z <zone> --setting=<name> --value=<value>
cf zones activation-check -z <zone>

# Registrar
cf registrar domains list
cf registrar domains get --domain=<domain>
cf registrar transfer initiate --domain=<domain>
cf registrar transfer accept --domain=<domain>
cf registrar transfer status --domain=<domain>

# Workers
cf workers deploy <script-name> --script=<file.js>
cf workers list
cf workers get --name=<script-name>
cf workers delete --name=<script-name>
cf workers routes list -z <zone>
cf workers routes create -z <zone> --pattern=<pattern> --script=<script-name>
cf workers routes delete -z <zone> --route-id=<id>
cf workers tail --name=<script-name>
cf workers logs --name=<script-name>
cf workers subdomain set <subdomain>
cf workers put-kv-namespace --title=<name>
cf workers kv-namespace list
cf workers kv-namespace delete --namespace-id=<id>
cf workers kv key put --namespace-id=<ns> --key=<key> --value=<value>
cf workers kv key get --namespace-id=<ns> --key=<key>
cf workers kv key delete --namespace-id=<ns> --key=<key>
cf workers kv key list --namespace-id=<ns>
cf workers kv bulk put --namespace-id=<ns> --file=<data.json>
cf workers kv bulk delete --namespace-id=<ns> --file=<keys.json>
cf workers cron add --name=<script-name> --cron="<schedule>"
cf workers cron delete --name=<script-name>

# R2 (Object Storage)
cf r2 bucket list
cf r2 bucket create <bucket-name>
cf r2 bucket delete <bucket-name>
cf r2 bucket location get <bucket-name>
cf r2 object list --bucket=<bucket-name>
cf r2 object get --bucket=<bucket-name> --key=<key> --file=<output>
cf r2 object put --bucket=<bucket-name> --key=<key> --file=<input>
cf r2 object delete --bucket=<bucket-name> --key=<key>
cf r2 object copy --bucket=<bucket-name> --key=<key> --dest-bucket=<dest> --dest-key=<dest-key>
cf r2 object presign get --bucket=<bucket-name> --key=<key> --expires=<seconds>
cf r2 object presign put --bucket=<bucket-name> --key=<key> --expires=<seconds>
cf r2 bucket cors get <bucket-name>
cf r2 bucket cors put <bucket-name> --file=<cors.json>
cf r2 bucket lifecycle get <bucket-name>
cf r2 bucket lifecycle put <bucket-name> --file=<lifecycle.json>
cf r2 bucket notification get <bucket-name>
cf r2 bucket notification put <bucket-name> --file=<notification.json>

# D1 (SQL Database)
cf d1 list
cf d1 create <database-name>
cf d1 delete <database-id>
cf d1 info <database-id>
cf d1 execute <database-id> --command="<SQL>"
cf d1 execute <database-id> --file=<query.sql>
cf d1 export <database-id> --output=<output.sql>
cf d1 import <database-id> --file=<dump.sql>
cf d1 migrations list <database-id>
cf d1 migrations apply <database-id>
cf d1 migrations create <database-id> <migration-name>
cf d1 time-travel restore <database-id> --version=<version-id>
cf d1 time-travel info <database-id>

# WAF
cf waf rules list -z <zone>
cf waf rules get -z <zone> --rule-id=<id>
cf waf rules update -z <zone> --rule-id=<id> --action=<action>
cf waf custom-rules list -z <zone>
cf waf custom-rules create -z <zone> --name=<name> --expression="<expr>" --action=<action>
cf waf custom-rules update -z <zone> --rule-id=<id> --name=<name> --expression="<expr>" --action=<action>
cf waf custom-rules delete -z <zone> --rule-id=<id>
cf waf managed-rulesets list -z <zone>
cf waf managed-rulesets deploy -z <zone> --ruleset-id=<id>
cf waf managed-rulesets undeploy -z <zone> --ruleset-id=<id>
cf waf override list -z <zone>
cf waf override create -z <zone> --ruleset-id=<id> --groups=<groups>
cf waf override update -z <zone> --override-id=<id> --groups=<groups>
cf waf override delete -z <zone> --override-id=<id>

# Firewall Rules
cf firewall rules list -z <zone>
cf firewall rules create -z <zone> --filter="<filter>" --action=<action> --description=<desc>
cf firewall rules update -z <zone> --rule-id=<id> --filter="<filter>" --action=<action>
cf firewall rules delete -z <zone> --rule-id=<id>
cf firewall rules toggle -z <zone> --rule-id=<id>

# IP Access Lists
cf ip-access-lists get --account-id=<id>
cf ip-access-lists update --account-id=<id> --list-id=<id> --append --ip=<ip> --note=<note>
cf ip-access-lists delete --account-id=<id> --list-id=<id> --ip=<ip>

# SSL/TLS
cf ssl settings get -z <zone>
cf ssl settings update -z <zone> --mode=<mode>
cf ssl certificates list -z <zone>
cf ssl certificates get -z <zone> --cert-id=<id>
cf ssl origin create -z <zone> --hosts=<hosts> --validity=<days>
cf ssl origin delete -z <zone> --cert-id=<id>
cf ssl universal disable -z <zone>
cf ssl universal enable -z <zone>

# Page Rules
cf page-rules list -z <zone>
cf page-rules create -z <zone> --url=<pattern> --actions=<actions>
cf page-rules update -z <zone> --rule-id=<id> --actions=<actions>
cf page-rules delete -z <zone> --rule-id=<id>
cf page-rules priority update -z <zone> --rule-id=<id> --priority=<n>

# Images
cf images list
cf images upload --file=<image-file> --name=<name>
cf images get --image-id=<id>
cf images delete --image-id=<id>
cf images variants list
cf images variants create --variant-id=<id> --options=<json>
cf images variants update --variant-id=<id> --options=<json>
cf images variants delete --variant-id=<id>
cf images stats

# Stream
cf stream list
cf stream upload --file=<video-file> --name=<name>
cf stream get --video-id=<id>
cf stream delete --video-id=<id>
cf stream captions list --video-id=<id>
cf stream captions upload --video-id=<id> --file=<caption.vtt> --language=<lang>
cf stream download --video-id=<id>
cf stream webhooks list
cf stream webhooks create --url=<url> --events=<events>
cf stream webhooks delete --webhook-id=<id>

# Zero Trust
cf zero-trust tunnels list
cf zero-trust tunnels create --name=<name> --config-file=<config.yml>
cf zero-trust tunnels delete --tunnel-id=<id>
cf zero-trust tunnels route ip add --tunnel-id=<id> --ip=<cidr>
cf zero-trust tunnels route ip list
cf zero-trust tunnels route ip delete --tunnel-id=<id> --ip=<cidr>
cf zero-trust tunnels run --tunnel-id=<id>
cf zero-trust tunnels token --tunnel-id=<id>
cf zero-trust access applications list
cf zero-trust access applications create --domain=<domain> --type=<type> --name=<name>
cf zero-trust access applications delete --app-id=<id>
cf zero-trust access policies list
cf zero-trust access policies create --application-id=<app> --name=<name> --include=<rules>
cf zero-trust access policies delete --policy-id=<id>
cf zero-trust identity providers list
cf zero-trust identity providers create --type=<type> --name=<name> --config=<json>
cf zero-trust identity providers delete --provider-id=<id>
cf zero-trust device posture list
cf zero-trust device posture rules create --type=<type> --name=<name> --input=<json>
cf zero-trust device posture rules delete --rule-id=<id>

# Analytics
cf analytics dashboard list -z <zone>
cf analytics report get -z <zone> --metrics=<metrics> --since=<time>
cf analytics logpush list -z <zone>
cf analytics logpush create -z <zone> --destination=<url> --dataset=<dataset> --filter=<filter>
cf analytics logpush update -z <zone> --job-id=<id> --filter=<filter>
cf analytics logpush delete -z <zone> --job-id=<id>

# Rate Limiting
cf rate-limit list -z <zone>
cf rate-limit create -z <zone> --match=<match> --actions=<actions> --period=<seconds> --threshold=<count>
cf rate-limit update -z <zone> --rule-id=<id> --actions=<actions>
cf rate-limit delete -z <zone> --rule-id=<id>

# Cache
cf cache purge -z <zone>
cf cache purge --zone=<zone> --files=<files>
cf cache purge --zone=<zone> --tags=<tags>
cf cache configuration get -z <zone>
cf cache configuration update -z <zone> --setting=<name> --value=<value>
cf cache rules list -z <zone>
cf cache rules create -z <zone> --pattern=<pattern> --cache=<true|false> --ttl=<seconds>
cf cache rules delete -z <zone> --rule-id=<id>

# Rulesets (Expression-based)
cf rulesets list -z <zone>
cf rulesets get -z <zone> --ruleset-id=<id>
cf rulesets create -z <zone> --kind=<kind> --name=<name> --phase=<phase>
cf rulesets update -z <zone> --ruleset-id=<id> --name=<name>
cf rulesets delete -z <zone> --ruleset-id=<id>
cf rulesets rules add -z <zone> --ruleset-id=<id> --expression="<expr>" --action=<action>
cf rulesets rules delete -z <zone> --ruleset-id=<id> --rule-id=<id>

# Magic Transit / Network Layer
cf magic transit account get
cf magic transit tunnels list
cf magic transit tunnels create --ip=<ip> --name=<name>
cf magic transit tunnels delete --tunnel-id=<id>
cf magic transit health-checks list

# Images Variants (already covered above)

# Shell Completions
cf complete bash
cf complete zsh
cf complete fish

# Schema and Debug
cf schema dns records create
cf agent-context
