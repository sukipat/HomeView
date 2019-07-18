//
//  House.swift
//  homeView
//
//  Created by Suki Patwardhan on 7/14/19.
//  Copyright © 2019 Suki Patwardhan. All rights reserved.
//

import UIKit

class House {
    var Address: String
    var Image: UIImage
    var Rooms: [Room]
    
    init(Address: String, Image: UIImage) {
        self.Address = Address
        self.Image = Image
        self.Rooms = [Room]()
    }
    
    func addRoom(roomToAdd: Room) {
        Rooms.append(roomToAdd)
    }
}
