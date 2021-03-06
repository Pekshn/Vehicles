//
//  RootTableViewController.swift
//  Fonts
//
//  Created by user on 12/20/18.
//  Copyright © 2018 Pekshn. All rights reserved.
//

import UIKit

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

    struct Vehicle: Decodable {
        let Azimuth: Int
        let Contact: Bool
        let Lat: Int
        let Lon: Int
        let Name: String
        let Registration: String
        let Speed: Int
        let Timestamp: String
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Vehicles List"
        let prefferedTableViewFont = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.headline)
        cellPointSize = prefferedTableViewFont.pointSize
        tableView.estimatedRowHeight = cellPointSize
        fetchJSON()
    }
    
    fileprivate func fetchJSON() {
        let jsonUrlString = "https://api.myjson.com/bins/j9onm"
        guard let url = URL(string: jsonUrlString) else {return}
        URLSession.shared.dataTask(with: url) { (data, _, err) in
            DispatchQueue.main.async {
                if let err = err {
                    print("Failed to get data from url:", err)
                    return
                }
                guard let data = data else {return}
                do {
                    let decoder = JSONDecoder()
                    self.vehicles = try decoder.decode([Vehicle].self, from: data)
                } catch let jsonErr {
                    print("Failed to decode:", jsonErr)
                }
            }
            }.resume()
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
