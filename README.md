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

## Phase 3 — Security Finding 02: Internet-Exposed SSH

### Finding

The Network Security Group `nsg-cloud-security-lab` initially allowed inbound SSH traffic on TCP port 22 from any source.

Initial state:

```text
Source: *
Destination Port: 22
Access: Allow
```

### Risk

Allowing SSH from any source increases the network attack surface and exposes the service to unwanted connection attempts.

Risk assessment:

* Impact: Medium
* Likelihood: Medium
* Priority: Medium

### Remediation

The NSG rule was changed from:

```hcl
source_address_prefix = "*"
```

to:

```hcl
source_address_prefix = "VirtualNetwork"
```

Terraform was used to apply the change.

### Validation

Azure CLI confirmed the final rule configuration:

```text
Source: VirtualNetwork
Destination Port: 22
Access: Allow
```

Evidence:

* Before: `docs/screenshots/finding-02-network-before.png`
* After: `docs/screenshots/finding-02-network-after.png`
* Detailed finding: `findings/finding-02-network-ssh.md`

### Finding Status

**Remediated**

## Phase 4 — Security Finding 03: Excessive RBAC Permission

### Finding

The lab Azure identity was assigned the `Contributor` role at the resource-group scope.

```text
Identity
   ↓
Contributor
   ↓
rg-cloud-security-lab
```

The assignment provided broad resource-management permissions across the resource group.

### Risk

The assignment was considered excessive for the lab scenario because the required access was read-only.

This demonstrates the Azure RBAC principle of least privilege.

### Remediation

The unnecessary `Contributor` assignment was removed using Terraform.

### Validation

Azure CLI confirmed that no `Contributor` assignment remained at the resource-group scope.

Evidence:

* Detailed finding: `findings/finding-03-rbac.md`

### Finding Status

**Remediated**

---

# Final Security Remediation Summary

The lab simulated a cloud security remediation workflow involving three different security domains.

| Finding                   | Security Area        | Remediation                                | Status       |
| ------------------------- | -------------------- | ------------------------------------------ | ------------ |
| Storage public access     | Storage Security     | Disabled public blob access                | ✅ Remediated |
| Internet-exposed SSH      | Network Security     | Restricted SSH source                      | ✅ Remediated |
| Excessive RBAC permission | IAM / Access Control | Removed unnecessary Contributor assignment | ✅ Remediated |

## Overall Workflow

```text
Security Finding
      ↓
Understand the Issue
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
      ↓
Git Commit / Push
```

## Key Security Principles Demonstrated

### Least Privilege

Access should be limited to what an identity actually requires.

### Defense in Depth

Security controls should be applied across different layers:

```text
Storage
   ↓
Network
   ↓
Identity / Access
```

### Infrastructure as Code

Terraform was used to create, modify, and remove security configurations.

### Verification

Remediation was not considered complete until the final Azure configuration was independently validated.

## Important Evidence

### Finding 01 — Storage

* `docs/screenshots/finding-01-storage-before.png`
* `docs/screenshots/finding-01-storage-after.png`

### Finding 02 — Network

* `docs/screenshots/finding-02-network-before.png`
* `docs/screenshots/finding-02-network-after.png`

### Finding 03 — IAM

* `findings/finding-03-rbac.md`

## Project Outcome

This project demonstrates a practical cloud security remediation workflow rather than simply deploying Azure infrastructure.

The key objective was to demonstrate the ability to:

* Identify security weaknesses
* Understand their security implications
* Assess and prioritize findings
* Remediate infrastructure using Terraform
* Validate changes using Azure CLI
* Maintain evidence and documentation.
* Apply least-privilege security principles
