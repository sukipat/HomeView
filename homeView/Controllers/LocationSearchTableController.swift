//
//  LocationSearchTable.swift
//  homeView
//
//  Created by Suki Patwardhan on 7/15/19.
//  Copyright © 2019 Suki Patwardhan. All rights reserved.
//

import UIKit
import MapKit

class LocationSearchTableController: UITableViewController {
    var matchingItems:[MKMapItem] = []
    var mapView: MKMapView? = FindHouseView().mapView
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matchingItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let searchCell = tableView.dequeueReusableCell(withIdentifier: "searchCell")
        let selectedItem = matchingItems[indexPath.row].placemark
        searchCell?.textLabel?.text = selectedItem.name
        searchCell?.detailTextLabel?.text = ""
        return searchCell!
    }
}

extension LocationSearchTableController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let mapView = mapView,
            let searchBarText = searchController.searchBar.text else { return }
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchBarText
        request.region = mapView.region
        let search = MKLocalSearch(request: request)
        search.start { (response,error) in
            guard let response = response else {
                print(error!)
                return
            }
            self.matchingItems = response.mapItems
            self.tableView.reloadData()
        }
        
    }
}
