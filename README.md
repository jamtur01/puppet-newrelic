puppet-newrelic
=============

Description
-----------

A Puppet report handler for sending deployment events to
[NewRelic](http://newrelic.com) via the [Deployment
API](http://newrelic.github.com/newrelic_api/NewRelicApi/Deployment.html).

Requirements
------------

* Puppet 2.6.5 or later
* `newrelic_api` gem
* You will need to enable API access to your New Relic account. To do this, go to
Account settings (upper right corner of the New Relic site), and then
click on Integrations => Data Sharing. Select API access, and enable it.

Installation & Usage
--------------------

1.  Install the `newrelic_api` gem on your Puppet master

        $ sudo gem install newrelic_api

2.  Install puppet-newrelic as a module in your Puppet master's module
    path. To install the NewRelic RPM gem on the hosts with deployed
    applications declare the `newrelic` class.

        class { 'newrelic':
          enabled => 'true',
        }

    To install the NewRelic API gem on the Puppet master declare the
    `newrelic::api` class.

        class { 'newrelic::api':
          enabled => 'true',
        }   

3.  Update the `api_key` variable in the `newrelic.yaml` file with
    your New Relic API key.

        ---
        :api_key: 'abc123'

4.  Add a list of your hosts to newrelic.yaml and match each host to the
    New Relic application deployed on it. Currently this is ugly and
    only supports one application per host. Anyone with ideas on how to do
    it better is welcomed. :)

        ---
        :api_key: 'abc123'
        :hosts:
          - {host: 'hostname1', key: '123456'}
          - {host: 'hostname2', key: '123456'}

    You can get the Application ID key from the New Relic url, for
    example: https://rpm.newrelic.com/accounts/17710/applications/56658.
    Where `56658` is the Application ID key. 

5.  Copy `newrelic.yaml` to `/etc/puppet`.

6.  Enable pluginsync and reports on your master and clients in `puppet.conf`

        [master]
        report = true
        reports = newrelic
        pluginsync = true
        [agent]
        report = true
        pluginsync = true

7.  Run the Puppet client and sync the report as a plugin

Author
------

James Turnbull <james@lovedthanlost.net>

License
-------

    Author:: James Turnbull (<james@lovedthanlost.net>)
    Copyright:: Copyright (c) 2012 James Turnbull
    License:: Apache License, Version 2.0

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
