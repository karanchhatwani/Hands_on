module "cluster" {
  source = "./infra-modules/gcp-gke"
  vpc = module.vpc.vpc
}