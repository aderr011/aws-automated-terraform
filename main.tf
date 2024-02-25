include {
  path = find_in_parent_folders()
}

terraform {
  source = "modules/vpc"
}

inputs = {
  vpc_cidr             = local.vpc_cidr
  availability_zones   = local.availability_zones
  public_subnet_cidrs  = local.public_subnet_cidrs
  private_subnet_cidrs = local.private_subnet_cidrs
}

