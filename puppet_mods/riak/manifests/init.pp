# Puppet class for riak

class riak {
  exec { "install_riak":
    command => "rpm -Uvh /vagrant/files/${riak_rpm}",
    path => "/bin",
  }

  file { "app.config":
    path => "/etc/riak/app.config",
    ensure => file,
    owner => "root",
    group => "root",
    mode => "0644",
    content => template("riak/app.config.erb"),
    require => Package["riak"],
  }

  file { "vm.args":
    path => "/etc/riak/vm.args",
    ensure => file,
    owner => "root",
    group => "root",
    mode => "0644",
    content => template("riak/vm.args.erb"),
    require => Package["riak"],
  }

  package { "riak":
    ensure => present,
    require => Exec["install_riak"],
  }

  exec { "flush_iptables":
    command => "iptables -F",
    path => "/sbin",
  }

  service { "riak":
    ensure => running,
    require => [
      Exec["flush_iptables"], Package["riak"],
      File["app.config"], File["vm.args"]
    ],
  }

  if $ip_addr != $join_ip {
    exec { "join_riak":
      command => "sudo -u riak riak-admin join riak@${join_ip}",
      path => "/usr/bin:/usr/sbin",
      require => Service["riak"],
    }
  }
}

include riak
