terraform {
  required_providers {
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = "~> 1.43"  # Utilisez la version recommandée ou la plus récente
    }
  }
}

# Définir le provider OpenStack
provider "openstack" {
  auth_url    = "http://192.168.100.11:5000/v3"  # Adresse d'authentification OpenStack
  user_name    = "admin"                         # Utilisateur admin
  password    = "sabat_strap"                   # Mot de passe
  tenant_name = "admin"                        # Nom du projet
  domain_name = "Default"                       # Domaine Default
  region      = "RegionOne"                     # Vous pouvez changer la région selon votre configuration
}

# Obtenir l'image Cirros pour les tests
data "openstack_images_image_v2" "cirros_image" {
  name = "cirros"  # Nom de l'image Cirros
}

# Récupérer le réseau selfservice existant
data "openstack_networking_network_v2" "selfservice_network" {
  name = "selfservice"
}

# Récupérer le sous-réseau pour selfservice
data "openstack_networking_subnet_v2" "selfservice_subnet" {
  network_id = data.openstack_networking_network_v2.selfservice_network.id
}

# Créer une instance
resource "openstack_compute_instance_v2" "cirros_instance" {
  name            = "cirros-instance"
  image_id        = data.openstack_images_image_v2.cirros_image.id
  flavor_name     = "m1.nano"  # Le type d'instance (flavor)
  key_pair        = "mykey"    # Utilisation de la clé SSH 'mykey' existante
  network {
    uuid = data.openstack_networking_network_v2.selfservice_network.id
  }
  security_groups = ["default"]

  # Configuration de l'instance avec un cloud-config minimal
  user_data = <<-EOF
              #cloud-config
              hostname: cirros-instance
              EOF
}

