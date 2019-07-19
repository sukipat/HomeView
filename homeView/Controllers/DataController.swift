//
//  DataController.swift
//  homeView
//
//  Created by Suki Patwardhan on 7/18/19.
//  Copyright © 2019 Suki Patwardhan. All rights reserved.
//

import Foundation

class DataController {
    static let shared = DataController()
    
    var CurrentRoom: Room?
    var CurrentHouse: House?
    
    func setupCurrentHouse(chosenHouse: House) {
        CurrentHouse = chosenHouse
    }
    
    func setupCurrentRoom(chosenRoom: Room) {
        CurrentRoom = chosenRoom
    }
}
