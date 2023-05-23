module "sql" {
  source = "./infra-modules/gcp-sql"
  private_vpc =   module.vpc.vpc.self_link

  
  

}