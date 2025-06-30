module "vpc-dev" { #название модуля
  source       = "./vpc-dev" 
  env_name_network = "network" #параметры которые передаем
  env_name_subnet  = "subnet" #параметры которые передаем
  zone = "ru-central1-a"
  cidr = ["10.0.1.0/24"]
}

module "clickhouse-01" {
  #source         = "git::https://github.com/olegveselov1984/yandex_compute_instance.git?ref=main"
  source         = "./module-srv-vm"
  network_id     = module.vpc-dev.network_id 
  subnet_zones   = ["ru-central1-a","ru-central1-b"]
  subnet_ids     = [module.vpc-dev.subnet_id] 
  instance_cores = 2
  instance_memory = 4
  instance_name  = "clickhouse-01"
  env_name = "clickhouse-01" # Имя одной конкретной ВМ. instance_count не учитывается
  image_family   = "centos-7"
  public_ip      = true
  security_group_ids = [
  yandex_vpc_security_group.example.id 
  ]
   labels = { 
     project = "clickhouse-01"
      }
  metadata = {
    user-data          = data.template_file.cloudinit.rendered #Для демонстрации №3
    serial-port-enable = 1
  }

}

module "vector-01" {
  #source         = "git::https://github.com/olegveselov1984/yandex_compute_instance.git?ref=main"
  source         = "./module-srv-vm"
  network_id     = module.vpc-dev.network_id 
  subnet_zones   = ["ru-central1-a"]
  subnet_ids     = [module.vpc-dev.subnet_id]
  instance_name  = "vector-01"
  env_name = "vector-01"
  image_family   = "centos-7"
  public_ip      = true
  security_group_ids = [
  yandex_vpc_security_group.example.id 
  ]
   labels = { 
     project = "vector-01"
      }
  metadata = {
    user-data          = data.template_file.cloudinit.rendered #Для демонстрации №3
    serial-port-enable = 1
  }

}

module "lighthouse-01" {
   source         = "git::https://github.com/olegveselov1984/yandex_compute_instance.git?ref=main"
  network_id     = module.vpc-dev.network_id 
  subnet_zones   = ["ru-central1-a"]
  subnet_ids     = [module.vpc-dev.subnet_id]
  instance_name  = "lighthouse-01"
  env_name = "lighthouse-01"
  image_family   = "centos-7"
  public_ip      = true
  security_group_ids = [
  yandex_vpc_security_group.example.id 
  ]
   labels = { 
     project = "lighthouse-01"
      }
  metadata = {
    user-data          = data.template_file.cloudinit.rendered #Для демонстрации №3
    serial-port-enable = 1
  }

}

#Пример передачи cloud-config в ВМ.(передали путь к yml файлу и переменную!_ssh_public_key)
data "template_file" "cloudinit" {
  template = file("./cloud-init.yml")
   vars = {
     ssh_public_key = var.ssh_public_key
   }
}

