# -*- coding: utf-8 -*-
#
# Cookbook Name:: gottwall cookbook
# Definition:: gottwall_conf
#
# Making gottwall configuration file
#
# :copyright: (c) 2012 - 2013 by Alexandr Lispython (alex@obout.ru).
# :license: BSD, see LICENSE for more details.
# :github: http://github.com/Lispython/gottwall-cookbook
#

class Chef::Recipe
  include Chef::Mixin::DeepMerge
end

define :gottwall_conf, :name => nil, :template => "config.py.erb",
:virtualenv_dir => nil,
:user => "gottwall", :group => "group",
:config => nil,
:superusers => [],
:variables => {},
:settings => {} do

  Chef::Log.info("Making gottwall config for: #{params[:name]}")
  include_recipe "gottwall::default"

  virtualenv_dir = params[:virtualenv_dir] or node["gottwall"]["virtulenv"]

  #settings_variables = Chef::Mixin::DeepMerge.deep_merge!(node[:gottwall][:settings], params[:settings].to_hash)

  settings_variables = params[:settings]
  config = params[:config] || node["gottwall"]["config"]
  settings_variables["config"] = config

  # Making application virtualenv directory
  directory virtualenv_dir do
    owner params[:user]
    group params[:group]
    mode 0777
    recursive true
    action :create
  end

  # Creating virtualenv structure
  python_virtualenv virtualenv_dir do
    owner params[:user]
    group params[:group]
    action :create
  end

  # Creating gottwall config
  template config do
    owner params[:user]
    group params[:group]
    source params[:template]
    mode 0777
    variables(settings_variables.to_hash)
  end

  # Intstall gottwall via pip
  python_pip "gottwall" do
    provider Chef::Provider::PythonPip
    user params[:user]
    group params[:group]
    virtualenv virtualenv_dir
    version node["gottwall"]["version"]
    action :install
  end

  bash "chown virtualenv" do
    code <<-EOH
  chown -R #{params['user']}:#{params['group']} #{virtualenv_dir}
  EOH
  end

end
