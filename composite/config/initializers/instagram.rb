 require "instagram"
    Instagram.configure do |config|
    config.client_id = ENV["InstagramID"]
    config.access_token = ENV["InstagramToken"]
    config.client_secret = ENV["InstagramSecret"]
 end