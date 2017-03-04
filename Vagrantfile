require_relative 'Vagrantfile_functions.rb'


options = get_settings()

draw_intro(options['machine_name'])


# vagrant configurate
Vagrant.configure(2) do |config|

  config.vm.network "forwarded_port", guest: 4200, host: 8080

  # select the box
  config.vm.box = options['box']

  # should we ask about box updates?
  config.vm.box_check_update = options['box_check_update']

  config.vm.provider 'virtualbox' do |vb|
    # machine cpus count
    vb.cpus = options['cpus']
    # machine memory size
    vb.memory = options['memory']
    # machine name (for VirtualBox UI)
    vb.name = options['machine_name']
  end

  # machine name (for vagrant console)
  config.vm.define options['machine_name']

  # machine name (for guest machine console)
  config.vm.hostname = options['machine_name']

  # network settings
  config.vm.network 'private_network', ip: options['ip']

  config.vm.synced_folder "./", "/var/www/", id: "vagrant-root",
                          owner: "www-data",
                          group: "vagrant",
                          mount_options: ["dmode=775", "fmode=775"]
						  

  # disable folder '/vagrant' (guest machine)
  config.vm.synced_folder '.', '/vagrant', disabled: true


  # hosts settings (host machine)
  config.vm.provision :hostmanager
  config.hostmanager.enabled = true
  config.hostmanager.manage_host = true
  config.hostmanager.ignore_private_ip = false
  config.hostmanager.include_offline = true
  config.hostmanager.aliases = options['domains'].values

  config.ssh.shell = "bash -c 'BASH_ENV=/etc/profile exec bash'"

   config.vm.provision 'shell', path: './vagrant/provision/once-as-root.sh', args: [options['timezone']]
   config.vm.provision 'shell', path: './vagrant/provision/once-as-vagrant.sh', privileged: false

  # post-install message (vagrant console)
  config.vm.post_up_message = options['domains']

end
