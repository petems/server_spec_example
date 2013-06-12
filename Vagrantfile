Vagrant::Config.run do |config|
  config.vm.box = "precise64"

  config.vm.box_url = "http://files.vagrantup.com/precise64.box"

  guest_address = '192.168.30.20'
  warn "Guest VM will listen on #{guest_address}"
  config.ssh.forward_agent = true
  config.vm.network :hostonly, guest_address
  #config.vm.provision :shell, :path => "vagrant.sh"
end