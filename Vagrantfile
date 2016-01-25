VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "ubuntu/trusty64"
  # config.vm.network :private_network, ip: "192.168.0.10"
  config.vm.network "private_network", type: "dhcp"

  # Tip: Run 'vagrant plugin install vagrant-vbguest'
  config.vm.provider "virtualbox" do |v|
    v.customize ["modifyvm", :id, "--memory", "1024"]
  end

  # Tip: Run 'vagrant plugin install vagrant-digitalocean'
  config.vm.provider "digital_ocean" do |provider, override|
    override.vm.box = "digital_ocean"
    override.vm.box_url = "https://github.com/smdahlen/vagrant-digitalocean/raw/master/box/digital_ocean.box"
    # Tip: Run 'ssh-keygen -f ~/.ssh/Vagrant'
    override.ssh.private_key_path = "~/.ssh/Vagrant"

    provider.token = ENV['DIGITALOCEAN_TOKEN']
    provider.image = "ubuntu-14-04-x64"
    #provider.region = "nyc3"
    provider.size = '512mb'
    provider.name = 'hardened-ubuntu'
    provider.private_networking = true
  end

  config.vm.post_up_message = "
  If you are lucky, I might have some documentation on https://github.com/wmhilton/production-ubuntu.
  No promises though.
  "

  # My apologies for putting config into a shell script.
  # Create an environment from the config file
  environ = "env "
  File.foreach( 'config.sh' ) do |line|
    key, val = line.sub(/\s*#.*/,'').strip().split('=',2)
    if not val.nil? and val != ""
      environ += "#{key}=#{val} "
    end
  end
  File.foreach( 'private/config.sh' ) do |line|
    key, val = line.sub(/\s*#.*/,'').strip().split('=',2)
    if not val.nil? and val != ""
      environ += "#{key}=#{val} "
    end
  end

  e = Hash.new
  Dir.foreach( "servers" ) do |f|
    if f != "." and f != ".." and File.directory? "servers/#{f}"
      e[f] = environ
      File.foreach( "servers/#{f}/config.sh" ) do |line|
        key, val = line.sub(/\s*#.*/,'').strip().split('=',2)
        if not val.nil? and val != ""
          e[f] += "#{key}=#{val} "
        end
      end
      config.vm.define f do |config|
        config.vm.hostname = "#{f}-#{Time.now.getutc.to_i}"
        config.vm.provision "os", type: "shell" do |s|
          s.inline = "#{e[f]} /vagrant/setup.sh"
        end
      end
    end
  end

  config.vm.define "www" do |config|

    # Put your personal app's installer here.
    config.vm.provision "app", type: "shell" do |s|
      s.inline = "#{e["www"]} /vagrant/install.sh"
    end

    # Put your personal app's installer here.
    config.vm.provision "run", type: "shell" do |s|
      s.inline = "service www start #{e["www"]}"
    end
  end
end
