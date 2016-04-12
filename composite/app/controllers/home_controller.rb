class HomeController < ApplicationController
  
  require 'json'

  def index

    @client = Instagram.client(:access_token => Instagram.access_token)
    @instagram = @client.media_search("37.7808851", "-122.3948632")

    # @response = HTTParty.get("https://api.instagram.com/v1/tags/nofilter/media/recent?access_token=40497799.1677ed0.edc9f94205964f5abb2e97567d6057f0")
    # @result = JSON.parse(@response.body)
    # @array = []
    # @result['data'].each do |image|
    #     @array.push(image)
    # end
    # @test = @result["data"]

  end

end
