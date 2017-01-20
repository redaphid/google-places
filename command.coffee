{key} = require './api-key.json'

GooglePlaces = require './google-places'


places = new GooglePlaces key: key, lat: '33.431325', lon:'-111.9411729'

places.findNearby (error, results) =>
  console.log JSON.stringify {error, results}, null, 2
