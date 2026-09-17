# Finding 03 — Excessive RBAC Permission

## Status

Remediated

## Finding

The current Azure identity was assigned the `Contributor` role at the `rg-cloud-security-lab` resource-group scope.

The assignment provided broad resource-management permissions across the entire resource group.

## Evidence — Before Remediation

Azure CLI confirmed:

```text
Role: Contributor

Scope:
.../resourceGroups/rg-cloud-security-lab
```

This was treated as a least-privilege finding because the lab scenario required read-only access rather than broad resource-management permissions.

## Why This Matters

Azure RBAC should follow the principle of least privilege.

Users and workloads should receive only the permissions required to perform their responsibilities.

A broad role at resource-group scope can provide more access than necessary when the identity only needs limited permissions.

## Risk Assessment

**Impact:** Medium

**Likelihood:** Medium

**Priority:** Medium

## Remediation

The unnecessary `Contributor` role assignment was removed through Terraform.

The role assignment resource was deleted from the Terraform configuration and `terraform apply` successfully removed the assignment from Azure.

## Validation

Azure CLI was used to query Contributor assignments at the resource-group scope.

No Contributor assignment remained after remediation.

## Final State

The unnecessary resource-group-level Contributor assignment has been removed.

**Finding status: Remediated**

## Security Principle

> Grant the minimum permissions required to perform the task.
