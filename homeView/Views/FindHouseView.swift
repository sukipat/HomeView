//
//  FindHouse.swift
//  homeView
//
//  Created by Suki Patwardhan on 7/14/19.
//  Copyright © 2019 Suki Patwardhan. All rights reserved.
//

import UIKit
import MapKit

protocol FindHouseViewDelegate: class {
}

class FindHouseView: UIView {
    weak var delegate: FindHouseViewDelegate?
    
    lazy var mapView = MKMapView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        layoutViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        addSubviews()
        layoutViews()
    }
    
    
    func addSubviews() {
        backgroundColor = .white
        
        self.addSubview(mapView)
    }
    
    func layoutViews() {
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor).isActive = true
        mapView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor).isActive = true
        mapView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor).isActive = true
        mapView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor).isActive = true
        
    }
}
