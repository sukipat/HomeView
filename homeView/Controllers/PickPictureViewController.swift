//
//  PictureViewController.swift
//  homeView
//
//  Created by Suki Patwardhan on 7/16/19.
//  Copyright © 2019 Suki Patwardhan. All rights reserved.
//

import UIKit
import AVFoundation

class PickPictureViewController: UIViewController {
    
    let pickPicture = PickPictureView()

    override func loadView() {
        view = pickPicture
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickPicture.delegate = self
    }
    
}

// MARK: - Actions
extension PickPictureViewController {
    func requestCameraPermission() -> AVAuthorizationStatus {
        var isAuthorized = false
        if AVCaptureDevice.authorizationStatus(for: .video) != .authorized {
            AVCaptureDevice.requestAccess(for: .video, completionHandler: { accessGranted in
                isAuthorized = accessGranted
            })
        } else { isAuthorized = true }
        if isAuthorized { return .authorized } else { return .restricted }
    }
    
    func getRoomName() -> String {
        var roomName = "Room"
        
        let alert = UIAlertController(title: "What room is this?", message: "This is how you will refer to this room in images", preferredStyle: .alert)
        alert.addTextField(configurationHandler: {(textField) in
            textField.placeholder = "Room Name"
        })
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0]
            roomName = textField?.text ?? "Room"
        }))
        
        self.present(alert, animated: true, completion: nil)
        return roomName
    }
}

// MARK: - PictureViewDelegate
extension PickPictureViewController: PickPictureDelegate {
    
    func presentImagePicker() {
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
    
}

// MARK: - UIImagePickerControllerSetup
extension PickPictureViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        
        guard let chosenImage = info[.originalImage] as? UIImage else {
            print("No image found")
            return
        }
        
        let addPathwaysController = AddPathwaysViewController()
        
        addPathwaysController.setImage(selectedImage: chosenImage)
        present(addPathwaysController, animated: true)
    }
}

