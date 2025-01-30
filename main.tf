# Get the JSON list of IP Addresses from Bitbucket.
data "http" "bitbucket_ips" {
  url = "https://ip-ranges.atlassian.com/"

  request_headers = {
    "Accept" = "application/json"
  }
}

locals {
  ip_range = tolist(jsondecode(data.http.bitbucket_ips.response_body).items[*].cidr)
  ipv4_range = compact([
    for cidr in local.ip_range :
    replace(cidr, "/.*[:].*/", "")
  ])
  ipv6_range = compact([
    for cidr in local.ip_range :
    replace(cidr, "/.*[.].*/", "")
  ])
}
