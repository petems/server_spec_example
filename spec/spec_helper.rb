require 'serverspec'
require 'pathname'
require 'net/ssh'

include Serverspec::Helper::Ssh
include Serverspec::Helper::DetectOS

RSpec.configure do |c|
  if ENV['ASK_SUDO_PASSWORD']
    require 'highline/import'
    c.sudo_password = ask("Enter sudo password: ") { |q| q.echo = false }
  else
    c.sudo_password = ENV['SUDO_PASSWORD']
  end
  c.before :all do
    block = self.class.metadata[:example_group_block]
    if RUBY_VERSION.start_with?('1.8')
      file = block.to_s.match(/.*@(.*):[0-9]+>/)[1]
    else
      file = block.source_location.first
    end
    host  = File.basename(Pathname.new(file).dirname)
    if c.host != host
      c.ssh.close if c.ssh
      c.host  = host
      options = Net::SSH::Config.for(c.host)
      user    = options[:user] || Etc.getlogin

      #Not working currently...
      #vagrant_available?('foo')

      config = `vagrant ssh-config foo`
      if config != ''
        config.each_line do |line|
          if match = /HostName (.*)/.match(line)
            c.host = match[1]
          elsif  match = /User (.*)/.match(line)
            user = match[1]
          elsif match = /IdentityFile (.*)/.match(line)
            options[:keys] =  [match[1].gsub(/"/,'')]
          elsif match = /Port (.*)/.match(line)
            options[:port] = match[1]
          end
        end
      end
      c.ssh   = Net::SSH.start(c.host, user, options)
    end
  end

  def vagrant_available?(vm_name)
    if File.exists?("Vagrantfile")
      vagrant_status = `vagrant status #{vm_name}`
      if vagrant_status != ''
        vagrant_status.each_line do |line|
          if match = /([a-z]+[\s]+)(created|not created|poweroff|running|saved)[\s](\(virtualbox\)|\(vmware\))/.match(line)
            if match[2].strip! != 'running'
              abort "Vagrant box not running. Run `vagrant up` before you run the rspec"
            end
          end
        end
      else
        abort "Vagrant status error - Check your Vagrantfile or .vagrant folder"
      end
    else
      abort "Vagrantfile not found in directory!"
    end
  end

end
