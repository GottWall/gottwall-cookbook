# -*- coding: utf-8 -*-
#
# Cookbook Name:: sentry cookbook
# Recipe:: default
#
# :copyright: (c) 2012 - 2013 by Alexandr Lispython (alex@obout.ru).
# :license: BSD, see LICENSE for more details.
# :github: http://github.com/Lispython/gottwall-cookbook
#

include_recipe "gottwall::default"

Chef::Log.info("Making nginx frontend for gottwall service")


template "#{node[:nginx][:dir]}/sites-available/gottwall.conf" do
  source 'nginx.conf.erb'
  owner user
  group user

  notifies :reload, resources(:service => "nginx")
end

nginx_site "gottwall.conf"
