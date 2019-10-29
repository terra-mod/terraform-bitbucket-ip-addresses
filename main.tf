# Get the JSON list of IP Addresses from Bitbucket.
data "http" "bitbucket_ips" {
  url = "https://ip-ranges.atlassian.com/"

  request_headers = {
    "Accept" = "application/json"
  }
}

# Format response to separate IPv4 and IPv6.
data "external" "ip_addresses" {
  program = ["bash", "-c", "echo '${data.http.bitbucket_ips.body}' | jq '{ipv4:[.items[]|select(.cidr|contains(\":\")|not).cidr]|join(\",\"),ipv6:[.items[]|select(.cidr|contains(\":\")).cidr]|join(\",\")}'"]
}

