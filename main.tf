module "vpc" {
  source = "./modules/vpc"
}

module "rds" {
  source = "./modules/rds"
}

module "eb" {
  source = "./modules/eb"
  # network setting
    main_vpc_id = module.vpc.main_vpc_id
    loadb_public_subnet1_id = module.vpc.public_subnet1_id
    loadb_public_subnet2_id = module.vpc.public_subnet2_id

  #database setting
    db_instance_endpoint = module.rds.db_endpoint
    db_instance_username = module.rds.db_username_credential
}