//
//  FindHouseViewController.swift
//  homeView
//
//  Created by Suki Patwardhan on 7/14/19.
//  Copyright © 2019 Suki Patwardhan. All rights reserved.
//

import UIKit
import MapKit

class FindHouseViewController: UIViewController {
    // MARK: -Properties
    var findView = FindHouseView()
    let locationManager = CLLocationManager()
    var resultsSearchController: UISearchController? = nil
    
    override func loadView() {
        view = findView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManagerSetup()
        locationSearchSetup()
        
    }
    
    func locationManagerSetup() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
    
    func locationSearchSetup() {
        let locationSearchTable = LocationSearchTableController()
        resultsSearchController = UISearchController(searchResultsController: self)
        resultsSearchController?.searchResultsUpdater = locationSearchTable
        
        let searchBar = resultsSearchController!.searchBar
        searchBar.sizeToFit()
        searchBar.placeholder = "Search for a house"
        navigationItem.titleView = resultsSearchController?.searchBar
        
        resultsSearchController?.hidesNavigationBarDuringPresentation = false
        resultsSearchController?.dimsBackgroundDuringPresentation = true
        definesPresentationContext = true
    }
    
}

// MARK: -FindHouseViewController
extension FindHouseViewController: FindHouseViewDelegate {

}

// MARK: -LocationManagerDelegate
extension FindHouseViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            manager.requestLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            let span = MKCoordinateSpan(latitudeDelta: 0.0005, longitudeDelta: 0.0005)
            let region = MKCoordinateRegion(center: location.coordinate, span: span)
            findView.mapView.setRegion(region, animated: true)
            print("Location :: \(location)")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error :: \(error)")
    }
    
}

