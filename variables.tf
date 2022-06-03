variable "ip_list_chunk_size" {
  description = "The chunk size to use for IPv4 and IPv6 CIDR addresses. This is primarily useful for generating multiple security groups in AWS, where the default list will exceed the allowed number of IP Addresses."
  type        = number
  default     = 40
}