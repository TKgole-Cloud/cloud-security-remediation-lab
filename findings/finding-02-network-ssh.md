# Finding 02 — Internet-Exposed SSH

## Status

Remediated

## Finding

The Network Security Group `nsg-cloud-security-lab` contained an inbound SSH rule allowing TCP port 22 from any source.

## Evidence — Before Remediation

Initial configuration:

```text
Source: *
Destination Port: 22
Access: Allow
Protocol: TCP
Direction: Inbound
```

This allowed SSH traffic from any source address.

Screenshot:

`../docs/screenshots/finding-02-network-before.png`

## Why This Matters

Exposing SSH to the internet increases the attack surface of the environment and can expose the service to unwanted connection attempts.

## Risk Assessment

**Impact:** Medium

**Likelihood:** Medium

**Priority:** Medium

## Remediation

The NSG rule was changed from allowing SSH from any source:

```hcl
source_address_prefix = "*"
```

to allowing SSH only from the Azure virtual network:

```hcl
source_address_prefix = "VirtualNetwork"
```

Terraform was used to apply the change.

## Validation

Azure CLI was used to verify the final NSG configuration.

Expected final state:

```text
Source: VirtualNetwork
Destination Port: 22
Access: Allow
Protocol: TCP
Direction: Inbound
```

Screenshot:

`../docs/screenshots/finding-02-network-after.png`

## Final State

SSH is no longer permitted from arbitrary internet sources by this NSG rule.

**Finding status: Remediated**
