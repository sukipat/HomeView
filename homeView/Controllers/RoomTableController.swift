//
//  RoomTableController.swift
//  homeView
//
//  Created by Suki Patwardhan on 7/19/19.
//  Copyright © 2019 Suki Patwardhan. All rights reserved.
//

import UIKit

protocol PresentRoomDelegate: class {
    func presentRoom(currentRoom: Room)
}
class RoomTableController: UITableViewController {
    static let shared = RoomTableController()
    weak var delegate: PresentRoomDelegate?
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let numberOfRooms = DataController.shared.CurrentHouse?.Rooms.count else {
            return 0
        }

        if numberOfRooms == 0 {
            setEmptyMessage("This house has no room currently")
        } else {
            restore()
        }
        return numberOfRooms
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "roomCell", for: indexPath as IndexPath) as! RoomTableCell
        guard let currentRoom = DataController.shared.CurrentHouse?.Rooms[indexPath.row] else {
            cell.room = Room(roomName: "House not initialized", roomImage: UIImage())
            return cell
        }
        cell.room = currentRoom
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let currentRoom = DataController.shared.CurrentHouse?.Rooms[indexPath.row] else {
            print("No current house selected")
            return
        }
        delegate?.presentRoom(currentRoom: currentRoom)
        
    }
    
}

// MARK: - BackgroundView
extension RoomTableController {
    func setEmptyMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        messageLabel.text = message
        messageLabel.textColor = .black
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont(name: "TrebuchetMS", size: 15)
        messageLabel.sizeToFit()
        
        self.tableView.backgroundView = messageLabel
        self.tableView.separatorStyle = .none
    }
    
    func restore() {
        self.tableView.backgroundView = nil
        self.tableView.separatorStyle = .singleLine
    }
}
