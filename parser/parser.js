var jsonfile = require('jsonfile');
var request = require('request');
var async = require('async');
var _ = require('underscore');

var fs = require('fs');
var json = JSON.parse(fs.readFileSync('data.json', 'utf8'));

var tmpData = [];
var data = [];

_.each(json["features"], function(station){
  tmpData.push({
    lat: station.lat,
    lon: station.lon,
    name: station.popup.split("\">")[1].split("</a>")[0], 
    id: parseInt(station.feature_id)
  });
});

async.each(tmpData, function(s, callback) {
  
  request('http://www.neste.lv/lv/getstationinfo/'+s.id, function (error, response, body) {
    console.log("--> " + s.id);
    // console.log(body);
    
    if (!error && response.statusCode == 200) {
      try {
        var d = JSON.parse(body);
        
        if (d.fuel) {
          s.fuel = d.fuel;
        }
        
        if (d.other) {
          s.other = d.other;
        }
        
        data.push(s);
      } catch(e){
        console.log(body);
      }
    } else {
      console.log("ERROR");
      console.log(body);
      console.log(error);
    }
    
    callback();
  });
  
}, function(err) {
  if (err) {
    console.log("ERR");
    console.log(err);
  } else {
    var file = 'tmp_data.json';
     
    jsonfile.writeFile(file, data, {spaces: 2}, function (err) {
      if (err) {
        console.error(err);
      }
    });
  }
});