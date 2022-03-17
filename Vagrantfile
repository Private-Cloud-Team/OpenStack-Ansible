IMAGE = "centos/stream8"
MEM = 2048
CPU = 2
DEPLOYMENT_HOST_NAME = "DeploymentHost"
DEPLOYMENT_HOST_IP = 9
BR_MGMT_IP = "192.168.56."

nodes = {
  'ControllerNode' => [1, 10],
  #'ComputeNode' => [1, 100],
  #'StorageNode' => [1, 200]
}

hostnames = [ DEPLOYMENT_HOST_NAME ]

Vagrant.configure("2") do |config|

  unless Vagrant.has_plugin?("vagrant-scp")
    raise 'Please install vagrant-scp using the command: vagrant plugin install vagrant-scp'
  end

  config.vm.box = IMAGE
  config.vm.provider "virtualbox" do |vb|
    vb.memory = MEM
    vb.cpus = CPU
    vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    vb.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
  end

  File.write('playbooks/hosts.ini', '')
  File.write('hosts', '')
  nodes.each do |name, (count, ip)|
    File.write('playbooks/hosts.ini', "[#{name}]#{$/}", mode: 'a')
    count.times do |i|
      hostname = "%s-%02d" % [name, (i+1)]
      hostnames.push(hostname)
      File.write('playbooks/hosts.ini', "#{hostname} ansible_host=#{BR_MGMT_IP}#{ip+i}#{$/}", mode: 'a')
      File.write('hosts', "#{BR_MGMT_IP}#{ip+i} #{hostname}#{$/}", mode: 'a')
      config.vm.define "#{hostname}" do |node|
        node.vm.hostname = "#{hostname}"
        node.vm.network :private_network, ip: "#{BR_MGMT_IP}#{ip+i}", :netmask => "255.255.255.0"
        node.vm.provider "virtualbox" do |v|
          v.name = "#{hostname}"
        end
        node.vm.provision "shell", privileged: true, reboot: true, path: "scripts/target_host_installation.sh"
      end
    end
  end

  config.vm.define DEPLOYMENT_HOST_NAME do |client|
    client.vm.hostname = DEPLOYMENT_HOST_NAME
    client.vm.network :private_network, ip: "#{BR_MGMT_IP}#{DEPLOYMENT_HOST_IP}", :netmask => "255.255.255.0"
    client.vm.provider "virtualbox" do |v|
      v.name = DEPLOYMENT_HOST_NAME
    end
    client.vm.provision "shell", privileged: true, reboot: true, path: "scripts/deployment_host_installation.sh"
    client.trigger.after :up do |t|
      t.info = "Uploading SSH Public Key To Target Hosts"
      t.run = { inline: "bash scripts/authorize_ssh_key.sh #{hostnames.join(' ')}" }
    end
    client.trigger.after :up do |t|
      t.info = "Running Ansible Playbook"
      t.run_remote = { inline: "bash /vagrant/scripts/run_playbook.sh" }
    end
  end

end
