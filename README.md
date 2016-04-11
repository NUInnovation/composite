# composite-v2

#### team members

eric brownrout, benjamin strick, william noglows

#### synopsis

composite aggregates and presents the faces in instagram photos based on geolocation. 

#### how it works

users will give composite a zip code that they are interested in exploring. composite then uses the instagram api to gather photos from that location processes them with open cv in order to detect and pull the faces out.

#### key technology

* ruby on rails
* instragram api
* open cv
* postgresql
* ...more to come

#### next steps

###### short term

* integrate instagram api
* set up opencv to detect faces in images
* build basic functioning front end
* deploy to heroku

###### long term

* set up opencv to recognize gender, age, etc.
* use opencv for dog/cat recognition
* refine ui
* optimize/improve site speed