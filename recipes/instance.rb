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
include_recipe "gottwall::user"

# Create gottwall instance virtualenv and config
gottwall_conf node["gottwall"]["config"] do
  virtualenv_dir node["gottwall"]["virtualenv"]
  user node["gottwall"]["user"]
  group node["gottwall"]["group"]
  settings node["gottwall"]
  version node["gottwall"]["version"]
end


# Run gottwall web instance
node["gottwall"]["servers"].each do |server|
  gottwall_web server['name'] do
    template_name "gottwall"
    virtualenv node["gottwall"]["virtualenv"]
    user node["gottwall"]["user"]
    group node["gottwall"]["group"]
    pidfile "/var/run/#{server['name']}.pid"
    config node["gottwall"]["config"]
    port server["port"]
    host server["host"]
    provider Chef::Provider::GottwallRunit
  end
end

node["gottwall"]["aggregators"].each do |aggregator|

  # Run gottwall aggregator instances
  gottwall_aggregator aggregator[:name] do
    template_name "gottwall-aggregator"
    virtualenv node["gottwall"]["virtualenv"]
    user node["gottwall"]["user"]
    group node["gottwall"]["group"]
    pidfile "/var/run/#{aggregator['name']}.pid"
    config node["gottwall"]["config"]
    port aggregator["port"]
    host aggregator["host"]

    provider Chef::Provider::GottwallRunit
  end
end
