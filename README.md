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

# Finding 01 — Storage Public Access

## Status

Open

## Finding

The Azure Storage Account `zembecloudsecuritylab01` is configured with public blob access enabled.

## Evidence

Azure CLI verification confirmed:

```text
httpsOnly    = true
publicAccess = true
```

Screenshot:

`../docs/screenshots/finding-01-storage-before.png`

## Why This Matters

Allowing public blob access can increase the risk of data being exposed if a container or blob is made public unintentionally.

The actual impact depends on what data is stored and whether any containers or blobs are publicly accessible.

## Current State

```text
Public blob access: ENABLED
```

## Planned Remediation

We will investigate the security recommendation and determine whether public access is required.

If it is not required, we will disable public blob access using Terraform.

## Validation

Validation will be performed after remediation to confirm that the configuration has changed and the relevant security recommendation has been addressed.


## Phase 2 — Security Finding 01: Storage Public Access

### Finding

The Storage Account `zembecloudsecuritylab01` was intentionally configured with public blob access enabled to simulate a security finding.

Initial configuration:

```text
publicAccess = true
```

### Investigation

The Storage Account configuration was verified directly using Azure CLI.

Microsoft Defender for Cloud did not return an evaluated recommendation for this resource in the lab environment. Azure Policy was also tested, but returned zero applicable resources.

The resource configuration was therefore used as the authoritative evidence for this lab finding.

### Risk

Unnecessary public blob access can increase the risk of unintended data exposure if containers or blobs are made publicly accessible.

The finding was assessed as:

* Impact: Medium
* Likelihood: Medium
* Priority: Medium

### Remediation

The Terraform configuration was changed from:

```hcl
allow_nested_items_to_be_public = true
```

to:

```hcl
allow_nested_items_to_be_public = false
```

Terraform successfully applied the change.

### Validation

Azure CLI confirmed the final configuration:

```text
publicAccess = false
httpsOnly    = true
```

Evidence:

* Before: `docs/screenshots/finding-01-storage-before.png`
* After: `docs/screenshots/finding-01-storage-after.png`
* Detailed finding: `findings/finding-01-storage-public-access.md`

### Finding Status

**Remediated**

### Remediation Workflow

```text
Identify
   ↓
Investigate
   ↓
Assess Risk
   ↓
Prioritize
   ↓
Remediate with Terraform
   ↓
Validate with Azure CLI
   ↓
Document Evidence
```
