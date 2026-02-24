terraform {
  required_providers {
    sops = {
      source = "carlpett/sops"
      version = "~> 1.3.0"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 5"
    }
  }
}

data "sops_file" "secrets" {
  source_file = "secrets.enc.yaml"
}

locals {
  secrets = yamldecode(data.sops_file.secrets.raw)
  endpoints_safe = nonsensitive(local.secrets.homelab.cloudflare.endpoints)
}

provider "cloudflare" {
  api_token = local.secrets.homelab.cloudflare.api_token
}

resource "cloudflare_dns_record" "homelab_service_records" {
  for_each = {
    for idx, m in local.endpoints_safe : idx => m
  }

  zone_id = local.secrets.homelab.cloudflare.zone_id
  name    = "*.service.${local.secrets.homelab.cloudflare.zone_name}"
  ttl     = 1
  type    = "A"
  comment = "Domain verification record for ${each.value.name}"
  content = each.value.ipv4
  proxied = true
}

resource "cloudflare_dns_record" "homelab_service_records_ipv6" {
  for_each = {
    for idx, m in local.endpoints_safe : idx => m
  }

  zone_id = local.secrets.homelab.cloudflare.zone_id
  name    = "*.service.${local.secrets.homelab.cloudflare.zone_name}"
  ttl     = 1
  type    = "AAAA"
  comment = "Domain verification record (IPv6) ${each.value.name}"
  content = each.value.ipv6
  proxied = true
}
