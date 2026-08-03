#! /usr/bin/env python3
import os
import pathlib
import subprocess as sp
import re
import json

session_token = sp.run("op signin --raw", shell=True, capture_output=True, text=True).stdout
result = sp.run(f"op item list --format=json --tags ssh --session {session_token} | op item get - --fields 'private key,public key' --reveal --format=json --session {session_token}", shell=True, text=True, capture_output=True)

keysets = re.findall(r"\[([^\]]+)\]", result.stdout)

for keyset in keysets:
    keyset = json.loads(f"[{keyset}]")

    for key in keyset:

        key_name = key['reference'].split("/")[-2]

        if 'private' in key['reference']:
            filename = f"{pathlib.Path.home()}/.ssh/{key_name}_pvt"
            with open(filename, 'w') as private_key_file:
                private_key_file.write(key['value'])
            os.chmod(filename, 0o600)
        elif 'public' in key['reference']:
            with open(f"{pathlib.Path.home()}/.ssh/{key_name}.pub", 'w') as public_key_file:
                public_key_file.write(key['value'])

