# -*- mode: ruby -*-
# vi: set ft=ruby :


Vagrant.configure(2) do |config|


  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "ubuntu/trusty64"


  # Create a forwarded port mapping.
  config.vm.network "forwarded_port", guest: 80, host: 8888
  config.vm.network "forwarded_port", guest: 3306, host: 8889


  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  config.vm.provider "virtualbox" do |vb|
    vb.customize ["modifyvm", :id, "--memory", "512"]
    vb.customize ["modifyvm", :id, "--name", "silverstripe-nginx"]
  end


  # Try to cache apt and composer dependencies
  if Vagrant.has_plugin?("vagrant-cachier")

    # Configure cached packages to be shared between instances of the same base box.
    config.cache.scope = :box

  end


  # Install our dependencies
  config.vm.provision "shell", :path => "provision.sh"


  # Expose the SilverStripe folder to the host
  config.vm.synced_folder "source/", "/var/www/silverstripe-nginx", create: true


end
