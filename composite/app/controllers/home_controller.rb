class HomeController < ApplicationController
  
  require 'opencv'
  require 'open-uri'
  require 'tempfile'

  require 'net/http'
  require 'uri'
  require 'ostruct'

  include OpenCV


  def index

    # Instagram API Calls
    @client = Instagram.client(:access_token => Instagram.access_token)
    #@instagram = @client.media_search("37.7808851", "-122.3948632")
    
    unless params[:lat].blank? && params[:long].blank?
      @instagram = @client.media_search(params[:lat], params[:lng], options = {:count => 50})
    else
      @instagram = @client.media_search("37.7808851", "-122.3948632", options = {:count => 50})
      params[:current] = "Evanston, IL, USA"
    end

    # Alternate way to print content to screen
    #@html = ""
    #for media in @instagram
    #  @html << "<img src='#{media.images.thumbnail.url}'>"
    #end
    
    # # The below is our face recognition on saved images
    data = "vendor/assets/opencv/haarcascade_frontalface_alt.xml"
    detector = OpenCV::CvHaarClassifierCascade::load(data)

    @img_paths = []
    num = 0

    for photo in @instagram

      puts num
      num+=1

      insta_img = Net::HTTP.get(URI.parse(photo.images.standard_resolution.url))
      temp = Tempfile.new(['img','.jpg'])
      insta_img.force_encoding('UTF-8')
      temp.write(insta_img)
      
      #debugging step
      puts temp.path

      #add error handling HERE
      image = OpenCV::IplImage.load(temp.path, iscolor = CV_LOAD_IMAGE_GRAYSCALE)
      face_id = 0

      detector.detect_objects(image) do |region|
        #image.rectangle! region.top_left, region.bottom_right, :color => color
        face_img = image.sub_rect( region )
        file_name = photo.id.to_s + "_face_" + face_id.to_s + ".jpg"
        path = "app/assets/images/" + file_name
        face_img.save_image(path)
        face_id += 1
        face = OpenStruct.new
        face.name = file_name
        face.link = photo.images.standard_resolution.url.to_s
        @img_paths.push(face)
        break if @img_paths.length >= 21
      end
      break if @img_paths.length >= 21
    end

  end
end




