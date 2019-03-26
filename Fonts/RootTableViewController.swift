//
//  RootTableViewController.swift
//  Fonts
//
//  Created by user on 12/20/18.
//  Copyright © 2018 Pekshn. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class RootTableViewController: UITableViewController {

    @IBOutlet weak var tableview: UITableView!
    
    private var cellPointSize: CGFloat!
    private static let familyCell = "FamilyName"
    private static let favoritesCell = "Favorites"
    
    private var vehicles: [Vehicle] = []  {
        didSet {
            self.tableview.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Vehicles List"
        let prefferedTableViewFont = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.headline)
        cellPointSize = prefferedTableViewFont.pointSize
        tableView.estimatedRowHeight = cellPointSize
        fetchJSON()
    }
    
    func fetchJSON() {
        DispatchQueue.main.async {
            request("https://api.myjson.com/bins/j9onm").responseJSON(completionHandler: { (response) in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    print(json)
                    json.array?.forEach({ (user) in
                        let user = Vehicle(Azimuth: user["Azimuth"].intValue, Contact: user["Contact"].boolValue, Lat: user["Lat"].intValue, Lon: user["Lon"].intValue, Name: user["Name"].stringValue, Registration: user["Registration"].stringValue, Speed: user["Speed"].intValue, Timestamp: user["Timestamp"].stringValue)
                        self.vehicles.append(user)
                    })
                    self.tableView.reloadData()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            })
        }
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vehicles.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RootTableViewController.familyCell, for: indexPath)
        // Configure the cell...
        if vehicles[indexPath.row].Contact {
        let image = UIImage(named: "green-arrow")
            cell.imageView?.image = image
        } else {
            cell.imageView?.image = UIImage(named: "shutdown")
        }
        cell.textLabel!.text = vehicles[indexPath.row].Name
        cell.detailTextLabel!.text = vehicles[indexPath.row].Registration
        return cell
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let indexPath = tableview.indexPath(for: sender as! UITableViewCell)!
        if segue.identifier == "ShowSecondViewController" {
        let dest = segue.destination as! SecondViewController
        dest.azimuth = "  " + String(vehicles[indexPath.row].Azimuth)
        dest.contact = "  " + String(vehicles[indexPath.row].Contact)
        dest.lat = "  " + String(vehicles[indexPath.row].Lat)
        dest.lon = "  " + String(vehicles[indexPath.row].Lon)
        dest.name = "  " + vehicles[indexPath.row].Name
        dest.registration = "  " + vehicles[indexPath.row].Registration
        dest.speed = "  " + String(vehicles[indexPath.row].Speed)
        dest.timestamp = "  " + vehicles[indexPath.row].Timestamp
        dest.title = vehicles[indexPath.row].Name
        dest.vehicle = vehicles[indexPath.row]
        } else {
            let dest1 = segue.destination as! MapViewController
            dest1.vehicle = vehicles[indexPath.row]
        }
    }
}
