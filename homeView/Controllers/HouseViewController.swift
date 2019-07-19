//
//  PictureViewController.swift
//  homeView
//
//  Created by Suki Patwardhan on 7/16/19.
//  Copyright © 2019 Suki Patwardhan. All rights reserved.
//

import UIKit
import AVFoundation

class HouseViewController: UIViewController {
    // MARK: - Propertiess
    let houseView = HouseView()
    typealias receivedRoomName = (String) -> Void

    override func loadView() {
        view = houseView
        houseView.delegate = self
        houseView.roomTable.dataSource = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        houseView.roomTable.reloadData()
    }
    
}

// MARK: - Actions
extension HouseViewController {
    func requestCameraPermission() -> AVAuthorizationStatus {
        var isAuthorized = false
        if AVCaptureDevice.authorizationStatus(for: .video) != .authorized {
            AVCaptureDevice.requestAccess(for: .video, completionHandler: { accessGranted in
                isAuthorized = accessGranted
            })
        } else { isAuthorized = true }
        if isAuthorized { return .authorized } else { return .restricted }
    }
    
    func setupNavBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(presentImagePicker))
        
        guard let houseName = DataController.shared.CurrentHouse?.Address else {
            navigationItem.title = "House"
            return
        }
        navigationItem.title = houseName
    }
    
    func getRoomName(completed: @escaping receivedRoomName) {
        
        var roomName = "Room"
        
        let alert = UIAlertController(title: "What room is this?", message: "This is how you will refer to this room in images", preferredStyle: .alert)
        alert.addTextField(configurationHandler: {(textField) in
            textField.placeholder = "Room Name"
        })
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields!.first
            roomName = textField?.text ?? "Room"
            
            completed(roomName)
        }))
        
        self.present(alert, animated: true)
    }

}


// MARK: - HouseViewDelegate
extension HouseViewController: HouseViewDelegate {
    
}

// MARK: - UITableViewDelegate
extension HouseViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let numberOfRooms = DataController.shared.CurrentHouse?.Rooms.count else {
            return 5
        }
        return numberOfRooms
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "roomCell", for: indexPath as IndexPath)
        guard let roomName = DataController.shared.CurrentHouse?.Rooms[indexPath.row].roomName else {
            cell.textLabel?.text =  "No name"
            return cell
        }
        cell.textLabel?.text = roomName
        return cell
    }
}

// MARK: - UIImagePickerControllerSetup
extension HouseViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @objc func presentImagePicker() {
        let cameraAuthStatus = requestCameraPermission()
        
        if cameraAuthStatus == .restricted {
            let alertController = UIAlertController.init(title: nil, message: "Plase turn on Camera Access in Settings", preferredStyle: .alert)
            let okAction = UIAlertAction.init(title: "Ok", style: .default, handler: nil)
            let settingsAction = UIAlertAction.init(title: "Settings", style: .default, handler: {(alert: UIAlertAction!) in
                let settingsURL = URL(string: UIApplication.openSettingsURLString)!
                if UIApplication.shared.canOpenURL(settingsURL) {
                    UIApplication.shared.open(settingsURL, options: [:], completionHandler: nil)
                }
            })
            alertController.addAction(settingsAction)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.mediaTypes = ["public.image"]
        imagePickerController.allowsEditing = false
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        
        present(imagePickerController, animated: true)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        
        guard let chosenImage = info[.originalImage] as? UIImage else {
            print("No image found")
            return
        }
        
        let addPathwaysController = AddPathwaysViewController()
        
        
        getRoomName(completed: {roomName -> Void in
            addPathwaysController.setImage(selectedImage: chosenImage)
            DataController.shared.setupCurrentRoom(chosenRoom: Room(roomName: roomName, roomImage: chosenImage))
            addPathwaysController.setupNavBar()
            self.navigationController?.pushViewController(addPathwaysController, animated: true)
        })
        
    }
}
