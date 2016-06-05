# composite

#### team members

eric brownrout, benjamin strick, william noglows

#### synopsis

composite lets users explore the faces of the world via instagram photos and geolocation.

#### how it works

the user enters a location into the search bar at the top right of the screen. during loading time, composite fetches images from the instagram api at this location, converts them to grayscale to increase the accuracy of face detection, and runs them through opencv frontal face detection. when enough faces have been detected, the cropped out faces are returned to the client and placed into a grid for the user to see. the user can load more images from the given location or explore the large interactive map above which provides a visualization of the location.

#### key technology

* ruby on rails
* instragram api
* open cv face detection algorithm
* google maps api
* postgresql
* javascript

#### set up

* install ruby and ror
* udpdate/install required gems - note, opencv gem is quite difficult to work with
* create the ror db
* create an instagram developer account to get keys and secrets for api - note, depreciated
* use figaro gem to hide all developer secrets as environment variables
* 'rails s' from project directory to start the project

current build of project is in offline mode for the purposes of in class demo. deprecation of instagram api crashed the project. check older builds for the code for online usage.

#### next steps

there are a variety of next steps that could be taken with this project.  unfortunately, all apps that would like to freely use the instagram api after june 1st 2016 must complete an official instagram development review.  composite would have to go through this process in order to continue to utilize the instagram api as was done during the course of constructing the project. One idea might be to find a different photo-sharing application to pull from that is less restrictive about api usage than instagram became on June 1. if this could be addressed, deployment would be a natural next step.  other features and natural next steps we’ve discussed for composite include:  live map-scroll updating of the face grid, accuracy/speed optimizations, trending locations feature in which users can explore locations of various news events, search by hashtags and other attributes, and filtering of faces by gender, ethnicity, and age.



