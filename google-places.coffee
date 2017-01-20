_ = require 'lodash'
async = require 'async'
request = require 'request'

class GooglePlaces
  constructor: ({@key, @lat, @lon}) ->

  findNearby: (callback)=>
    options =
      url: 'https://maps.googleapis.com/maps/api/place/nearbysearch/json'
      qs:
        location: "#{@lat},#{@lon}"
        radius: 5000
        key: @key
        opennow: true
        type: 'bar'
      json: true

    request.get options, (error, response, body) =>
      return callback error if error?
      async.mapSeries _.map(body.results, 'place_id'), @getDetails, callback


  getDetails: (id, callback) =>
    console.log 'yo'
    options =
      url: 'https://maps.googleapis.com/maps/api/place/details/json'
      qs:
        placeid: id
        key: @key
      json: true

    request.get options, (error, response, body) =>      
      callback error, body




module.exports = GooglePlaces
