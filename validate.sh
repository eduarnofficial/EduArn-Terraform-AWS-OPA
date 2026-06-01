#!/bin/bash

set -e

echo "Terraform Init..."
terraform init

echo "Terraform Plan..."
terraform plan -out=tfplan

echo "Terraform Plan JSON..."
terraform show -json tfplan > tfplan.json

echo "OPA Validation..."
opa eval \
  --fail-defined \
  --input tfplan.json \
  --data policy/s3_bucket.rego \
  "data.terraform.s3.deny"

echo "Validation Passed"
