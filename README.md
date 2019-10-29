# Bitbucket Whitelist IP Addresses

This module provides both an IPv4 and IPv6 list of IP Addresses from Bitbucket, useful for whitelisting and security
groups. In order to use this module, you must have both `bash` and `jq` installed on the system running Terraform.

For a JSON list of these ip addresses, see [here](https://ip-ranges.atlassian.com/).

### Installing JQ

This module uses `jq` for parsing the JSON response from Bitbucket's ip-range endpoint.  To install `jq` on your 
system, please see [here](https://github.com/stedolan/jq/wiki/Installation).
