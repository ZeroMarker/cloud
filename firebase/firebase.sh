# Firebase CLI commands
#
# Official docs: https://firebase.google.com/docs/cli
# Last checked: 2026-07-06

# Install
npm install -g firebase-tools
# or standalone installer
curl -sL https://firebase.tools | bash

# Version and help
firebase --version
firebase --help
firebase <command> --help

# Authentication
firebase login
firebase login --no-localhost
firebase login:add
firebase login:list
firebase login:use <account-email>
firebase logout

# CI authentication
# Prefer Google Application Default Credentials for CI when available.
gcloud auth application-default login
gcloud auth application-default print-access-token

# Legacy CI token flow, still supported but not recommended for new CI setup.
firebase login:ci
FIREBASE_TOKEN=<token> firebase deploy
firebase logout --token <token>

# GitHub Actions integration
# Recommended: use Google Workload Identity Federation or a service account key
# with google-github-actions/auth, then run Firebase CLI commands.
#
# Required GitHub repository secrets for service account key flow:
# - GCP_SA_KEY: JSON key for a Google Cloud service account
# - FIREBASE_PROJECT_ID: Firebase project ID
#
# Minimal workflow:
# name: Firebase Deploy
# on:
#   push:
#     branches: [main]
# jobs:
#   deploy:
#     runs-on: ubuntu-latest
#     steps:
#       - uses: actions/checkout@v4
#       - uses: actions/setup-node@v4
#         with:
#           node-version: 22
#       - uses: google-github-actions/auth@v2
#         with:
#           credentials_json: ${{ secrets.GCP_SA_KEY }}
#       - run: npm ci
#       - run: npm install -g firebase-tools
#       - run: firebase deploy --project "${{ secrets.FIREBASE_PROJECT_ID }}"
#
# Deploy only Hosting from GitHub Actions:
# firebase deploy --only hosting --project "${{ secrets.FIREBASE_PROJECT_ID }}"
#
# Deploy only Functions from GitHub Actions:
# firebase deploy --only functions --project "${{ secrets.FIREBASE_PROJECT_ID }}"
#
# Deploy to a Hosting preview channel for pull requests:
# name: Firebase Hosting Preview
# on: pull_request
# jobs:
#   preview:
#     runs-on: ubuntu-latest
#     steps:
#       - uses: actions/checkout@v4
#       - uses: actions/setup-node@v4
#         with:
#           node-version: 22
#       - uses: google-github-actions/auth@v2
#         with:
#           credentials_json: ${{ secrets.GCP_SA_KEY }}
#       - run: npm ci
#       - run: npm install -g firebase-tools
#       - run: firebase hosting:channel:deploy "pr-${{ github.event.pull_request.number }}" --expires 7d --project "${{ secrets.FIREBASE_PROJECT_ID }}"
#
# Alternative: official Firebase Hosting GitHub Action.
# This action is convenient for Hosting-only deployments and PR preview channels.
# See: https://github.com/FirebaseExtended/action-hosting-deploy
#
# Required GitHub repository secrets:
# - FIREBASE_SERVICE_ACCOUNT_<PROJECT_ID>: service account JSON
#
# Preview channel example:
# - uses: FirebaseExtended/action-hosting-deploy@v0
#   with:
#     repoToken: ${{ secrets.GITHUB_TOKEN }}
#     firebaseServiceAccount: ${{ secrets.FIREBASE_SERVICE_ACCOUNT_<PROJECT_ID> }}
#     projectId: <project-id>
#
# Production Hosting deploy example:
# - uses: FirebaseExtended/action-hosting-deploy@v0
#   with:
#     repoToken: ${{ secrets.GITHUB_TOKEN }}
#     firebaseServiceAccount: ${{ secrets.FIREBASE_SERVICE_ACCOUNT_<PROJECT_ID> }}
#     channelId: live
#     projectId: <project-id>

# Project setup
firebase projects:list
firebase projects:create <project-id>
firebase projects:addfirebase <google-cloud-project-id>
firebase use
firebase use <project-id>
firebase use --add
firebase use --alias <alias>
firebase use --clear
firebase open

