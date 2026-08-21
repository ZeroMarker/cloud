#!/usr/bin/env bash
set -euo pipefail

script_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

if [[ -f "$script_dir/.env" ]]; then
  while IFS= read -r env_line || [[ -n "$env_line" ]]; do
    env_line="${env_line%$'\r'}"
    [[ -z "$env_line" || "$env_line" == \#* ]] && continue
    [[ "$env_line" == *=* ]] || { printf 'Invalid .env line: %s\n' "$env_line" >&2; exit 2; }
    env_key="${env_line%%=*}"
    env_value="${env_line#*=}"
    case "$env_key" in
      DB_USER|APP_DB_USER|DB_DSN|DB_WALLET_DIR|DB_PASSWORD|DB_WALLET_PASSWORD|APP_DB_PASSWORD)
        printf -v "$env_key" '%s' "$env_value"
        export "$env_key"
        ;;
      *) printf 'Unknown .env field: %s\n' "$env_key" >&2; exit 2 ;;
    esac
  done < "$script_dir/.env"
fi

database_user="${1:-${DB_USER:-APP_USER}}"

export DB_USER="${database_user^^}"
export DB_DSN="${DB_DSN:-your_adb_tp}"
export DB_WALLET_DIR="${DB_WALLET_DIR:-$HOME/oracle/wallet}"

cleanup() {
  unset DB_USER DB_PASSWORD DB_WALLET_PASSWORD DB_DSN DB_WALLET_DIR
}
trap cleanup EXIT

if [[ ! -f "$DB_WALLET_DIR/tnsnames.ora" || ! -f "$DB_WALLET_DIR/ewallet.pem" ]]; then
  printf 'Wallet files not found in %s\n' "$DB_WALLET_DIR" >&2
  exit 2
fi

if [[ -z "${DB_PASSWORD:-}" ]]; then
  read -r -s -p "Database password for $DB_USER: " DB_PASSWORD
  printf '\n'
fi
export DB_PASSWORD

if [[ -z "${DB_WALLET_PASSWORD:-}" ]]; then
  read -r -s -p 'Wallet password: ' DB_WALLET_PASSWORD
  printf '\n'
fi
export DB_WALLET_PASSWORD

cd "$script_dir"
npm test
