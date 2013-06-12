Vagrant::Config.run do |config|
  config.vm.box = "server_spec_example"
  config.vm.box_url = "http://files.vagrantup.com/precise64.box"
  config.ssh.forward_agent = true
  config.vm.provision :shell, :path => "vagrant.sh"
end