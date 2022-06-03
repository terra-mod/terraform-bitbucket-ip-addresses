# Bitbucket Whitelist IP Addresses

This module provides both an IPv4 and IPv6 list of IP Addresses from Bitbucket, useful for whitelisting and security
groups.

## Example usages

### AWS Security Groups (via Chunks)

Using this module to create AWS Security Groups is the most common used case. However, the number of CIDR ranges returned 
by Bitbucket now exceeds the number of `cidr_blocks` (or IP Addresses) allowed in an AWS Security Group.

This module now also includes a chunked list of IP Addresses, formatted as a map to make it easier to use `for_each` to dynamically
create the required number of security groups given the amount of IP Addresses returned. This stays below the limit of IP Addresses
allowed per security group.

```
module "bitbucket_ips" {
  source = "terra-mod/ip-addresses/bitbucket"

  ip_list_chunk_size = 40 // Default Value - changing this may result in more individual SGs being created.
}

resource "aws_security_group" "bitbucket_ingress" {
  for_each = module.bitbucket_ips.ipv4_chunks

  name        = "bitbucket-ingress-${each.key}"
  description = "Bitbucket IPv4 Ingress - Group ${each.key}"

  ingress {
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = each.value
    description      = "Webhooks from Atlassian public IP range"
  }
}
```

### AWS Policy via List

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
