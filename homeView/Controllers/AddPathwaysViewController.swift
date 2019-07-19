//
//  AddPathwaysViewController.swift
//  homeView
//
//  Created by Suki Patwardhan on 7/16/19.
//  Copyright © 2019 Suki Patwardhan. All rights reserved.
//

import UIKit

class AddPathwaysViewController: UIViewController {
    // MARK: - Properties
    let addPathView = AddPathwaysView()
    typealias receivedRoomName = (String) -> Void

    override func loadView() {
        view = addPathView
        addPathView.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpScrollView()
    }
}

// MARK: - Actions
extension AddPathwaysViewController {
    
    func setImage(selectedImage: UIImage) {
        addPathView.pictureView.image = selectedImage

        let viewHeight = UIScreen.main.bounds.height
        let imageHeight = selectedImage.size.height
        let imageWidth = selectedImage.size.width
        let scaleFactor = viewHeight/imageHeight
        addPathView.pictureView.widthAnchor.constraint(equalToConstant: CGFloat(scaleFactor*imageWidth)).isActive = true
    }
    
    func setupNavBar() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(addRoom))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelAdd))
        self.navigationItem.title = DataController.shared.CurrentRoom?.roomName
    }
    
    func getResultingRoom(completed: @escaping receivedRoomName) {
        
        var roomName = "Room"
        
        let alert = UIAlertController(title: "What room does this pathway lead to?", message: "Please be consistent in naming your rooms.", preferredStyle: .alert)
        alert.addTextField(configurationHandler: {(textField) in
            textField.placeholder = "Room Name"
        })
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields!.first
            roomName = textField?.text ?? "Room"
            
            completed(roomName)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        
        self.present(alert, animated: true)
    }
    
    func pathwayExists(existingPathway: Pathway) {
        let alert = UIAlertController(title: "Pathway to \(existingPathway.resultingRoom) already exists here.", message: nil , preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    @objc func addRoom() {
        DataController.shared.CurrentHouse?.addRoom(roomToAdd: DataController.shared.CurrentRoom!)
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func cancelAdd() {
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: - AddPathwaysViewDelegate
extension AddPathwaysViewController: AddPathwaysDelegate {
    
    func addPath(recognizer: UITapGestureRecognizer) {
        let location = recognizer.location(in: addPathView.pictureView)
        let imageWidth = addPathView.pictureView.frame.size.width
        let xPercent = location.x/imageWidth
        
        var currentPathway: Pathway? = nil
        for pathway in DataController.shared.CurrentRoom!.pathways {
            if xPercent > pathway.xPercent - 5 && xPercent < pathway.xPercent + 5{
                currentPathway = pathway
                break
            }
        }
        
        if currentPathway == nil {
            getResultingRoom(completed: { roomName -> Void in
                DataController.shared.CurrentRoom?.addPath(pathwayToAdd: Pathway(resultingRoom: roomName, xPercent: xPercent))
            })
        } else {
            pathwayExists(existingPathway: currentPathway!)
        }
    }
}

// MARK: - ScrollViewDelegate
extension AddPathwaysViewController: UIScrollViewDelegate {
    func setUpScrollView() {
        addPathView.scrollView.delegate = self
    }
}
