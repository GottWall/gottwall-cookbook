# -*- coding: utf-8 -*-
#
# Cookbook Name:: sentry cookbook
# Recipe:: user
#
# :copyright: (c) 2012 - 2013 by Alexandr Lispython (alex@obout.ru).
# :license: BSD, see LICENSE for more details.
# :github: http://github.com/Lispython/sentry-cookbook
#



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
