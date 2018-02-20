Vagrant.configure("2") do |config|

  ENV["LC_ALL"] = "en_US.UTF-8"

  config.vm.box = "ubuntu/xenial64"
  config.vm.hostname = "tarallo"

  config.vm.synced_folder ".", "/vagrant", disabled: true
  config.vm.synced_folder "./data", "/data"
  config.vm.synced_folder "./tarallo-backend", "/var/www/html/server"
  config.vm.synced_folder "./tarallo-frontend", "/var/www/html/tarallo"

  config.vm.network "forwarded_port", guest: 80, host: 8080, host_ip: "127.0.0.1"
  config.vm.network "forwarded_port", guest: 3306, host: 3306, host_ip: "127.0.0.1"

  config.vm.provider "virtualbox" do |v|
    v.name = "tarallo"
  end

  config.vm.provision "shell", path: "./provision/install.sh"
  config.vm.provision "adminer", type: "shell", path: "./provision/adminer.sh"
  config.vm.provision "db", type: "shell", path: "./provision/db.sh"
  config.vm.provision "db-test", type: "shell", path: "./provision/dbtest.sh"
  config.vm.provision "shell", path: "./provision/deps.sh"

end
