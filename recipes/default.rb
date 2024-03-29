#
# Cookbook Name:: redis
# Recipe:: default
#
# Copyright 2013, Abine, Inc.
#
# All rights reserved - Do Not Redistribute
#
rightscale_marker :begin

package "build-essential" do
  action :install
end

user node[:redis][:user] do
  action :create
  system true
  shell "/bin/false"
end

directory node[:redis][:dir] do
  owner "root"
  mode "0755"
  action :create
end

directory node[:redis][:data_dir] do
  owner "redis"
  mode "0755"
  action :create
end

directory node[:redis][:log_dir] do
  mode 0755
  owner node[:redis][:user]
  action :create
end

remote_file "#{Chef::Config[:file_cache_path]}/redis.tar.gz" do
  source "http://redis.googlecode.com/files/redis-2.6.13.tar.gz"
  action :create_if_missing
end

bash "compile_redis_source" do
  cwd Chef::Config[:file_cache_path]
  code <<-EOH
    tar zxf redis.tar.gz
    cd redis-2.6.13
    make && make install
  EOH
  creates "/usr/local/bin/redis-server"
end

service "redis" do
  provider Chef::Provider::Service::Upstart
  subscribes :restart, resources(:bash => "compile_redis_source")
  supports :restart => true, :start => true, :stop => true
end

template "redis.conf" do
  path "#{node[:redis][:dir]}/redis.conf"
  source "redis.conf.erb"
  owner "root"
  group "root"
  mode "0644"
  notifies :restart, resources(:service => "redis")
  variables({
    :port => node[:redis][:port],
    :address => node[:redis][:bind],
    :log => node[:redis][:loglevel],
    :data => node[:redis][:data_dir],
    :key => node[:redis][:auth_key],
    :mem => node[:redis][:maxmemory]
  })
end

template "redis.upstart.conf" do
  path "/etc/init/redis.conf"
  source "redis.upstart.conf.erb"
  owner "root"
  group "root"
  mode "0644"
  notifies :restart, resources(:service => "redis")
  variables({
    :user => node[:redis][:user],
    :log => node[:redis][:log_dir]
  })
end

service "redis" do
  action [:enable, :start]
end

rightscale_marker :end
