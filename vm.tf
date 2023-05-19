module "vm" {
source = "./infra-modules/gcp-vm"
private_subnet =   module.vpc.private_subnet.self_link
private_vpc =  module.vpc.address.self_link
}