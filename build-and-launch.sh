#!/usr/bin/env bash

# env | grep -i aws

terraform init -input=false
terraform plan -out=tfplan -input=false
terraform apply -input=false tfplan
