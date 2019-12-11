variable "machine_type" {
  description = "GCP Instance Machine Type"
  default     = "n1-standard-2"
}

variable "zone" {
  description = "GCP Zone"
  default     = "us-west1-a"
}

variable "os_image" {
  description = "GCE OS Image"
  default     = "ubuntu-os-cloud/ubuntu-1604-lts"
}

variable "subnet_name" {
    description = "GCE VPC Network Name"
    default     = ""
}

variable "instance_name" {
  description = "Name of instances"
}

variable "root_volume_type" {
  description = "Boot Volume Type"
  default     = "pd-standard"
}

variable "root_volume_size" {
  description = "Boot Volume Size"
  default     = "10"
}

variable "tags" {
  description = "Network Tags for GCP firewall rules"
  type        = "list"
}

variable "num_instances" {
  description = ""
}
