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

%w{git}.each do |package_name|
  package package_name do
    action :install
  end
end

git "/var/MyTips" do
  repository "git://github.com/mechamogera/MyTips.git"
  action :sync
  user "ec2-user"
  group "ec2-user"
end

template "/etc/httpd/conf.d/sample-blog.conf" do
  source "sample-blog.conf.erb"
end
