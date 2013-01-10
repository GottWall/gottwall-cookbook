Description
===========

Cookbook for setup and configure [gottwall](http://github.com/gottwall/gottwall) application.

Requirements
============

[python](https://github.com/opscode-cookbooks/python)

Attributes
==========

The gottwall.conf.py file are dynamically generated from attributes.

All default values of attributes you can see in `attributes/default.rb`


Usage
=====
If you want to user gottwall include recipe[gottwall] to you runlist.

Replace you own `node['gottwall']['secret_key']` random key.
Add sites for monitoring `node['gottwall']['projects'] = [{"projectname" => "secret_key"}]

We recommend change temporary passwords after from web interface.

To configure database override `node['gottwall']['backends']['gottwall.backends.redis.RedisBackend']` keys:

     "backends" => {
        ""gottwall.backends.redis.RedisBackend"" => {
          "HOST" => "0.0.0.0",
	  "PORT" => 4343
        },
     }


Definitions
===========

You can create config for gottwall need use definition ``gottwall_conf``:

    gottwall_conf "gottwall" do
        user "gottwall"
        group "gottwall"
	virtualenv node["gottwall"]["virtualenv"]
	# Settings file variables hash
	settings {}
    end

Resources
=========

gottwall_instance
-----------------

To run gottwall instance you can user ``gottwall_instance`` resouce

Attribute parameters
^^^^^^^^^^^^^^^^^^^^

- ``name`` instance name
- ``group`` launch by group
- ``user`` launch by user
- ``virtualenv``: path to virtualenv
- ``config``: path to config file
- ``pidfile``: path to instance pidfile
- ``host``: host for binding
- ``port``: port for binging
- ``workers``: number of workers
- ``provider``: instance porvider (default: Chef::Provider::GottwallBase)

Providers
---------

gottwall cookbook support 3 instance providers:

- Chef::Provider::GottwallBase - simple provider, that create init.d script and spawn instance
- Chef::Provider::GottwallRunit - provider, that spawn instance via ``runit``
- Chef::Provider::GottWallSupervisor - provider, that spawn instance via ``supervisord``



Recipes
=======

default
-------

Base recipe to configure gottwall user and group

instance
--------

Recipe to install simple gottwall instance.


See also
========

- [Statistics aggregation](https://github.com/gottwall/)