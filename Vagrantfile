IMAGE = "centos/stream8"
MEM = 1024
CPU = 1
CONTROLLER_NAME = "ControllerNode"
COMPUTE_NAME = "ComputeNode"
DEPLOYMENT_CLIENT_NAME = "DeploymentClientNode"
CONTROLLER_IP = "192.168.42.110"
COMPUTE_IP = "192.168.42.111"
DEPLOYMENT_CLIENT_IP = "192.168.42.112"

Vagrant.configure("2") do |config|

	config.vm.box = IMAGE
	config.vm.provider "virtualbox" do |vb|
		vb.memory = MEM
		vb.cpus = CPU
		vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
		vb.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
	end
	config.vm.provision "shell", privileged: true, path: "scripts/common_installation.sh"

	config.vm.define CONTROLLER_NAME do |controller|
		controller.vm.hostname = CONTROLLER_NAME
		controller.vm.network :private_network, ip: CONTROLLER_IP
		controller.vm.provider "virtualbox" do |v|
			v.name = CONTROLLER_NAME
		end
	end

	config.vm.define COMPUTE_NAME do |compute|
		compute.vm.hostname = COMPUTE_NAME
		compute.vm.network :private_network, ip: COMPUTE_IP 
		compute.vm.provider "virtualbox" do |v|
			v.name = COMPUTE_NAME
		end
	end

	config.vm.define DEPLOYMENT_CLIENT_NAME do |client|
		client.vm.hostname = DEPLOYMENT_CLIENT_NAME
		client.vm.network :private_network, ip: DEPLOYMENT_CLIENT_IP 
		client.vm.provider "virtualbox" do |v|
			v.name = DEPLOYMENT_CLIENT_NAME
		end
	end

end
