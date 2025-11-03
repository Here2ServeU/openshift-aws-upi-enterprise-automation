module "vpc" {
  source   = "../../modules/vpc"
  name     = "upi-dev"
  region   = var.region
  vpc_cidr = "10.50.0.0/16"
  tags     = var.tags
}
