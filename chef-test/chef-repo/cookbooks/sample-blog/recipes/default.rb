#
# Cookbook Name:: sample-blog
# Recipe:: default
#
# Copyright 2012, Example Com
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#     http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
include_recipe "passenger"

%w{git sqlite-devel mysql mysql-devel}.each do |package_name|
  package package_name do
    action :install
  end
end

directory "/var/MyTips" do
  owner "ec2-user"
  group "ec2-user"
  action :create
end

execute "bundle-install" do
  user "ec2-user"
  group "ec2-user"
  command "cd /var/MyTips/sample-blog/ && bundle install --path vendor/bundle"
end

execute "db-migrate" do
  user "ec2-user"
  group "ec2-user"
  command "cd /var/MyTips/sample-blog/ && rake db:migrate"
end

git "/var/MyTips" do
  repository "git://github.com/mechamogera/MyTips.git"
  user "ec2-user"
  group "ec2-user"
  action :sync
  notifies :run, resources(:execute => "bundle-install" )
  notifies :run, resources(:execute => "db-migrate" )
end

template "/etc/httpd/conf.d/sample-blog.conf" do
  source "sample-blog.conf.erb"
  notifies :restart, "service[httpd]"
end
