# Cloud Security Remediation Lab

## Project Overview

This project simulates a real-world cloud security remediation engagement for a resource-constrained startup.

The environment contains intentionally introduced security configuration weaknesses. The goal is to identify, assess, prioritize, remediate, validate, and document those findings using Azure and Terraform.

The project focuses on demonstrating a practical **Cloud Security Engineer workflow** rather than simply deploying cloud infrastructure.

---

## Scenario

A startup has a growing Azure environment but limited security resources.

A security assessment identifies multiple security findings. The engineering team cannot remediate everything at once, so findings must be assessed and prioritized before remediation.

### Security Remediation Workflow

```text
Security Finding
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

---

## Technologies

* Microsoft Azure
* Microsoft Defender for Cloud
* Azure Policy
* Terraform
* Azure RBAC / IAM
* Azure Networking
* Azure Storage
* Azure CLI
* GitHub

---

## Architecture

```text
Azure Subscription
        │
        ▼
rg-cloud-security-lab
        │
        ├── Storage Account
        │     └── Public access finding
        │
        ├── Network Security Group
        │     └── SSH exposure finding
        │
        └── Azure RBAC
              └── Excessive Contributor access
```

The security findings were intentionally introduced, investigated, remediated, and validated.

---

# Phase 1 — Terraform Foundation

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

---

# Finding 01 — Storage Public Access

## Finding

The Storage Account `zembecloudsecuritylab01` was intentionally configured with public blob access enabled.

Initial configuration:

```text
publicAccess = true
```

## Investigation

Azure CLI was used to verify the actual Storage Account configuration.

Microsoft Defender for Cloud did not return an evaluated recommendation for this resource in the lab environment. Azure Policy was also tested but returned zero applicable resources.

The Azure resource configuration was therefore used as the authoritative evidence for this finding.

## Risk Assessment

* Impact: Medium
* Likelihood: Medium
* Priority: Medium

Allowing public blob access can increase the risk of unintended data exposure if containers or blobs are made publicly accessible.

## Remediation

The Terraform configuration was changed from:

```hcl
allow_nested_items_to_be_public = true
```

to:

```hcl
allow_nested_items_to_be_public = false
```

Terraform was then applied successfully.

## Validation

Azure CLI confirmed:

```text
publicAccess = false
httpsOnly    = true
```

### Evidence

* Before: `docs/screenshots/finding-01-storage-before.png`
* After: `docs/screenshots/finding-01-storage-after.png`
* Detailed finding: `findings/finding-01-storage-public-access.md`

### Status

**Remediated ✅**

---

# Finding 02 — Internet-Exposed SSH

## Finding

The Network Security Group `nsg-cloud-security-lab` initially allowed inbound SSH traffic on TCP port 22 from any source.

Initial configuration:

```text
Source: *
Destination Port: 22
Access: Allow
Protocol: TCP
Direction: Inbound
```

## Risk Assessment

* Impact: Medium
* Likelihood: Medium
* Priority: Medium

Allowing SSH from any source increases the network attack surface and exposes the service to unwanted connection attempts.

## Remediation

The NSG rule was changed from:

```hcl
source_address_prefix = "*"
```

to:

```hcl
source_address_prefix = "VirtualNetwork"
```

Terraform was used to apply the change.

## Validation

Azure CLI confirmed:

```text
Source: VirtualNetwork
Destination Port: 22
Access: Allow
```

The rule no longer permits SSH from arbitrary internet sources through this NSG rule.

### Evidence

* Before: `docs/screenshots/finding-02-network-before.png`
* After: `docs/screenshots/finding-02-network-after.png`
* Detailed finding: `findings/finding-02-network-ssh.md`

### Status

**Remediated ✅**

---

# Finding 03 — Excessive RBAC Permission

## Finding

The lab Azure identity was temporarily assigned the `Contributor` role at the `rg-cloud-security-lab` resource-group scope.

```text
Identity
    ↓
Contributor
    ↓
rg-cloud-security-lab
```

The assignment provided broad resource-management permissions across the resource group.

## Risk Assessment

The assignment was considered excessive for the lab scenario because the required access was read-only.

This demonstrates the Azure RBAC principle of **least privilege**.

## Remediation

The unnecessary `Contributor` role assignment was removed using Terraform.

## Validation

Azure CLI was used to verify the role assignment at the resource-group scope.

No `Contributor` assignment remained after remediation.

### Evidence

* Detailed finding: `findings/finding-03-rbac.md`

### Status

**Remediated ✅**

---

# Final Security Remediation Summary

Three security findings were investigated and remediated across different security domains.

| Finding                   | Security Area        | Remediation                                | Status       |
| ------------------------- | -------------------- | ------------------------------------------ | ------------ |
| Storage public access     | Storage Security     | Disabled public blob access                | ✅ Remediated |
| Internet-exposed SSH      | Network Security     | Restricted SSH source                      | ✅ Remediated |
| Excessive RBAC permission | IAM / Access Control | Removed unnecessary Contributor assignment | ✅ Remediated |

---

## Security Principles Demonstrated

### Least Privilege

Access should be limited to what an identity actually requires.

### Defense in Depth

Security controls were considered across multiple layers:

```text
Storage
   ↓
Network
   ↓
Identity / Access
```

### Infrastructure as Code

Terraform was used to create, modify, and remove security configurations.

### Independent Validation

Remediation was not considered complete until the final Azure configuration was independently validated using Azure CLI.

---

## Important Evidence

### Finding 01 — Storage

* `docs/screenshots/finding-01-storage-before.png`
* `docs/screenshots/finding-01-storage-after.png`

### Finding 02 — Network

* `docs/screenshots/finding-02-network-before.png`
* `docs/screenshots/finding-02-network-after.png`

### Finding 03 — IAM

* `findings/finding-03-rbac.md`

---

## Project Outcome

This project demonstrates a practical cloud security remediation workflow.

The project demonstrates the ability to:

* Identify security weaknesses
* Understand security implications
* Assess and prioritize findings
* Remediate Azure infrastructure using Terraform
* Apply least-privilege principles
* Validate cloud configuration using Azure CLI
* Maintain security evidence
* Document remediation activities

### Core Workflow

```text
Identify
   ↓
Investigate
   ↓
Assess
   ↓
Prioritize
   ↓
Remediate
   ↓
Validate
   ↓
Document
```

**Project Status: Complete ✅**
