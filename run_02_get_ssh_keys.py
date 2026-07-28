#! /usr/bin/env python3
import pathlib
import subprocess as sp
import re
import json

result = sp.run("op item list --format=json --tags ssh | op item get - --fields 'private key,public key' --reveal --format=json", shell=True, text=True, capture_output=True)

keysets = re.findall(r"\[([^\]]+)\]", result.stdout)

for keyset in keysets:
    keyset = json.loads(f"[{keyset}]")

    for key in keyset:

        key_name = key['reference'].split("/")[-2]

        if 'private' in key['reference']:
            with open(f"{pathlib.Path.home()}/.ssh/{key_name}.pem", 'w') as private_key_file:
                private_key_file.write(key['value'])
        elif 'public' in key['reference']:
            with open(f"{pathlib.Path.home()}/.ssh/{key_name}.pub", 'w') as public_key_file:
                public_key_file.write(key['value'])

