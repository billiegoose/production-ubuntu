VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "ubuntu/trusty64"
  config.vm.hostname = "server"
  config.vm.network :private_network, ip: "192.168.0.10"

  config.vm.provider "virtualbox" do |v|
    v.customize ["modifyvm", :id, "--memory", "1024"]
  end
  config.vm.provider "digital_ocean" do |provider, override|
    override.ssh.private_key_path = "~/.ssh/digital_ocean"
    override.vm.box = "digital_ocean"
    override.vm.box_url = "https://github.com/smdahlen/vagrant-digitalocean/raw/master/box/digital_ocean.box"
    provider.token = ENV['DIGITALOCEAN_TOKEN']
    provider.image = "ubuntu-14-04-x64"
    provider.region = "nyc3"
    provider.size = '1gb'
    provider.name = 'hardened-ubuntu'
    provider.private_networking = true
  end

  config.vm.provision "shell" do |s|
    s.inline = "sudo bash /vagrant/setup.sh"
  end

  config.vm.post_up_message = "
  For instructions, see the documentation on https://github.com/wmhilton/production-ubuntu
  "
end
