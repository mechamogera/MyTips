#
# Cookbook Name:: passenger
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

%w{httpd httpd-devel curl-devel}.each do |package_name|
  package package_name do
    action :install
  end
end

gem_package "passenger" do
  action :install
end

execute "passenger_module" do
  not_if do
    result = `passenger-install-apache2-module --snippet`
    File.exist?(result.split("\n")[0].split(/\s+/,3)[2])
  end
  command 'passenger-install-apache2-module --auto'
end

template "/etc/httpd/conf.d/passenger_load.conf" do
  source "passenger_load.conf.erb"
  proc = Proc.new { `passenger-install-apache2-module --snippet` }
  variables :snippet => proc.call
end
