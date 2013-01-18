# -*- coding: utf-8 -*-
#
# Cookbook Name:: gottwall cookbook
# Recipe:: default

# Aggregator instance launcher
#
# :copyright: (c) 2012 - 2013 by Alexandr Lispython (alex@obout.ru).
# :license: BSD, see LICENSE for more details.
# :github: http://github.com/gottwall/gottwall-cookbook
#

actions :init

attribute :name, :kind_of => String, :name_attribute => true
attribute :user, :kind_of => String
attribute :group, :kind_of => String
attribute :virtualenv, :kind_of => String
attribute :pidfile, :kind_of => String
attribute :variables, :kind_of => Hash
attribute :config, :kind_of => String
attribute :host, :kind_of => String, :default => "0.0.0.0"
attribute :port, :kind_of => Integer, :default => 9001
attribute :workers, :kind_of => Integer, :default => 3
attribute :template_name, :kind_of => String, :default => "gottwall"
attribute :log_level, :kind_of => String, :default => "warning"


def initialize(*args)
  super
  @action = :init
  @sub_resources = []
  @provider = Chef::Provider::GottwallBase
end
