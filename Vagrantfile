Vagrant.configure("2") do |config|

  ENV["LC_ALL"] = "en_US.UTF-8"

  config.vm.box = "centos/7"
  config.vm.hostname = "tarallo"

  config.vm.synced_folder ".", "/vagrant", disabled: true
  config.vm.synced_folder "./data", "/data"
  config.vm.synced_folder "./tarallo-backend", "/var/www/html/server"

  config.vm.network "forwarded_port", guest: 80, host: 8080, host_ip: "127.0.0.1"
  config.vm.network "forwarded_port", guest: 81, host: 8081, host_ip: "127.0.0.1"
  config.vm.network "forwarded_port", guest: 3306, host: 3307, host_ip: "127.0.0.1"

  config.vm.provider "virtualbox" do |v|
    v.name = "tarallo"
  end

  config.vm.provision "ansible" do |ansible|
	  ansible.verbose = "v"
	  ansible.compatibility_mode = "2.0"
	  ansible.playbook = "provision/playbook.yml"
  end

  #config.vm.provision "shell", path: "./provision/install.sh"
  #config.vm.provision "nginx", type: "shell", path: "./provision/nginx.sh"
  #config.vm.provision "adminer", type: "shell", path: "./provision/adminer.sh"
  #config.vm.provision "db", type: "shell", path: "./provision/db.sh"
  #config.vm.provision "db-test", type: "shell", path: "./provision/dbtest.sh"
  #config.vm.provision "db-procedures", type: "shell", path: "./provision/dbproc.sh"
  #config.vm.provision "deps", type: "shell", path: "./provision/deps.sh"

end
