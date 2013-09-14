vagrant-riak-cluster
====================

Vagrant setup for creating a centos6 riak cluster. This vagrant
will let you create a riak cluster of N nodes that will automatically
be joined together.

For this to work you'll need a CentOS 6 base box added
to your Vagrant install with the name `centos6`, i.e.:

    $ vagrant box list
    centos6
    lucid32
    ...

You can grab pre-existing CentOS 6 base boxes of the internet, or roll
your own using [veewee](https://github.com/jedi4ever/veewee/).

Make sure to grab one with Puppet installed, or install it yourself and then do a vagrant reload.
The following will download a puppet enabled CentOS6 base bosx:

    $ vagrant box add centos6 http://developer.nrel.gov/downloads/vagrant-boxes/CentOS-6.4-x86_64-v20130427.box

choosing the size of your cluster
=================================

By default running `vagrant up` will create a riak cluster
with 3 nodes. To change this edit the first line of code in
the `Vagrantfile`. It looks like:

    num_nodes = 3

choosing your storage backend
=============================

Riak supports several different [storage backends](http://docs.basho.com/riak/latest/ops/building/planning/backends/). To be able to use Riak 2i the eLevelDB must be selected as your backend,
so that is what the default value is set to in the `Vagrantfile`. To select
a different one just change the following line in the `Vagrantfile`:

    riak_backend = "eleveldb"

All of the available options are listed in the comment above that line,
and of course can be found in the link provided.

riak control
===========================

Riak control has been enabled without security or ssl. You should not use riak control in production without ssl or authentication security enabled.

You can access the riak-control console by visiting http://33.33.33.10:8098/admin
