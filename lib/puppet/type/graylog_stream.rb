Puppet::Type.newtype(:graylog_stream) do
  desc "Puppet type that manages graylog streams via http://localhost:12900"

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


  newparam(:name, :namevar => true) do
    desc "Stream name, also id. Do not rename puppet-created streams!"
    munge do |value|
      value.strip
    end
  end

  newparam(:username) do
    desc "Username for authentication"
  end

  newparam(:password) do
    desc "Password for authentication"
  end

  newparam(:description) do
    desc "Stream desription"
  end

end
