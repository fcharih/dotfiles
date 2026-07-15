#!/usr/bin/env bash
set -euo pipefail

eval "$(op signin)"

# Retrieve all vaults containing "SSH" (case-insensitive)
vaults_json="$(op vault list --format=json)"

vault_names=()
while IFS= read -r line; do
  vault_names+=("$line")
done < <(echo "$vaults_json" | jq -r '.[] | select(.name | test("ssh"; "i")) | .name')

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
  item_ids=()
  while IFS= read -r line; do
    item_ids+=("$line")
  done < <(echo "$items_json" | jq -r '.[].id')

  for id in "${item_ids[@]}"; do
    title="$(echo "$items_json" | jq -r --arg id "$id" '.[] | select(.id == $id) | .title')"

    echo "Loading key ${key_index}/${total_keys}: ${title}"

    item_data="$(op item get "$id" --vault "$vault" --format=json)"

    private_key="$(echo "$item_data" | jq -r '.fields[] | select(.label == "private key") | .value')"
    public_key="$(echo "$item_data" | jq -r '.fields[] | select(.label == "public key") | .value')"

    filename="${title// /_}"

    printf '%s' "$private_key" >"$HOME/.ssh/${filename}.pem"
    chmod 600 "$HOME/.ssh/${filename}.pem"

    if [[ -n "$public_key" && "$public_key" != "null" ]]; then
      printf '%s' "$public_key" >"$HOME/.ssh/${filename}.pub"
      chmod 644 "$HOME/.ssh/${filename}.pub"
    fi

    key_index=$((key_index + 1))
  done
done
