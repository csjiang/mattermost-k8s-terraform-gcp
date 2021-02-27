#!/usr/bin/env bash

CWD=$PWD

cd terraform/gcp.us-east1

terraform plan -destroy 

terraform destroy -auto-approve 