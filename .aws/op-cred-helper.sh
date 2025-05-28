#!/bin/bash

vault="$1"
secret_id="$2"

cat <<END | op inject
{
  "Version": 1,
  "AccessKeyId": "{{ op://${vault}/${secret_id}/aws_access_key_id }}",
  "SecretAccessKey": "{{ op://${vault}/${secret_id}/aws_secret_access_key }}"
}
END
