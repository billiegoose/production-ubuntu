

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "ubuntu/trusty64"
  config.vm.hostname = "server1"
  config.vm.network :private_network, ip: "192.168.0.10"

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
    provider.region = "nyc3"
    provider.size = '512mb'
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
