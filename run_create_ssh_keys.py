#! /usr/bin/env python3
import json
import pathlib
import subprocess as sp

def get_output(cmd, in_json=False):
    result = sp.run(cmd, shell=True, text=True, capture_output=True)
    if in_json:
        return json.loads(result.stdout)
    return result.stdout

# Sign into 1Password
cmd = "op signin"
sp.run(cmd, shell=True)

# Retrieve all the vaults containing the word "SSH"
cmd = "op vault list --format=json"
vaults = get_output(cmd, in_json=True)
ssh_vaults = [vault for vault in vaults if "SSH" in vault["name"] or "ssh" in vault["name"]]

total_keys = sum([vault["items"] for vault in ssh_vaults])

ssh_keys = []

# For each vault retrieve all the keys
key_index = 1
for vault in ssh_vaults:
    cmd = f'op item list --vault "{vault["name"]}" --format=json'
    vault_items = get_output(cmd, in_json=True)
    for i, item in enumerate(vault_items):
        print(f"Loading key {key_index}/{total_keys}")
        cmd = f'op read "op://{vault["name"]}/{item["title"]}/private key"'
        key = get_output(cmd)
        with open(pathlib.Path.home() / ".ssh" / f"{item['title'].replace(' ', '_')}.pem", "w") as ofile:
            ofile.write(key)
        ssh_keys.append(key)
        key_index += 1

