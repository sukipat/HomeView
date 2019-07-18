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
    var imageName: String
    var pathways: [Pathway]
    
    init(roomName: String, imageName: String, pathways: [Pathway]) {
        self.roomName = roomName
        self.imageName = imageName
        self.pathways = pathways
    }
    
    func addPath(pathwayToAdd: Pathway) {
        pathways.append(pathwayToAdd)
    }
}
