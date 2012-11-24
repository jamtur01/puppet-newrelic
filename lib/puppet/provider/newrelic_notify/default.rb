Puppet::Type.type(:newrelic_notify).provide(:default) do

  desc "This is a default provider that does nothing. This allows us to use the provider on the same puppet run where we install it."

  def create
    return false
  end

  def destroy
    return false
  end

  def exists?
    fail('This is just the default provider for newrelic_notify, all it does is fail')
  end
end
