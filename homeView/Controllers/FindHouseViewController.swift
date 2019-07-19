//
//  FindHouseViewController.swift
//  homeView
//
//  Created by Suki Patwardhan on 7/18/19.
//  Copyright © 2019 Suki Patwardhan. All rights reserved.
//

import UIKit

class FindHouseViewController: UIViewController {
    let findHouse = FindHouseView()
    
    override func loadView() {
        view = findHouse
        findHouse.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: - FindHouseViewDelegate
extension FindHouseViewController: FindHouseViewDelegate {
    func showhouse() {
        let houseView = HouseViewController()
        self.navigationController?.pushViewController(houseView, animated: true)
        DataController.shared.setupCurrentHouse(chosenHouse: House(Address: "19726 Wheaton Drive", Image: UIImage()))
    }
}
