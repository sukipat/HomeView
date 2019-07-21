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
    override func loadView() {
        view = houseView
        houseView.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        RoomTableController.shared.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        houseView.roomTable.reloadData()
    }
    
}

// MARK: - Actions
extension HouseViewController {
    func requestCameraPermission(completed: @escaping (Bool) -> Void) {
        if AVCaptureDevice.authorizationStatus(for: .video) != .authorized {
            AVCaptureDevice.requestAccess(for: .video, completionHandler: { accessGranted in
                completed(accessGranted)
            })
        } else {
            completed(true)
        }
    }
    
    func setupNavBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(presentImagePicker))
        
        guard let houseName = DataController.shared.CurrentHouse?.Address else {
            navigationItem.title = "House"
            return
        }
        navigationItem.title = houseName
    }
    
    func getRoomName(completed: @escaping (String) -> Void) {
        
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

// MARK: - PresentRoomDelegate
extension HouseViewController: PresentRoomDelegate {
    func presentRoom(currentRoom: Room) {
        let roomView = RoomViewController()
        roomView.setImage(selectedImage: currentRoom.roomImage)
        roomView.setupNavBar(roomName: currentRoom.roomName)
        self.navigationController?.pushViewController(roomView, animated: true)
        print("TRYING TO SHOW ROOM")
    }
}

// MARK: - UIImagePickerControllerSetup
extension HouseViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @objc func presentImagePicker() {
        requestCameraPermission(completed: {(isAuthorized) -> Void in
            if isAuthorized == false {
                DispatchQueue.main.async {
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
                return
            }
            
            let imagePickerController = UIImagePickerController()
            imagePickerController.mediaTypes = ["public.image"]
            imagePickerController.allowsEditing = false
            imagePickerController.delegate = self
            imagePickerController.sourceType = .photoLibrary
            
           self.present(imagePickerController, animated: true)
        })
        
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
