# Finding 01 — Storage Public Access

## Status

Remediated

## Finding

The Azure Storage Account `zembecloudsecuritylab01` was configured with public blob access enabled.

## Evidence — Before Remediation

Azure CLI confirmed:

```text
publicAccess = true
httpsOnly    = true
```

Screenshot:

`../docs/screenshots/finding-01-storage-before.png`

## Why This Matters

Allowing public blob access can increase the risk of data exposure if a container or blob is made public unintentionally.

The actual impact depends on the data stored and whether any containers or blobs are publicly accessible.

## Risk Assessment

**Impact:** Medium

**Likelihood:** Medium

**Priority:** Medium

The finding was prioritized because unnecessary public access can increase the attack surface of a storage account.

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

Azure CLI was used to verify the final configuration.

Result:

```text
publicAccess = false
httpsOnly    = true
```

Screenshot:

`../docs/screenshots/finding-01-storage-after.png`

## Final State

Public blob access: **DISABLED**

HTTPS-only traffic: **ENABLED**

**Finding status: Remediated**

## Detection Notes

Microsoft Defender for Cloud did not surface this configuration as an evaluated recommendation in this lab environment.

Azure Policy was also tested as a detection mechanism, but returned zero applicable resources.

The configuration was therefore validated directly through Azure resource configuration and remediated through Terraform.

This demonstrates an important security engineering principle:

> Security tools provide valuable visibility, but engineers must still validate the actual cloud configuration.
