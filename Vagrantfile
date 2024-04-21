# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  # Define base box
  config.vm.box = "ubuntu/focal64"

  # Define VMs
  master_vm = config.vm.define "Master" do |master|
    master.vm.hostname = "master"
  end

  slave_vm = config.vm.define "Slave" do |slave|
    slave.vm.hostname = "slave"
  end

end
