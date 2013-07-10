Vagrant::Config.run do |config|
  config.vm.define :foo do |foo_config|
    foo_config.vm.box = "precise64"
    foo_config.vm.box_url = "http://files.vagrantup.com/precise64.box"
    foo_config.ssh.forward_agent = true
    foo_config.vm.provision :shell, :path => "vagrant.sh"
  end

  config.vm.define :bar do |bar_config|
    bar_config.vm.box = "precise64"
    bar_config.vm.box_url = "http://files.vagrantup.com/precise64.box"
    bar_config.ssh.forward_agent = true
    bar_config.vm.provision :shell, :path => "vagrant.sh"
  end
end