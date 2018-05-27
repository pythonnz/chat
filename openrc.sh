#!/usr/bin/env bash

export OS_AUTH_URL=https://api.cloud.catalyst.net.nz:5000/v2.0
export OS_TENANT_ID=b25589432c544c0e8ae266b9871532e8
export OS_TENANT_NAME="new-zealand-python-user-group-incorporated"

echo "Please enter your OpenStack Username for project $OS_TENANT_NAME: "
read -r OS_USERNAME_INPUT
export OS_USERNAME=${OS_USERNAME_INPUT}

echo "Please enter your OpenStack Password for project $OS_TENANT_NAME: "
read -sr OS_PASSWORD_INPUT
export OS_PASSWORD=${OS_PASSWORD_INPUT}

export OS_REGION_NAME="nz-hlz-1"

if [ -z "$OS_REGION_NAME" ]; then unset OS_REGION_NAME; fi

export OS_ENDPOINT_TYPE=publicURL
export OS_IDENTITY_API_VERSION=2
