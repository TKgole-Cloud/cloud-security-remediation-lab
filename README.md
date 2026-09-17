# Cloud Security Remediation Lab

## Project Overview

This project simulates a real-world cloud security remediation engagement for a resource-constrained startup.

The environment will intentionally contain selected security configuration weaknesses. Microsoft Defender for Cloud will be used to identify security recommendations, after which the findings will be assessed, prioritized, remediated, and validated.

The goal is to demonstrate a practical Cloud Security Engineer workflow rather than simply deploying Azure resources.

## Scenario

A startup has a growing Azure environment but limited security resources.

A security assessment identifies multiple security findings. The engineering team cannot remediate everything at once, so the highest-priority findings must be identified and addressed first.

### Security Remediation Workflow

```text
Security Findings
       ↓
Understand the Issue
       ↓
Assess Risk
       ↓
Prioritize
       ↓
Remediate
       ↓
Validate
       ↓
Document Evidence
```

## Technologies

* Microsoft Azure
* Microsoft Defender for Cloud
* Terraform
* Azure RBAC / IAM
* Azure Networking
* Azure Storage
* Azure Key Vault
* GitHub

## Current Architecture

The project currently contains the foundational Azure Resource Group:

```text
Azure Subscription
       │
       ▼
rg-cloud-security-lab
       │
       └── Security lab resources
```

## Phase 1 — Terraform Foundation

### Completed

* Created GitHub repository
* Created project structure
* Added `.gitignore`
* Configured Terraform AzureRM provider
* Created Azure Resource Group using Terraform
* Applied Terraform configuration successfully

### Resource Group

| Resource     | Value                   |
| ------------ | ----------------------- |
| Name         | `rg-cloud-security-lab` |
| Region       | `South Africa North`    |
| Environment  | Lab                     |
| Provisioning | Terraform               |

## Project Principle

The project follows:

> **Understand → Build → Verify → Remediate → Validate → Document**

Only significant security evidence will be captured as screenshots.
