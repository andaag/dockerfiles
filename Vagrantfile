ip        = ENV.fetch("DOCKER_IP", "192.168.42.43")
port      = ENV.fetch("DOCKER_PORT", "2735")
memory    = ENV.fetch("DOCKER_MEMORY", "1024")
cpus      = ENV.fetch("DOCKER_CPUS", "1")
args      = ENV.fetch("DOCKER_ARGS", "")
synced_folder = '/Users'

unless args.empty?
  args = "EXTRA_ARGS=#{args}"
end

Vagrant.configure("2") do |config|
  config.vm.box = "dduportal/boot2docker"
  config.vm.network "private_network", :ip => ip
  config.vm.synced_folder synced_folder, synced_folder, :create => true

  config.vm.provider :virtualbox do |v, override|
    v.customize ["modifyvm", :id, "--nictype1", "virtio"]
    v.customize ["modifyvm", :id, "--nictype2", "virtio"]
    v.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
    v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    v.customize ["modifyvm", :id, "--memory", Integer(memory)]
    v.customize ["modifyvm", :id, "--cpus", Integer(cpus)]
  end

  config.vm.provision :shell,
    path: "configure_docker.sh",
    args: [port, args]

  config.vm.provision :file,
    source: "sklearn-notebook",
    destination: "/tmp"

  config.vm.provision :docker,
    images: ["andaag/sklearn-notebook3", "andaag/large-notebook3" ]
end
