//
//  Map.swift
//  espritApp
//
//  Created by Mohamed Melek Chtourou on 17/8/2022.
//  Copyright © 2022 Big Rattle Technologies Private Limited. All rights reserved.
//

import Foundation
import UIKit
import MapKit
import CoreLocation
class MapView: UIViewController,MKMapViewDelegate,CLLocationManagerDelegate,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var locationTableView: UITableView!
    @IBOutlet weak var mapView: MKMapView!
    
    private var locationManager: CLLocationManager!
    private var currentLocation: CLLocation?
    var tableauBuilding = [Building]()
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableauBuilding.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:  "blocCell",for: indexPath) as! cellBuilding
        cell.bloc.text = tableauBuilding[indexPath.row].label
        //cell.place.text = tableauBuilding[indexPath.row]
        return cell
    }
    
   

    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if (view.annotation?.title!) != "Vous" {
            locationTableView.reloadData()
            locationTableView.isHidden = false
        }
    }
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        locationTableView.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationTableView.isHidden = true
        loadBuildingsInTableView(tableau:self.locationTableView)
        mapView.delegate = self
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest

        // Check for Location Services

        if CLLocationManager.locationServicesEnabled() {
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
        }
    }

    func loadBuildingsInTableView (tableau:UITableView){
        
        BuildingService().getBuildings { succes, reponse in
            if succes {
                for article in reponse!{
                    let marker = MKPointAnnotation()
                    marker.title = article.label
                    marker.coordinate = CLLocationCoordinate2D(latitude: article.lat, longitude: article.lang)
                    self.mapView.addAnnotation(marker)
                    self.tableauBuilding.append(article)
                }
            }else{
                self.tableauBuilding.removeAll()
                self.locationTableView.reloadData()
            }
        }
   }
    
    @IBAction func hamburgerBtnAction(_ sender: UIBarButtonItem) {
        HamburgerMenu().triggerSideMenu()
    }
    // MARK - CLLocationManagerDelegate

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        defer { currentLocation = locations.last }

        if currentLocation == nil {
            // Zoom to user location
            if let userLocation = locations.last {
                let locValue:CLLocationCoordinate2D = manager.location!.coordinate
                let viewRegion = MKCoordinateRegion(center: userLocation.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
                let annotation = MKPointAnnotation()
                annotation.coordinate = locValue
                annotation.title = "Vous"
                annotation.subtitle = "Position actuelle"
                mapView.addAnnotation(annotation)
                mapView.setRegion(viewRegion, animated: true)
            }
        }
    }
    
}
