resource "azurerm_resource_group" "rg" {
  name     = "tungdt-terraform"
  location = "Southeast Asia"
}

# Create a virtual network
resource "azurerm_virtual_network" "vnet" {
  name                = "created-by-terraform"
  address_space       = ["10.0.0.0/16"]
  location            = var.region
  resource_group_name = azurerm_resource_group.rg.name
}

# Create subnet
resource "azurerm_subnet" "subnet" {
  name                 = "${local.subnet}-1"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_subnet" "subnet-2" {
  name                 = "${local.subnet}-2"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_subnet" "subnet-3" {
  name                 = "${local.subnet}-3"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.3.0/24"]
}

resource "azurerm_subnet" "subnet-4" {
  name                 = "${local.subnet}-4"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.4.0/24"]
}

resource "azurerm_subnet" "subnet-5" {
  name                 = "${local.subnet}-5"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.5.0/24"]
}

resource "azurerm_subnet" "subnet-6" {
  name                 = "${local.subnet}-6"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.6.0/24"]
}

#define public ip
resource "azurerm_public_ip" "myvm1publicip" {
  name                = "public-ip-terraform"
  location            = "Southeast Asia"
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Dynamic"
  sku                 = "Basic"
}

#define network interface for VM
resource "azurerm_network_interface" "tung-terraform" {
  name                = "tungdt-terraform"
  location            = var.region
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "public-1"
    subnet_id                     = azurerm_subnet.subnet-3.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.myvm1publicip.id
  }
}

# Data template Bash bootstrapping file
data "template_file" "linux-vm-cloud-init" {
  template = file("test.sh")
}

resource "azurerm_virtual_machine" "main" {
  name                             = "terraform-vm"
  location                         = "Southeast Asia"
  resource_group_name              = azurerm_resource_group.rg.name
  network_interface_ids            = [azurerm_network_interface.tung-terraform.id]
  vm_size                          = "Standard_B1s"
  delete_os_disk_on_termination    = true
  delete_data_disks_on_termination = true
  

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
  storage_os_disk {
    name              = "terraform-disk-1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "hostname"
    admin_username = "tungdothanh"
    admin_password = "Sonyinternettv1"
    custom_data = base64encode(data.template_file.linux-vm-cloud-init.rendered)
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
  tags = {
    Name = "terraform"
  }
}
