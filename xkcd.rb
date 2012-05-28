#!/usr/bin/env ruby

require 'net/http'
require 'json'

class XkcdImage
  def self.img
    json_url = 'http://xkcd.com/info.0.json'
    response = Net::HTTP.get_response( URI.parse(json_url) )
    raise "there was an error: #{response.code}" unless response.code == "200"
    le_json  = JSON.parse( response.body )
    le_json['img']
  end

  def self.save( img, dir )
    `curl -Oo #{dir} #{img}`
  end
end

if __FILE__ == $0
  XkcdImage.save( XkcdImage.img, "~/Desktop/" )
end