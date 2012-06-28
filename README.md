vagrant-riak-cluster
====================

Vagrant setup for firing up a centos6 riak cluster.

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
with 5 nodes. To change this edit the first line in the
`Vagrantfile`. It looks like:

    num_nodes = 5

Eventually I'm going to make it so you can pass that value
in on the command line, ala:

    $ vagrant up --nodes N

but for now you'll just have to edit the `Vagrantfile`.
