output "ip_range" {
  description = "A list of IPv4 and IPv6 Addresses for outbound connections from Bitbucket's services."
  value       = local.ip_range
}

output "ipv4_range" {
  description = "A list of IPv4 Addresses for outbound connections from Bitbucket's services."
  value       = local.ipv4_range
}

output "ipv6_range" {
  description = "A list of IPv6 Addresses for outbound connections from Bitbucket's services."
  value       = local.ipv6_range
}

output "ipv4_ip_addresses" {
  description = "Alias to ipv4_range"
  value       = local.ipv4_range
}

output "ipv6_ip_addresses" {
  description = "Alias to ipv6_range"
  value       = local.ipv6_range
}
