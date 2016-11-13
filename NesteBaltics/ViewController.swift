//
//  ViewController.swift
//  Neste Baltics
//
//  Created by Kristaps Grinbergs on 13/11/2016.
//  Copyright © 2016 fassko. All rights reserved.
//

import UIKit
import GoogleMaps
import SwiftyJSON

class ViewController: UIViewController {

  var mapView:GMSMapView?

  override func viewDidLoad() {
    super.viewDidLoad()
    
  }
  
  override func loadView() {
    let camera = GMSCameraPosition.camera(withLatitude: 56.9496, longitude: 24.1052, zoom: 6.0)
    mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
    
    mapView?.isMyLocationEnabled = true
    mapView?.settings.compassButton = true
    mapView?.settings.indoorPicker = true
    
    view = mapView

    showStations()
  }
  
  
  func showStations() {
    if let path = Bundle.main.url(forResource: "data", withExtension: "json") {
    
      do {
        let jsonData = try Data(contentsOf: path, options: .mappedIfSafe)
        
        let json = JSON(data: jsonData)
        
        if let stations = json["stations"].array {
          for var station in stations {
            
            let position = CLLocationCoordinate2DMake(CLLocationDegrees(station["lat"].floatValue), CLLocationDegrees(station["lon"].floatValue))
            let marker = GMSMarker(position: position)
            marker.title = station["name"].stringValue
            marker.snippet = station["fuel"]["Tuotteisto"].stringValue
            marker.map = mapView
          }
        }
        
      } catch let error as NSError {
        print("Error: \(error)")
      }
    }
  }

}

