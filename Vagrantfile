#!/usr/bin/env ruby
# vim: set ft=ruby :
# vim: set syntax=ruby :

num_nodes = 5

# TODO Allow users to pass in the number of nodes
#      they want to create from the command line:
#
#   $ vagrant up --nodes 3
#
#if ARGV[0] == "up" && ARGV[1] && ARGV[1].to_i > 0
#   num_nodes = ARGV[1].to_i
#end

ip_inc   = 10
base_ip  = "33.33.33."
join_ip  = "#{base_ip}#{ip_inc}"

riak_nodes = Hash.new
for i in 1..num_nodes
  name = "riak#{i}"
  ip = i * ip_inc
  riak_nodes[":#{name}"] = {
    :hostname => name,
    :ip_addr  => "#{base_ip}#{ip}",
  }
end

Vagrant::Config.run do |global_config|

  riak_nodes.each_pair do |key, options|

    ip_addr   = options[:ip_addr]
    hostname  = options[:hostname]
    prov_args = {
      :module_path => "puppet",
      :facter => {
        "ip_addr"  => ip_addr,
        "join_ip"  => join_ip,
      }
    }

    global_config.vm.define hostname do |node_config|
      node_config.vm.box       = "centos6"
      node_config.vm.boot_mode = :headless
      node_config.vm.host_name = hostname
      node_config.vm.network :hostonly, ip_addr

      node_config.vm.provision :puppet, prov_args do |puppet|
        puppet.manifests_path = "puppet"
        puppet.manifest_file  = "init.pp"
      end
    end
  end
end
