output "ip_range" {
  description = "A list of IPv4 and IPv6 Addresses for outbound connections from Bitbucket's services."
  value       = local.ip_range
}

output "ipv4_range" {
  description = "A list of IPv4 CIDR Addresses for outbound connections from Bitbucket's services."
  value       = local.ipv4_range
}

output "ipv4_chunks" {
  description = "A map of IPv4 CIDR Addresses chunked for outbound connections from Bitbucket's services. Map format is numeric zero-index key and list of IP Addresses as a value. Ex: `map(list(string))`"
  value       = {for k, v in chunklist(local.ipv4_range, var.ip_list_chunk_size) : k => v}
}

output "ipv6_range" {
  description = "A list of IPv6 CIDR Addresses for outbound connections from Bitbucket's services."
  value       = local.ipv6_range
}

output "ipv6_chunks" {
  description = "A map of IPv6 CIDR Addresses chunked for outbound connections from Bitbucket's services. Map format is numeric zero-index key and list of IP Addresses as a value. Ex: `map(list(string))`"
  value       = {for k, v in chunklist(local.ipv6_range, var.ip_list_chunk_size) : k => v}
}

output "ipv4_ip_addresses" {
  description = "Alias to ipv4_range"
  value       = local.ipv4_range
}

output "ipv6_ip_addresses" {
  description = "Alias to ipv6_range"
  value       = local.ipv6_range
}
