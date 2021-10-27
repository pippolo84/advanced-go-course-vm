Vagrant.configure("2") do |config|
  config.vm.provider "virtualbox" do |v|
    v.cpus = 2
    v.memory = 2048
  end
  config.vm.box = "ubuntu/hirsute64"
  config.vm.synced_folder ".", "/home/vagrant/advanced-go-course"
  config.vm.provision "shell", path: "provision.sh"
end
