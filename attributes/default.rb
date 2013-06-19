#
# Cookbook Name:: redis
#
# Copyright 2013, Abine, Inc.
#
# All rights reserved - Do Not Redistribute
#

default[:redis][:dir]       = "/etc/redis"
default[:redis][:data_dir]  = "/var/lib/redis"
default[:redis][:log_dir]   = "/var/log/redis"
default[:redis][:loglevel]  = "notice"
default[:redis][:user]      = "redis"
default[:redis][:port]      = "6379"
default[:redis][:bind]      = "0.0.0.0"
default[:redis][:maxmemory] = "16428249907"
default[:redis][:auth_key]  = "1the_5early_4bird_3catches_2the_1worm"
