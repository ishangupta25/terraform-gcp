# terraform-gcp

Update project name in vpc.tf.

root@b2b7b4040c04:/terraform-gcp# ls /terraform-gcp/vpc.tf
/terraform-gcp/vpc.tf



Update project name in main.tf files under both private and public folders in compute.

root@b2b7b4040c04:/terraform-gcp# ls /terraform-gcp/compute/private
main.tf
root@b2b7b4040c04:/terraform-gcp# ls /terraform-gcp/compute/public
main.tf



Create VPC with subnets, firewall rules and Cloud NAT

root@b2b7b4040c04:/terraform-gcp# pwd
/terraform-gcp
root@b2b7b4040c04:/terraform-gcp# terraform init
root@b2b7b4040c04:/terraform-gcp# terraform plan
root@b2b7b4040c04:/terraform-gcp# terraform apply

Create VM with public and private IP (Public subnet)

root@b2b7b4040c04:/terraform-gcp/compute/publice# pwd
/terraform-gcp/compute/public
root@b2b7b4040c04:/terraform-gcp# terraform init
root@b2b7b4040c04:/terraform-gcp# terraform plan
root@b2b7b4040c04:/terraform-gcp# terraform apply

Create VM with only private IP (Private subnet)

root@b2b7b4040c04:/terraform-gcp/compute/private# pwd
/terraform-gcp/compute/private
root@b2b7b4040c04:/terraform-gcp# terraform init
root@b2b7b4040c04:/terraform-gcp# terraform plan
root@b2b7b4040c04:/terraform-gcp# terraform apply
