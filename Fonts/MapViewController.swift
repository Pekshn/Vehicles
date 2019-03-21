//
//  MapViewController.swift
//  Fonts
//
//  Created by user on 12/22/18.
//  Copyright © 2018 Pekshn. All rights reserved.
//

import UIKit
import GoogleMaps

class MapViewController: UIViewController, GMSMapViewDelegate {

    @IBOutlet weak var upperView: UIView!
    @IBOutlet weak var upperRegistrationLabel: UILabel!
    @IBOutlet weak var upperContactLabel: UILabel!
    @IBOutlet weak var upperAzimuthLabel: UILabel!
    @IBOutlet weak var upperSpeedLabel: UILabel!
    @IBOutlet weak var mapView: GMSMapView!
    
    var vehicle: RootTableViewController.Vehicle!

    override func viewDidLoad() {
        super.viewDidLoad()
        gmsServices()
    }
    
    func gmsServices() {
        GMSServices.provideAPIKey("AIzaSyCvlBxClnafF5GsshMiBTqHwCXrHjOAmZg")
        let latitude = Double(vehicle.Lat) / 1000000
        let longitude = Double(vehicle.Lon) / 1000000
        let camera = GMSCameraPosition.camera(withLatitude: latitude, longitude: longitude, zoom: 17)
        mapView.camera = camera
        let currentLocation = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let marker = GMSMarker(position: currentLocation)
        marker.groundAnchor = CGPoint(x: 0.5, y:0.5)
        marker.rotation = CLLocationDegrees(vehicle.Azimuth)
        marker.title = "\(vehicle.Name)"
        marker.infoWindowAnchor = CGPoint(x: 0.5, y: 0.5)
        if vehicle.Contact == true {
            marker.icon = UIImage(named: "green-arrow.png")
        } else {
            marker.icon = UIImage(named: "shutdown")
        }
        marker.snippet = vehicle.Timestamp
        marker.isFlat = false
        marker.map = mapView
        mapView.settings.compassButton = true
        mapView.delegate = self
        upperRegistrationLabel.text = "Reg: " + vehicle.Registration
        upperContactLabel.text = "Contact: " + String(vehicle.Contact)
        upperAzimuthLabel.text = "Azimuth: " + String(vehicle.Azimuth)
        upperSpeedLabel.text = "Speed: " + String(vehicle.Speed)
    }
    
    //MARK: GMSMapView Delegate Methods
    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
        if upperView.isHidden == true {
            upperView.isHidden = false
        } else {
            upperView.isHidden = true
        }
    }
}
