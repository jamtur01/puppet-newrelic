#
# Author:: Jomes Turnbull <james@puppetlabs.com>
#
# Copyright 2012, Puppet Labs
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

require 'newrelic_api' if Puppet.features.newrelic?

Puppet::Type.type(:newrelic_notify).provide(:newrelic_notify) do

  desc "Send New Relic deploymnet notifications."

  confine :true => Puppet.features.newrelic?

  def create
    return true
  end

  def exists?
    begin
      notify(resource)
    rescue Exception => e
      raise Puppet::Error, "Could not notify New Relic application #{resource[:name]}, failed with #{e}"
    end
  end

  def destroy
    return true
  end

  def notify(resource)
    NewRelicApi.api_key = resource[:api_key]
    NewRelicApi::Deployment.create :app_id => "#{resource[:name]}", :user => "#{resource[:user]}", :description => "#{resource[:description]}", :revision => "#{resource[:revision]}"
  end
end
