name             "redis"
maintainer       "Abine, Inc."
maintainer_email "cloud@abine.com"
license          "All rights reserved"
description      "Installs/Configures Redis"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.0.1"

depends "rightscale"

recipe "redis::default", "Set up the Redis server"

attribute 'redis/loglevel',
          :display_name => "Redis LogLevel",
          :description => "How much to log",
          :default => 'notice',
          :required => 'optional',
          :recipes => ['redis::default']

attribute 'redis/port',
          :display_name => "Redis Port",
          :description => "What port redis listens on for connections",
          :default => '6379',
          :required => 'optional',
          :recipes => ['redis::default']

attribute 'redis/bind',
          :display_name => "Redis Bind",
          :description => "What address to bind to",
          :default => '0.0.0.0',
          :required => 'optional',
          :recipes => ['redis::default']

attribute 'redis/maxmemory',
          :display_name => "Redis Max Memory",
          :description => "Maximum amount of memory redis can use",
          :default => '16428249907',
          :required => 'recommended',
          :recipes => ['redis::default']

attribute 'redis/auth_key',
          :display_name => "Redis AUTH Key",
          :description => "Key used to AUTH with redis server",
          :required => 'required',
          :recipes => ['redis::default']
