Puppet::Type.newtype(:graylog_stream_rule) do
  desc "Puppet type that manages graylog streams rules"

  ensurable do

    defaultto :present
    newvalue(:present) do
      provider.create
    end

    newvalue(:absent) do
      provider.destroy
    end

    newvalue(:started) do
      provider.start
    end

    newvalue(:stopped) do
      provider.stop
    end
  end

  newparam(:stream) do
    desc "Stream name, also id. Do not rename puppet-created streams!"
  end

  newproperty(:field)
  newproperty(:type) do
    defaultto :exact
    newvalues(:exact, :regex, :greater_than, :smaller_than, :presence)
  end

  newproperty(:inverted) do
    defaultto :false
    newvalues(:true, :false)
  end

  newproperty(:value)
end
