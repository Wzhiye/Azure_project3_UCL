resource "azurerm_network_interface" "test" {
  name                = "${var.application_type}-${var.resource_type}"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group}"

  ip_configuration {
    name                          = "internal"
    subnet_id                     = "${var.subnet_id}"
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = "${var.public_ip}"
  }
}

resource "azurerm_linux_virtual_machine" "test" {
  name                = "${var.application_type}-${var.resource_type}"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group}"
  size                = "Standard_B1s"
  admin_username      = "Zhiye"
  network_interface_ids = [azurerm_network_interface.test.id,]
  admin_ssh_key {
    username   = "Zhiye"
    public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDO14eEhMW95BSD3LxfuhntAZuMEDLL8jYGJWQ0y0S5ZjHse5/fWjGdPXGxyr1/Poxae50+PmDJljzy4v0EuLt7EB4e164ZYLVKzoU9UP6bzv8b/U5Rnc1Il+wvwvWdyAXu6eoZLCtk+NzpqFn9dpOn1jfr2EBoGg0+y/3mL7DX0wS0vdJrDUXK4s/qKUzwKSw/yf/BWDzKCDe5mqv7O1q315nOmkemBjJglG1/sV9cctmOkXb7POQzkZGxSKCfsxUh2F7+P8GBnytnnEP0sKotvd57zXLNyVF5mq7znApVXZkhB+u/cvj+qt85mmJIf/gT4KfvhWiElUmbDlmm/AOzP+PMIEaD+FXX/V/MaKntq3h1reFw0h/2p/arLsghEOYIS97ayjVYwLpi7fab0BgRba9XVinUkM1E5FpovgWJZkG+iwV8+G9Pd7NjTrG6JDp5L8Jbn2UOF3EhCEt1g4AL7kHS6blHc22g5ZIro2G3ybwCAbovA2LyJzyaN4qPcq1MZSb4AClm0JDqkTBnm8gu993sYrtYK5NSDXPVycuoJ3O29/qbGdBmpuwjilrT9RAsl3wsSOP26lu3G5zdRWIZNsBOSk6lVil7EGvSAjMpAdXIPDM/UKadSu48O3u8pw365ZcnR/tf+kEmmHkccGKStEsfJwp/tfZGbygSxI3pwQ== wzhiy@Wen"
    #public_key = file(var.vm_public_key) 
     
  }
  os_disk {
    caching           = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
}
