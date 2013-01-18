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

group node["gottwall"]["group"] do
  action :create
  system true
  not_if "grep #{node['gottwall']['group']} /etc/group"
end

user node["gottwall"]["user"] do
  comment "gottwall service user"
  gid node["gottwall"]["group"]
  system true
  shell "/bin/bash"
  action :create
  not_if "grep #{node['gottwall']['user']} /etc/passwd"
end

# Create gottwall instance virtualenv and config
gottwall_conf node["gottwall"]["config"] do
  virtualenv_dir node["gottwall"]["virtualenv"]
  user node["gottwall"]["user"]
  group node["gottwall"]["group"]
  settings node["gottwall"]
end


# Run gottwall web instance
gottwall_web "gottwall" do
  virtualenv node["gottwall"]["virtualenv"]
  user node["gottwall"]["user"]
  group node["gottwall"]["group"]
  pidfile "/var/run/gottwall-1.pid"
  config node["gottwall"]["config"]
  provider Chef::Provider::GottwallRunit
end

node["gottwall"]["aggregators"].each do |aggregator|

  # Run gottwall aggregator instances
  gottwall_aggregator "gottwall-aggregator-1" do
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
