# -*- coding: utf-8 -*-
#
# Cookbook Name:: gottwall cookbook
# Recipe:: default
#
# :copyright: (c) 2012 - 2013 by Alexandr Lispython (alex@obout.ru).
# :license: BSD, see LICENSE for more details.
# :github: http://github.com/GottWall/gottwall-cookbook
#

include_recipe "gottwall::default"

# Create gottwall instance virtualenv and config
gottwall_conf "gottwall" do
  virtualenv_dir node["gottwall"]["virtualenv"]
  user node["gottwall"]["user"]
  group node["gottwall"]["group"]
  settings node["gottwall"]
end


# Running gottwall instance
gottwall_instance "gottwall" do
  virtualenv node["gottwall"]["virtualenv"]
  user node["gottwall"]["user"]
  group node["gottwall"]["group"]
  pidfile "/var/run/gottwall-1.pid"
  config node["gottwall"]["config"]
end
