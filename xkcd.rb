#!/usr/bin/env ruby

require 'net/http'
require 'json'

class XkcdImage
  def self.img(num = 0) # num is the id number of the comic, 0 is today's comic
    if num == 0
      json_url = "http://xkcd.com/info.0.json"
    else
      json_url = "http://xkcd.com/#{num}/info.0.json"
    end
    response = Net::HTTP.get_response( URI.parse(json_url) )
    raise "there was an error: #{response.code}" unless response.code == "200"
    le_json  = JSON.parse( response.body )
    le_json['img']
  end

  def self.save( img, dir )
    `cd #{dir} && curl -O #{img}`
  end
end

if __FILE__ == $0
  XkcdImage.save( XkcdImage.img, "~/Desktop/" )
end
