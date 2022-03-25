IDE_CONTROLLER = 'IDE'
IMAGE = "centos/stream8"
LVM_DISK_SIZE = 100 * 1024
SIZE = '100GB'
FILE_TO_DISK = 'lvm_disk.vdi'
DEPLOYMENT_HOST_NAME = "DeploymentHost"
DEPLOYMENT_HOST_IP = 9
MEM_HOST = 512
CPU_HOST = 1
HOST_IP = "192.168.56."
BR_MGMT_IP = "172.29.236."

nodes = {
  'ControllerNode' => [1, 10,  7000, 2],
  'ComputeNode'    => [1, 20, 4000, 2],
  'StorageNode'    => [1, 30, 512, 1]
}

hostnames = [ DEPLOYMENT_HOST_NAME ]

Vagrant.configure("2") do |config|

  unless Vagrant.has_plugin?("vagrant-disksize")
    raise 'Please install vagrant-disksize using the command: vagrant plugin install vagrant-disksize'
  end

  config.vm.box = IMAGE
  config.vm.provider "virtualbox" do |vb|
    vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    vb.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
	vb.customize ["modifyvm", :id, "--audio", "none"]
  end

  File.write('playbooks/hosts.ini', '')
  File.write('hosts', '')
  File.write('playbooks/hosts.ini', "[local]#{$/}", mode: 'a')
  File.write('playbooks/hosts.ini', "localhost#{$/}", mode: 'a')
  File.write('playbooks/hosts.ini', "[AllNodes:children]#{$/}", mode: 'a')
  nodes.each do |name, (count, ip, mem, vcpu)|
    File.write('playbooks/hosts.ini', "#{name}#{$/}", mode: 'a')
  end

  nodes.each do |name, (count, ip, mem, vcpu)|

    File.write('playbooks/hosts.ini', "[#{name}]#{$/}", mode: 'a')

    count.times do |i|

      hostname = "%s-%02d" % [name, (i+1)]
      hostnames.push(hostname)
      File.write('playbooks/hosts.ini', "#{hostname} ansible_host=#{HOST_IP}#{ip+i}#{$/}", mode: 'a')
      File.write('hosts', "#{HOST_IP}#{ip+i} #{hostname}#{$/}", mode: 'a')

      config.vm.define "#{hostname}" do |node|
        
        node.vm.hostname = "#{hostname}"

        node.vm.provider "virtualbox" do |v|
          v.name = "#{hostname}"
          v.memory = mem
          v.cpus = vcpu
        end

        node.vm.network :private_network, ip: "#{HOST_IP}#{ip+i}", :netmask => "255.255.255.0"
        node.vm.network :private_network, ip: "#{BR_MGMT_IP}#{ip+i}", :netmask => "255.255.252.0"
        node.vm.provision "shell", privileged: true, path: "scripts/common_installation.sh"

        if name == "ControllerNode"
          node.disksize.size = SIZE
          node.vm.provision "shell", privileged: true, reboot: true, path: "scripts/controller_installation.sh"
        elsif name == "ComputeNode"
          node.vm.provision "shell", privileged: true, reboot: true, path: "scripts/compute_installation.sh"
        elsif name == "StorageNode"
          node.vm.provider "virtualbox" do |v|
            unless File.exist?(FILE_TO_DISK)
              v.customize ['createhd', '--filename', FILE_TO_DISK, '--size', LVM_DISK_SIZE]
            end
            v.customize ['storageattach', :id, '--storagectl', IDE_CONTROLLER, '--port', 1, '--device', 0, '--type', 'hdd', '--medium', FILE_TO_DISK]
          end
          node.vm.provision "shell", privileged: true, reboot: true, path: "scripts/storage_installation.sh"
        end

      end

    end

  end

  config.vm.define DEPLOYMENT_HOST_NAME do |client|

    client.vm.provider "virtualbox" do |vb|
      vb.memory = MEM_HOST
      vb.cpus = CPU_HOST
    end

    client.vm.hostname = DEPLOYMENT_HOST_NAME
    client.vm.network :private_network, ip: "#{HOST_IP}#{DEPLOYMENT_HOST_IP}", :netmask => "255.255.255.0"
    client.vm.network :private_network, ip: "#{BR_MGMT_IP}#{DEPLOYMENT_HOST_IP}", :netmask => "255.255.252.0"

    client.vm.provider "virtualbox" do |v|
      v.name = DEPLOYMENT_HOST_NAME
    end

    client.vm.provision "shell", privileged: true, reboot: true, path: "scripts/deployment_host_installation.sh"

    ##
    ## publish ssh public key to all nodes
    ##
	client.vm.provision :ansible_local do |ansible|
	  ansible.compatibility_mode = "2.0"
	  ansible.install = false
	  ansible.provisioning_path = "/vagrant/playbooks"
	  ansible.limit = "all"
	  ansible.playbook = "authorize_ssh_key.yml"
	  ansible.inventory_path = "hosts.ini"
	  ansible.extra_vars = { ansible_user: "vagrant", ansible_ssh_pass: "vagrant" }
	  ansible.become = true
	end

    ##
    ## run playbook: Install OpenStack
    ##
	client.vm.provision :ansible_local do |ansible|
	  ansible.compatibility_mode = "2.0"
	  ansible.install = false
	  ansible.provisioning_path = "/vagrant/playbooks"
	  ansible.limit = "all"
	  ansible.playbook = "install_openstack.yml"
	  ansible.inventory_path = "hosts.ini"
	  ansible.become = true
	end

  end

end
