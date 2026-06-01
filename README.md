# Terraform AWS OPA Policy as Code Framework

![Terraform](https://img.shields.io/badge/Terraform-IaC-blue)
![AWS](https://img.shields.io/badge/AWS-Cloud-orange)
![OPA](https://img.shields.io/badge/Open%20Policy%20Agent-Policy%20as%20Code-green)
![DevSecOps](https://img.shields.io/badge/DevSecOps-Security-red)
![Platform Engineering](https://img.shields.io/badge/Platform-Engineering-purple)

## Enterprise Terraform Governance using Open Policy Agent (OPA)

A production-ready example demonstrating how to implement **Policy as Code** using **Terraform**, **AWS**, and **Open Policy Agent (OPA)** to enforce governance, compliance, security, and naming standards before infrastructure deployment.

This repository validates Terraform plans using OPA Rego policies and blocks deployments that violate enterprise standards.

---

## Keywords

Terraform, AWS, Open Policy Agent, OPA, Rego, Policy as Code, Infrastructure as Code, IaC, DevSecOps, Platform Engineering, Backstage, AWS Governance, Terraform Security, Cloud Security, Compliance Automation, Enterprise DevOps, GitOps, CI/CD Security

---

## Table of Contents

* Overview
* Architecture
* Features
* Project Structure
* Prerequisites
* Installation
* Terraform Configuration
* OPA Policy
* Validation Workflow
* CI/CD Integration
* Backstage Integration
* Enterprise Use Cases
* Learning Outcomes
* Training Programs
* Contributing
* License

---

# Overview

Organizations adopting Infrastructure as Code (IaC) need governance controls to enforce:

* Naming Standards
* Security Policies
* Compliance Requirements
* Resource Tagging
* Cost Governance
* Cloud Security Controls

This project demonstrates:

* Terraform AWS resource provisioning
* Terraform plan generation
* Terraform JSON plan export
* OPA Rego policy validation
* Deployment blocking for policy violations

---

# Architecture

```text
Developer
    |
    v
Terraform Code
    |
    v
terraform plan
    |
    v
tfplan.json
    |
    v
OPA Policy Validation
    |
    +---- PASS ----> terraform apply
    |
    +---- FAIL ----> Deployment Blocked
```

---

# Features

## Terraform Governance

* Terraform Validation
* Terraform Security Checks
* Terraform Compliance Automation
* Infrastructure Governance

## AWS Governance

* AWS S3 Bucket Validation
* Naming Convention Enforcement
* Cloud Compliance Controls
* Security Guardrails

## Open Policy Agent

* Rego Policy Development
* Policy as Code
* Infrastructure Validation
* Security Enforcement

## DevSecOps

* Shift Left Security
* Automated Governance
* CI/CD Integration
* Compliance Automation

---

# Project Structure

```text
terraform-opa/
├── main.tf
├── terraform.tfvars
├── validate.sh
└── policy/
    └── s3_bucket.rego
```

---

# Prerequisites

* Terraform >= 1.5
* Open Policy Agent (OPA)
* AWS CLI
* AWS Account
* Git

Verify installation:

```bash
terraform version
opa version
aws --version
```

---

# Installation

## Clone Repository

```bash
git clone https://github.com/<your-org>/terraform-aws-opa-policy-as-code.git

cd terraform-aws-opa-policy-as-code
```

## Terraform Initialization

```bash
terraform init
```

---

# Terraform Configuration

## main.tf

```hcl
terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

variable "bucket_name" {
  type = string
}

resource "aws_s3_bucket" "bucket" {
  bucket = var.bucket_name

  tags = {
    Environment = "dev"
    ManagedBy   = "Terraform"
  }
}
```

---

# Sample Input

## Valid

```hcl
bucket_name = "company-dev-data-bucket"
```

## Invalid

```hcl
bucket_name = "TEST_BUCKET"
```

---

# OPA Policy

## policy/s3_bucket.rego

```rego
package terraform.s3

deny contains msg if {

  resource := input.resource_changes[_]

  resource.type == "aws_s3_bucket"

  bucket := resource.change.after.bucket

  not regex.match(
    "^company-(dev|test|stage|prod)-[a-z0-9-]{3,40}$",
    bucket
  )

  msg := sprintf(
    "Bucket '%s' violates enterprise naming standards",
    [bucket]
  )
}
```

---

# Validation Workflow

## Generate Terraform Plan

```bash
terraform plan -out=tfplan
```

## Convert Plan to JSON

```bash
terraform show -json tfplan > tfplan.json
```

## Execute OPA Validation

```bash
opa eval \
--fail-defined \
--input tfplan.json \
--data policy/s3_bucket.rego \
"data.terraform.s3.deny"
```

---

# Automated Validation Script

## validate.sh

```bash
#!/bin/bash

set -e

terraform init

terraform plan -out=tfplan

terraform show -json tfplan > tfplan.json

opa eval \
  --fail-defined \
  --input tfplan.json \
  --data policy/s3_bucket.rego \
  "data.terraform.s3.deny"

echo "Validation Passed"
```

Run:

```bash
chmod +x validate.sh

./validate.sh
```

---

# CI/CD Integration

Supported Platforms:

* GitHub Actions
* Jenkins
* GitLab CI/CD
* Azure DevOps
* Harness
* Bitbucket Pipelines
* ArgoCD

Example:

```yaml
- name: Terraform Plan
  run: terraform plan -out=tfplan

- name: Terraform JSON
  run: terraform show -json tfplan > tfplan.json

- name: OPA Validation
  run: |
    opa eval \
    --fail-defined \
    --input tfplan.json \
    --data policy/s3_bucket.rego \
    "data.terraform.s3.deny"
```

---

# Backstage Integration

This repository can be integrated with Backstage Software Templates.

```text
Backstage Template
        |
        v
Terraform Generation
        |
        v
OPA Validation
        |
        v
AWS Deployment
```

Benefits:

* Self-Service Infrastructure
* Secure Platform Engineering
* Automated Governance
* Standardized Deployments

---

# Enterprise Use Cases

## Platform Engineering

Build secure internal developer platforms.

## DevSecOps

Shift security left in the software delivery lifecycle.

## Cloud Governance

Enforce organizational standards automatically.

## Compliance Automation

Support:

* SOC 2
* ISO 27001
* PCI DSS
* HIPAA
* Internal Security Policies

---

# Learning Outcomes

After completing this project, you will understand:

* Terraform Fundamentals
* AWS Infrastructure Automation
* OPA Architecture
* Rego Policy Development
* Policy as Code
* Cloud Governance
* Infrastructure Security
* DevSecOps Best Practices
* Backstage Governance Integration

---

# Training Programs

This project is commonly used in:

* Terraform Training
* AWS Training
* Open Policy Agent (OPA) Training
* Rego Training
* DevSecOps Workshops
* Platform Engineering Training
* Backstage Training
* Cloud Security Training
* Enterprise Governance Programs

---

# SEO Keywords

Terraform AWS OPA Example

Terraform Policy as Code

Terraform Governance Framework

Open Policy Agent Tutorial

OPA Rego Examples

Terraform Security Best Practices

AWS S3 Bucket Validation

Infrastructure as Code Security

Cloud Governance Framework

Platform Engineering Governance

Backstage Terraform Integration

DevSecOps Infrastructure Security

AWS Compliance Automation

Terraform Corporate Training

OPA Corporate Training

AWS Corporate Training

Platform Engineering Training

Backstage Training

DevSecOps Corporate Training

Cloud Security Training

---

# Contributing

Contributions are welcome.

1. Fork the repository
2. Create a feature branch
3. Commit your changes
4. Submit a Pull Request

---

# License

MIT License

---

# GitHub Topics

Add the following repository topics:

terraform

aws

opa

open-policy-agent

rego

policy-as-code

terraform-security

terraform-governance

infrastructure-as-code

iac

devsecops

platform-engineering

backstage

backstage-io

aws-s3

cloud-security

compliance

github-actions

jenkins

gitops

enterprise-architecture

terraform-training

opa-training

aws-training
