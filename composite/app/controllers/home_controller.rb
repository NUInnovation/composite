class HomeController < ApplicationController
  def index
    # explore Instagram API further 
    # @popular = Instagram.media_popular
    # @instagram = Instagram.user_recent_media("moonlapsemusic")
    @recent_media = Instagram.location(514276)

    # @recent_media = Instagram.media_popular()
  end
end
