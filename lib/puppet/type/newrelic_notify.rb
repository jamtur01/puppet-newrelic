Puppet::Type.newtype(:newrelic_notify) do

  @doc = "Send deployment notifications to New Relic."

  ensurable

  newparam(:app_id, :namevar => true) do
    desc "The New Relic Application ID."
  end

  newparam(:user) do
    desc "The user who issed the deploy. Defaults to Puppet. Optional."

    defaultto "Puppet"
  end

  newparam(:api_key) do
    desc "The New Relic API key."

    validate do |value|
      if value == nil
        raise ArgumentError, "You must specify an API key."
      end
    end
  end

  newparam(:description) do
    desc "The description of the deployment. Optional."

    defaultto "Application deployed."
  end

  newparam(:revision) do
    desc "The revision deployed. Optional."

    defaultto "Revision not specified."
  end
end
