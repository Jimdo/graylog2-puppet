Puppet::Type.type(:graylog_stream_rule).provide(:default) do
  require 'net/http'
  require 'json'

  def prefetch
  end

  def flush
  end

  def field=
  end
end

