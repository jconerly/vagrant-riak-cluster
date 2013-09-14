#!/usr/bin/env ruby
# vim: set ft=ruby :
# vim: set syntax=ruby :

#--- BEGIN config vars ---#

# Select the number of riak nodes in the cluster.

num_nodes = 3

# Select the name of the box you prefer.
#
# This will only work with CentOS 6 base boxes, but if the name you used when
# you added the box is different from 'centos6' then change this value.

base_box = "centos6"

# Base IP value.
#
# Change it if you need.

base_ip = "33.33.33."

# Select the storage backend you want for Riak. To take advantage of 2i we
# must use eLevelDB. Valid options are:
#
#   bitcask
#   eleveldb
#   memory
#   multi

riak_backend = "eleveldb"

# IP addresses can't start at one (i.e X.X.X.1) or complaints will come
# your way. This is the IP increment for the ip4 value.

ip_inc = 10

#--- END config vars ---#

Vagrant::Config.run do |cluster|

  (1..num_nodes).each do |index|

    ip4       = index * ip_inc
    ip_addr   = "#{base_ip}#{ip4}"
    hostname  = "riak#{index}"
    prov_args = {
      :facter => {
        "ip_addr"      => ip_addr,
        "join_ip"      => "#{base_ip}#{ip_inc}",
        "riak_backend" => riak_backend,
      }
    }

    cluster.vm.define hostname do |node|
      node.vm.box       = base_box
      node.vm.host_name = hostname
      node.vm.boot_mode = :headless

      node.vm.network   :hostonly, ip_addr
      node.vm.provision :puppet, prov_args do |puppet|
        puppet.manifests_path = "puppet"
        puppet.module_path    = "puppet"
        puppet.manifest_file  = "init.pp"
      end
    end
  end
end
