//
//  SecondViewController.swift
//  Fonts
//
//  Created by user on 12/22/18.
//  Copyright © 2018 Pekshn. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    @IBOutlet weak var azimuthLabel: UILabel!
    @IBOutlet weak var contactLabel: UILabel!
    @IBOutlet weak var latLabel: UILabel!
    @IBOutlet weak var lonLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var registrationLabel: UILabel!
    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var outButton: UIButton!
    
    var azimuth:String!
    var contact:String!
    var lat:String!
    var lon:String!
    var name:String!
    var registration:String!
    var speed:String!
    var timestamp:String!
    
    var vehicle: RootTableViewController.Vehicle!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        azimuthLabel.text = " " + String(vehicle.Azimuth)
        if vehicle.Contact == true {
            outButton.backgroundColor = .green
            contactLabel.textColor = .green
            speedLabel.textColor = .green
        } else {
            outButton.backgroundColor = .red
            contactLabel.textColor = .red
            speedLabel.textColor = .red
        }
        contactLabel.text = contact
        latLabel.text = lat
        lonLabel.text = lon
        nameLabel.text = " " + vehicle.Name
        registrationLabel.text = registration
        speedLabel.text = speed
        timestampLabel.text = timestamp
    }
    
    @IBAction func showMapButton(_ sender: UIButton) {
        print("Show Location Tapped")
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dest = segue.destination as! MapViewController
        dest.vehicle = vehicle
    }
}