# Initialize local config
firebase init
firebase init hosting
firebase init functions
firebase init firestore
firebase init database
firebase init storage
firebase init emulators
firebase init hosting,functions,firestore

# Deploy
firebase deploy
firebase deploy -P <project-id>
firebase deploy --only hosting
firebase deploy --only functions
firebase deploy --only firestore
firebase deploy --only database
firebase deploy --only storage
firebase deploy --except functions
firebase deploy --message "Deploy message"

# Hosting
firebase init hosting
firebase deploy --only hosting
firebase hosting:sites:list
firebase hosting:sites:create <site-id>
firebase hosting:sites:delete <site-id>
firebase hosting:channel:list
firebase hosting:channel:deploy <channel-id>
firebase hosting:channel:deploy <channel-id> --expires 7d
firebase hosting:channel:open <channel-id>
firebase hosting:clone <source-site>:<source-channel> <target-site>:<target-channel>
firebase hosting:releases:list
firebase hosting:releases:rollback

# Functions
firebase init functions
firebase deploy --only functions
firebase deploy --only functions:<function-name>
firebase functions:list
firebase functions:log
firebase functions:log --only <function-name>
firebase functions:delete <function-name>
firebase functions:config:get
firebase functions:config:set key=value
firebase functions:config:unset key

# Firestore
firebase init firestore
firebase deploy --only firestore
firebase firestore:databases:list
firebase firestore:databases:create <database-id>
firebase firestore:databases:get <database-id>
firebase firestore:indexes
firebase firestore:delete <path>
firebase firestore:delete <path> --recursive
firebase firestore:delete <path> --all-collections

# Realtime Database
firebase init database
firebase deploy --only database
firebase database:get /path
firebase database:set /path data.json
firebase database:update /path data.json
firebase database:push /path data.json
firebase database:remove /path
firebase database:profile
firebase database:instances:list
firebase database:instances:create <instance-name>

# Storage
firebase init storage
firebase deploy --only storage

# Authentication users
firebase auth:export users.json --format=json
firebase auth:export users.csv --format=csv
firebase auth:import users.json --hash-algo=scrypt --rounds=<rounds> --mem-cost=<mem-cost>

# Apps
firebase apps:list
firebase apps:create WEB <app-name>
firebase apps:create ANDROID <app-name> --package-name <package-name>
firebase apps:create IOS <app-name> --bundle-id <bundle-id>
firebase apps:sdkconfig WEB <app-id>
firebase apps:sdkconfig ANDROID <app-id>
firebase apps:sdkconfig IOS <app-id>

# Emulators
firebase init emulators
firebase emulators:start
firebase emulators:start --only hosting,functions,firestore
firebase emulators:exec "npm test"
firebase emulators:export ./emulator-data
firebase emulators:start --import ./emulator-data
firebase emulators:start --import ./emulator-data --export-on-exit

# App Hosting
firebase init apphosting
firebase apphosting:backends:list
firebase apphosting:backends:create
firebase apphosting:backends:get <backend-id>
firebase apphosting:backends:delete <backend-id>
firebase apphosting:rollouts:list <backend-id>
firebase apphosting:rollouts:create <backend-id>

# Extensions
firebase ext
firebase ext:list
firebase ext:install <publisher-id>/<extension-id>
firebase ext:configure <extension-instance-id>
firebase ext:update <extension-instance-id>
firebase ext:uninstall <extension-instance-id>
firebase ext:info <publisher-id>/<extension-id>

# Data Connect
firebase init dataconnect
firebase dataconnect:services:list
firebase dataconnect:sql:diff
firebase dataconnect:sql:migrate
firebase deploy --only dataconnect

# Project aliases and environment examples
firebase use dev
firebase deploy -P staging
firebase deploy -P production --only hosting

# Uninstall
npm uninstall -g firebase-tools
# or standalone installer uninstall
curl -sL https://firebase.tools | uninstall=true bash
