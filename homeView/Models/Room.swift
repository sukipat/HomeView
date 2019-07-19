//
//  Room.swift
//  homeView
//
//  Created by Suki Patwardhan on 7/16/19.
//  Copyright © 2019 Suki Patwardhan. All rights reserved.
//

import UIKit

class Room {
    var roomName: String
    var roomImage: UIImage
    var pathways: [Pathway]
    
    init(roomName: String, roomImage: UIImage) {
        self.roomName = roomName
        self.roomImage = roomImage
        self.pathways = [Pathway]()
    }
    
    func addPath(pathwayToAdd: Pathway) {
        pathways.append(pathwayToAdd)
    }
}
