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

Make sure to grab one with Puppet installed, or install it yourself and then
do a vagrant reload. The following will download a puppet enabled CentOS6
base box:

    $ vagrant box add centos6 http://developer.nrel.gov/downloads/vagrant-boxes/CentOS-6.4-x86_64-v20130427.box

Creating your Riak cluster
==========================

    $ vagrant up

Sometimes things fail, especially if you're firing off vagrant commands as the
cluster is being created. If it fails out just do the following:

    $ vagrant destroy -f
    $ vagrant up

After your cluster is created SSH into one of the boxes and make sure all your
nodes are connected:

    $ vagrant ssh riak1
    Welcome to your Vagrant-built virtual machine.
    [vagrant@riak1 ~]$ riak-nodes
     - riak@33.33.33.10
     - riak@33.33.33.20
     - riak@33.33.33.30

The riak-nodes command does not ship with Riak. It's just a little perl script
this vagrant module installs to let you see all the nodes that are connected.

Test Driving Riak
=================

First let's test that we can talk to riak. From your host machine run this
curl command:

    $ curl http://33.33.33.10:8098/riak/test

And you should see JSON output like:

    {"props":{"name":"test","allow_mult":false,"basic_quorum":false,"big_vclock":50,"chash_keyfun":{"mod":"riak_core_util","fun":"chash_std_keyfun"},"dw":"quorum","last_write_wins":false,"linkfun":{"mod":"riak_kv_wm_link_walker","fun":"mapreduce_linkfun"},"n_val":3,"notfound_ok":true,"old_vclock":86400,"postcommit":[],"pr":0,"precommit":[],"pw":0,"r":"quorum","rw":"quorum","small_vclock":50,"w":"quorum","young_vclock":20}}

Excellent. Now lets add and retrieve some data from Riak. Save the image
below as 1.jpg and do the following:

    $ curl -XPUT http://33.33.33.10:8098/riak/images/1.jpg -H "Content-type: image/jpeg" --data-binary @1.jpg

Now go to http://33.33.33.10:8098/riak/images/1.jpg in your browser and you
should see your image.

![Alt text](files/1.jpg)

Changing the size of your cluster
=================================

By default running `vagrant up` will create a riak cluster
with 3 nodes. To change this edit the first line of code in
the `Vagrantfile`. It looks like:

    num_nodes = 3

Changing your storage backend
=============================

Riak supports several different [storage backends](http://docs.basho.com/riak/latest/ops/building/planning/backends/). To be able to use Riak 2i the eLevelDB must be selected as your backend,
so that is what the default value is set to in the `Vagrantfile`. To select
a different one just change the following line in the `Vagrantfile`:

    riak_backend = "eleveldb"

All of the available options are listed in the comment above that line,
and of course can be found in the link provided.

Riak Control
============

Riak control has been enabled without security or ssl. You should not use riak control in production without ssl or authentication security enabled.

You can access the riak-control console by visiting http://33.33.33.10:8098/admin
