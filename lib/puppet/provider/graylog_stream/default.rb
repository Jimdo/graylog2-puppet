Puppet::Type.type(:graylog_stream).provide(:default) do
  require 'net/http'
  require 'json'

  URI_STR = 'http://localhost:12900/streams'
  URI_ = URI URI_STR
  def self.streams
    req = Net::HTTP::Get.new URI_STR
    req.basic_auth resource[:username], resource[:password]
    res = Net::HTTP.start(URI_.hostname, URI_.port) do |http|
      http.request(req)
    end
    res = JSON.load res.body
    Hash[
      res['streams'].map do |stream|
        [stream['title'], stream]
      end
    ]
  end

  def exists?
    streams[resource[:name]] != nil
  end

  def create
    req = Net::HTTP::Post.new URI_STR
    req.basic_auth resource[:username], resource[:password]
    req.set_content_type 'application/json'
    req.body = JSON.dump({
      "title" => resource[:name],
      "description" => resource[:description],
    })
    res = Net::HTTP.start(URI_.hostname, URI_.port) do |http|
      http.request(req)
    end
    res = JSON.load res.body
  end

  def destroy
    #require 'pry'; binding.pry
    stream_id = streams[resource[:name]]["id"]
    req = Net::HTTP::Delete.new URI_STR + '/' + stream_id
    req.basic_auth resource[:username], resource[:password]
    res = Net::HTTP.start(URI_.hostname, URI_.port) do |http|
      http.request(req)
    end
  end
end

