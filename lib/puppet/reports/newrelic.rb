require 'puppet'
require 'yaml'
require 'newrelic_api'

unless Puppet.version >= '2.6.5'
    fail "This report processor requires Puppet version 2.6.5 or later"
end

Puppet::Reports.register_report(:newrelic) do

  configfile = File.join([File.dirname(Puppet.settings[:config]), "newrelic.yaml"])
  raise(Puppet::ParseError, "NewRelic report config file #{configfile} not readable") unless File.exist?(configfile)
  CONFIG = YAML.load_file(configfile)

  desc <<-DESC
  Send Puppet deployment events to NewRelic.
  DESC

  def process
    app_id = CONFIG[:hosts].detect {|h| h["host"] == self.host }['key'] rescue nil
    if app_id == nil
      Puppet.info("Unable to match #{self.host} to a specific NewRelic Application ID - check newrelic.yaml")
      exit
    elsif self.kind == 'apply'
      NewRelicApi.api_key = CONFIG[:api_key]
      NewRelicApi::Deployment.create :app_id => "#{app_id}", :description => "Puppet run #{self.configuration_version} on #{self.host} at #{self.time}", :user => "Puppet"
    else
      Puppet.info("Not reporting deployment of Puppet run of type: #{self.kind}")
    end
  end
end
