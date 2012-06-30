vagrant-riak-cluster
====================

Vagrant setup for creating a centos6 riak cluster.

For this to work you'll need a CentOS 6 base box added
to your Vagrant install with the name `centos6`, i.e.:

    $ vagrant box list
    centos6
    lucid32
    ...

You can grab pre-existing CentOS 6 base boxes of the
internet, or roll your own using [veewee](https://github.com/jedi4ever/veewee/).

choosing the size of your cluster
=================================

By default running `'vagrant up'` will create a riak cluster
with 5 nodes. To change this edit the first line of code in
the `Vagrantfile`. It looks like:

    num_nodes = 5

Eventually I'm going to make it so you can pass that value
in on the command line, ala:

    $ vagrant up --nodes N

but for now you'll just have to edit the `Vagrantfile`.

choosing your storage backend
=============================

Riak supports several different [storage backends](http://wiki.basho.com/Storage-Backends.html).
To be able to use Riak 2i the eLevelDB must be selected as your backend,
so that is what the default value is set to in the `Vagrantfile`. To select
a different one just change the following line in the `Vagrantfile`:

    riak_backend = "eleveldb"

All of the available options are listed in the comment above that line,
and of course can be found in the link provided.
