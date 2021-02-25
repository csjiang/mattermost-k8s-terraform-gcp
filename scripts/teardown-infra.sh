#!/usr/bin/env bash

CWD=$PWD

cd terraform/gcp.us-east-1

terraform plan -destroy 

terraform destroy -auto-approve 