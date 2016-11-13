//
//  ViewController.swift
//  Neste Baltics
//
//  Created by Kristaps Grinbergs on 13/11/2016.
//  Copyright © 2016 fassko. All rights reserved.
//

import UIKit
import GoogleMaps


class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    
  }
  
  override func loadView() {
    let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
    let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
    
    mapView.isMyLocationEnabled = true
    mapView.settings.compassButton = true
    mapView.settings.indoorPicker = true
    
    view = mapView

    // Creates a marker in the center of the map.
    let marker = GMSMarker()
    marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
    marker.title = "Sydney"
    marker.snippet = "Australia"
    marker.map = mapView
  }

}

