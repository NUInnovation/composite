class HomeController < ApplicationController
  
  require 'opencv'
  require 'open-uri'
  require 'tempfile'

  require 'net/http'
  require 'uri'
  require 'ostruct'

  include OpenCV


  def index

    # Array for displaying images on index, and flag for empty state
    @img_paths = []
    @flag = true

    # Only if we have a search query from the user
    unless params[:lat].blank? && params[:long].blank?

      @flag = false

      # Instagram API preparation and query
      @client = Instagram.client(:access_token => Instagram.access_token)
      @instagram = @client.media_search(params[:lat], params[:lng], options = {:count => 60})
      
      # Face recognition -- Loading the training data
      data = "vendor/assets/opencv/haarcascade_frontalface_alt.xml"
      detector = OpenCV::CvHaarClassifierCascade::load(data)

      for photo in @instagram

        # Load the image in temporary storage in order to make it available for Open CV to process
        insta_img = Net::HTTP.get(URI.parse(photo.images.standard_resolution.url))
        temp = Tempfile.new(['img','.jpg'])
        insta_img.force_encoding('UTF-8')
        temp.write(insta_img)
        
        #debugging step -- delete
        puts temp.path

        # Add error handling HERE for bad image paths (rare case)
        # Open the image with OpenCV -- GrayScale has better facial recognition accuracy and/or speed?
        image = OpenCV::IplImage.load(temp.path, iscolor = CV_LOAD_IMAGE_GRAYSCALE)

        # Used for appending unique identifier to multiple faces detected in the same image
        face_id = 0

        # Faces detected for each image in this loop
        # For each face, grab its name and url to original image, place them in struct and insert into array
        detector.detect_objects(image) do |region|
          face_img = image.sub_rect(region)
          file_name = photo.id.to_s + "_face_" + face_id.to_s + ".jpg"
          path = "app/assets/images/" + file_name
          face_img.save_image(path)
          face_id += 1
          face = OpenStruct.new
          face.name = file_name
          #face.link = photo.images.standard_resolution.url.to_s
          face.link = "https://picstuff.xyz/media/" + photo.id.to_s
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




