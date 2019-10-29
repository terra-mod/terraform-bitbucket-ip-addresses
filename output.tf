output "ipv4_ip_addresses" {
  description = "A list of IPv4 Addresses for outbound connections from Bitbucket's services."
  value       = split(",", data.external.ip_addresses.result.ipv4)
}

output "ipv6_ip_addresses" {
  description = "A list of IPv6 Addresses for outbound connections from Bitbucket's services."
  value       = split(",", data.external.ip_addresses.result.ipv6)
}
