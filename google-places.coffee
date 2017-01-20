_ = require 'lodash'
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
      return @getDetails(_.first(body.results).place_id, callback)


  getDetails: (id, callback) =>
    options =
      url: 'https://maps.googleapis.com/maps/api/place/details/json'
      qs:
        placeid: id
        key: @key
      json: true

    request.get options, (error, response, body) => callback error, body




module.exports = GooglePlaces
