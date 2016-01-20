VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # My apologies for putting config into a shell script.
  File.foreach( 'config.sh' ) do |line|
    key, val = line.split('=')
    config.vm.hostname = val if key == "HOSTNAME"
  end

  config.vm.box = "ubuntu/trusty64"
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

  config.vm.provision "os", type: "shell" do |s|
    s.inline = "/vagrant/setup.sh"
  end

  config.vm.provision "app", type: "shell" do |s|
    s.inline = "GITHUB_TOKEN=#{ENV['GITHUB_TOKEN']} GITHUB_REF=#{ENV['GITHUB_REF']} /vagrant/private/install.sh"
  end

  config.vm.post_up_message = "
  If you are lucky, I might have some documentation on https://github.com/wmhilton/production-ubuntu.
  No promises though.
  "
end
