class HomeController < ApplicationController
  
  require 'opencv'
  include OpenCV


  def index

    @client = Instagram.client(:access_token => Instagram.access_token)
    @instagram = @client.media_search("37.7808851", "-122.3948632")

    "Usage: your_app_name source dest"

    data = "vendor/assets/opencv/haarcascade_frontalface_alt.xml"
    detector = OpenCV::CvHaarClassifierCascade::load(data)
    image = OpenCV::IplImage.load("vendor/assets/opencv/faces.jpg")
    detector.detect_objects(image) do |region|
      color = OpenCV::CvColor::Blue
      image.rectangle! region.top_left, region.bottom_right, :color => color
    end
    image.save_image("vendor/assets/opencv/results.jpg")
    
  end

end
