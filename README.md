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

Replace you own `node['gottwall']['key']` random key.

For create new superusers you need overrider `node['gottwall']['superusers']` attribute:

    "superusers" => [{
                     "username" => "alex",
                     "password" => "tmppassword",
                     "email" => "alex@obout.ru"}]

We recommend change temporary passwords after from web interface.

To configure database override `node['gottwall']['databases']['default']` keys:

     "databases" => {
        "default" => {
          "NAME" => "/var/www/gottwall/gottwall.db"
        },
     }


Definitions
===========

You can create many gottwall instances or instance with node specified attributes via definition usage:

    gottwall_instance "gottwall-1" do
        user "gottwall"
        group "gottwall"
	variables {}
    end


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