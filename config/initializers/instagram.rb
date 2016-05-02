require "instagram"

Instagram.configure do |config|
    config.client_id = Figaro.env.InstagramID
    config.access_token = Figaro.env.InstagramToken
    config.client_secret = Figaro.env.InstagramSecret
end