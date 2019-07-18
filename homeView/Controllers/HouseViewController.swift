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
    
    let houseView = HouseView()
    typealias receivedRoomName = (String) -> Void
    
    override func loadView() {
        view = houseView
        houseView.delegate = self
        houseView.roomTable.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar(houseName: "House")
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
    
    func setupNavBar(houseName: String) {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(presentImagePicker))
        navigationItem.title = houseName
    }
    
    func getRoomName(completed: @escaping receivedRoomName) {
        var roomName = "Room"
        
        let alert = UIAlertController(title: "What room is this?", message: "This is how you will refer to this room in images", preferredStyle: .alert)
        alert.addTextField(configurationHandler: {(textField) in
            textField.placeholder = "Room Name"
        })
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0]
            roomName = textField?.text ?? "Room"
            
            completed(roomName)
        }))
        
        present(alert, animated: true)
    }
    
}

// MARK: - HouseViewDelegate
extension HouseViewController: HouseViewDelegate {
    
}

// MARK: - UITableViewDelegate
extension HouseViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    private func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "roomCell", for: indexPath as IndexPath)
        cell.textLabel?.text = "Testing"
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
            addPathwaysController.setupNavBar(roomName: roomName)
            
            self.navigationController?.pushViewController(addPathwaysController, animated: true)
        })
        
    }
}
