#!/usr/bin/env bash

CWD=$PWD

cd terraform/gcp.us-east1

terraform plan

terraform apply -auto-approve

cd $CWD