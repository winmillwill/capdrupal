Vagrant.configure("2") do |config|
  config.berkshelf.enabled = true
  config.berkshelf.berksfile_path = "./Berksfile"

  config.vm.box = "squeeze"
  config.vm.box_url = "https://s3.amazonaws.com/wa.milton.aws.bucket01/sqeeze.box"

  config.ssh.max_tries      = 40
  config.ssh.timeout        = 120

  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--memory", 2048]
  end

  project = 'drupal'
  config.vm.synced_folder ".", "/var/drupals/#{project}", :nfs => true

  config.vm.network :private_network, ip: "10.73.36.10"
  config.vm.provision :chef_solo do |chef|
    chef.json = {
      :mysql => {
        :server_root_password => 'rootpass',
        :server_debian_password => 'debpass',
        :server_repl_password => 'replpass',
        :tunable => {
          :max_allowed_packet => '256M'
        }
      },
      :drupal => {
        :sites => {
          'drupal.dev' => {
            :root => "/var/drupals/#{project}",
            :doc_root => "/var/drupals/#{project}",
          }
        }
      },
      :apache => {
        :prefork => {
          :startservers => 5,
          :minspareservers => 5,
          :maxspareservers => 5,
          :serverlimit => 10,
          :maxclients => 10
        }
      }
    }

    chef.add_recipe "solo-helper"
    chef.add_recipe "drupal"
    chef.add_recipe "drupal::node_sites"
    chef.add_recipe "drupal::drush"
  end
end
