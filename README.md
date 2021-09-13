# Bitbucket Whitelist IP Addresses

This module provides both an IPv4 and IPv6 list of IP Addresses from Bitbucket, useful for whitelisting and security
groups.

## Example usages

### AWS Security group

```
module "bitbucket_ips" {
  source = "terra-mod/ip-addresses/bitbucket"
}

resource "aws_security_group" "example" {
  name        = "example"
  description = "Example security group"

  ingress {
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = module.bitbucket_ips.ipv4_range
    ipv6_cidr_blocks = module.bitbucket_ips.ipv6_range
    description      = "Webhooks from Atlassian public IP range"
  }
}
```

### AWS Policy

```
module "bitbucket_ips" {
  source = "terra-mod/ip-addresses/bitbucket"
}

data "aws_iam_policy_document" "example" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRoleWithWebIdentity"]
    principals {
      type        = "Federated"
      identifiers = ["arn:aws:iam::XXXXXXXXXXXX:oidc-provider/api.bitbucket.org/2.0/workspaces/mywspace/pipelines-config/identity/oidc"]
    }
    condition {
      test     = "StringEquals"
      variable = "api.bitbucket.org/2.0/workspaces/mywspace/pipelines-config/identity/oidc:aud"
      values   = ["ari:cloud:bitbucket::workspace/mywspace_uuid"]
    }
    condition {
      test     = "IpAddress"
      variable = "aws:SourceIp"
      values   = module.bitbucket_ips.ipv4_range
    }
  }
}
```
