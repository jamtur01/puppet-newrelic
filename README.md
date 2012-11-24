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
click on API + web integration. Select API access, and enable it.

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

4.  Copy `newrelic.yaml` to `/etc/puppet`.

5.  Enable pluginsync and reports on your master and clients in `puppet.conf`

        [master]
        report = true
        reports = newrelic
        pluginsync = true
        [agent]
        report = true
        pluginsync = true

6.  Run the Puppet client and sync the report as a plugin

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
