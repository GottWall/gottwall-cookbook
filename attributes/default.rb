# -*- coding: utf-8 -*-
#
# Cookbook Name:: gottwall cookbook
#
# :copyright: (c) 2012 - 2013 by Alexandr Lispython (alex@obout.ru).
# :license: BSD, see LICENSE for more details.
# :github: http://github.com/gottwall/gottwall-cookbook
#

default["gottwall"]["user"] = "gottwall"
default["gottwall"]["group"] = "gottwall"
default["gottwall"]["config"] = "/etc/gottwall.conf.py"
default["gottwall"]["virtualenv"] = "/var/www/gottwall"

default["gottwall"]["version"] = "0.3.1"


default["gottwall"]["storage"] = "gottwall.storages.RedisStorage"
default["gottwall"]["backends"]["gottwall.backends.redis.RedisBackend"] = {
  "HOST" => "127.0.0.1",
  "PORT" => 6379,
  "PASSWORD" => "",
  "DB" => 2,
  "CHANNEL" => "gottwall",
  "MAX_LOADING" => 150
}

default["gottwall"]["projects"] = {}
default["gottwall"]["users"] = []
default["gottwall"]["anonymous_login"] = false

default["gottwall"]["storage_settings"] = {
  "HOST" => "127.0.0.1",
  "PORT" => 6379,
  "PASSWORD" => "",
  "DB" => 2
}


default["gottwall"]["servers"] = [{
                                    "name" => "gottwall-web-1",
                                    "host" => "0.0.0.0",
                                    "port" => 8889
                                  }]

default["gottwall"]["aggregators"] = [{
                                        "name" => "gottwall-aggregator",
                                        "host" => "127.0.0.1",
                                        "port" => 8892}
                                     ]

default["gottwall"]["site_title"] = "GottWall"
default["gottwall"]["cookie_secret"] = "cookie_secret"
default["gottwall"]["secret_key"] = "secret_key"

default["gottwall"]["prefix"] = "/gottwall"
default["gottwall"]["log_level"] = "WARNING"


default["gottwall"]["nginx"] = {
  "domain" => "localhost",
  "ip_address" => "0.0.0.0",
  "port" => 80
}
