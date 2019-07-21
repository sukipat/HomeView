//
//  RoomViewController.swift
//  homeView
//
//  Created by Suki Patwardhan on 7/20/19.
//  Copyright © 2019 Suki Patwardhan. All rights reserved.
//

import UIKit

class RoomViewController: UIViewController {
    let roomView = RoomView()
    
    override func loadView() {
        view = roomView
        roomView.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: - Actions
extension RoomViewController {
    func setImage(selectedImage: UIImage) {
        roomView.pictureView.image = selectedImage
        
        let viewHeight = UIScreen.main.bounds.height
        let imageHeight = selectedImage.size.height
        let imageWidth = selectedImage.size.width
        let scaleFactor = viewHeight/imageHeight
        roomView.pictureView.widthAnchor.constraint(equalToConstant: CGFloat(scaleFactor*imageWidth)).isActive = true
    }
    
    func setupNavBar(roomName: String) {
        self.navigationItem.title = roomName
    }
}

// MARK: - RoomViewDelegate
extension RoomViewController: RoomViewDelegate {
    
}
