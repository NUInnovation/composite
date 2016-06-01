class HomeController < ApplicationController
  
  require 'opencv'
  #require 'open-uri'
  #require 'tempfile'

  #require 'net/http'
  #require 'uri'
  require 'ostruct'

  include OpenCV


  # UPDATE: Instagram closing their API on June 1st ruined this project
  # Link: http://developers.instagram.com/post/145262544121/instagram-platform-update-effective-june-1-2016

  # The following edits we've made are to hopefully demo the functionality of our app by using local images
  # instead of querying Instagram's API




  def index

    # Array for displaying images on index, and flag for empty state
    @img_paths = []
    @flag = true

    # Only if we have a search query from the user
    unless params[:lat].blank? && params[:long].blank?

      @flag = false

      # Instagram API preparation and query
      
      # No longer valid calls
      #@client = Instagram.client(:access_token => Instagram.access_token)
      #@instagram = @client.media_search(params[:lat], params[:lng], options = {:count => 60})
      @instagram = Dir.glob("app/assets/images/faces1/*.jpg")
      @tmp= Dir.glob("public/*.jpg")
      @instagram2 = []

      for index in 0 ... @tmp.length
        puts @tmp[index]
        @tmp[index].slice! "public/"
        @instagram2.push(@tmp[index])
      end

      puts @instagram2
      
      # Face recognition -- Loading the training data
      data = "vendor/assets/opencv/haarcascade_frontalface_alt.xml"
      detector = OpenCV::CvHaarClassifierCascade::load(data)

      nameGen = 100

      for photo in @instagram

        # Load the image in temporary storage in order to make it available for Open CV to process
        #insta_img = Net::HTTP.get(URI.parse(photo.images.standard_resolution.url))
        #temp = Tempfile.new(['img','.jpg'])
        #insta_img.force_encoding('UTF-8')
        #temp.write(insta_img)
        
        #debugging step -- delete
        #puts temp.path

        # Add error handling HERE for bad image paths (rare case)
        # Open the image with OpenCV -- GrayScale has better facial recognition accuracy and/or speed?
        image = OpenCV::IplImage.load(photo, iscolor = CV_LOAD_IMAGE_GRAYSCALE)

        # Used for appending unique identifier to multiple faces detected in the same image
        face_id = 0

        # Faces detected for each image in this loop
        # For each face, grab its name and url to original image, place them in struct and insert into array
        detector.detect_objects(image) do |region|
          face_img = image.sub_rect(region)
          file_name = nameGen.to_s + "_face_" + face_id.to_s + ".jpg"
          nameGen+=1
          path = "app/assets/images/" + file_name
          face_img.save_image(path)
          face_id += 1
          face = OpenStruct.new
          face.name = file_name
          #face.link = photo.images.standard_resolution.url.to_s
          # face.link = "https://picstuff.xyz/media/" + photo.id.to_s
          face.link = "no longer functional"
          @img_paths.push(face)
          break if @img_paths.length >= 28 # enough photos for us to display
        end
        break if @img_paths.length >= 28 # enough photos for us to display
      end
    end
    # respond_to do |format|
    #   format.html
    #   format.json { render :json => @img_paths.to_json }
    # end
  end

end




