#!/usr/bin/env bash
set -euo pipefail

eval "$(op signin)"

# Retrieve all vaults containing "SSH" (case-insensitive)
vaults_json="$(op vault list --format=json)"

mapfile -t vault_names < <(echo "$vaults_json" | jq -r '.[] | select(.name | test("ssh"; "i")) | .name')

# Total key count across matching vaults
total_keys=0
for vault in "${vault_names[@]}"; do
  count="$(echo "$vaults_json" | jq -r --arg v "$vault" '.[] | select(.name == $v) | .items')"
  total_keys=$((total_keys + count))
done

key_index=1
mkdir -p "$HOME/.ssh"

for vault in "${vault_names[@]}"; do
  items_json="$(op item list --vault "$vault" --format=json)"
  item_count="$(echo "$items_json" | jq '. | length')"

  for ((i = 0; i < item_count; i++)); do
    title="$(echo "$items_json" | jq -r ".[$i].title")"

    echo "Loading key ${key_index}/${total_keys}"

    key="$(op read "op://${vault}/${title}/private key")"

    filename="${title// /_}.pem"
    filepath="$HOME/.ssh/${filename}"

    printf '%s' "$key" >"$filepath"
    chmod 600 "$filepath"

    key_index=$((key_index + 1))
  done
done
