//
//  RoomTableCell.swift
//  homeView
//
//  Created by Suki Patwardhan on 7/20/19.
//  Copyright © 2019 Suki Patwardhan. All rights reserved.
//

import UIKit

class RoomTableCell: UITableViewCell {
    var room: Room? {
        didSet {
            roomLabel.text = room?.roomName
        }
    }
    
    private let roomLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .left
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(roomLabel)
        roomLabel.translatesAutoresizingMaskIntoConstraints = false
        roomLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: -10).isActive = true
        roomLabel.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: 10).isActive = true
        roomLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor,constant: 10).isActive = true
        roomLabel.trailingAnchor.constraint(greaterThanOrEqualTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
