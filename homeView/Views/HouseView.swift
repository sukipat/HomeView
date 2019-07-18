//
//  PictureView.swift
//  homeView
//
//  Created by Suki Patwardhan on 7/16/19.
//  Copyright © 2019 Suki Patwardhan. All rights reserved.
//

import UIKit

// MARK: - PictureViewDelegate
protocol HouseViewDelegate: class {
}

class HouseView: UIView {
    // MARK: - Properties
    weak var delegate: HouseViewDelegate?
    
    lazy var roomTable: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "roomCell")
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        layoutView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        addSubviews()
        layoutView()
    }
    
    func addSubviews() {
        backgroundColor = .white
        
        self.addSubview(roomTable)
    }
    
    func layoutView() {
        roomTable.translatesAutoresizingMaskIntoConstraints = false
        roomTable.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor).isActive = true
        roomTable.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor).isActive = true
        roomTable.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor).isActive = true
        roomTable.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor).isActive = true
    }
}

// MARK: - Actions
extension HouseView {
}
