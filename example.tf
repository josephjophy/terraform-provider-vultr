terraform {
    required_providers {
      vultr = {
        source = "vultr/vultr"
      }
    }
  }

  provider "vultr" {
    api_key = var.vultr_api_key
  }

  variable "vultr_api_key" {
    type      = string
    sensitive = true
  }

  resource "vultr_instance" "node" {
    region      = "ewr"
    plan        = "vc2-1c-1gb"
    os_id       = 2136
    enable_ipv6 = true
    label       = "tf-repro-reverse-dns-node"
    hostname    = "tf-repro-reverse-dns-node"
  }

  resource "vultr_reverse_ipv4" "node" {
    instance_id = vultr_instance.node.id
    ip          = vultr_instance.node.main_ip
    reverse     = "node.example.com"
  }

  resource "vultr_reverse_ipv6" "node" {
    instance_id = vultr_instance.node.id
    ip          = vultr_instance.node.v6_main_ip
    reverse     = "node.example.com"
  }
