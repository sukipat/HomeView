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
    
    func setupNavBar(roomName: String) {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(addRoom))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelAdd))
        self.navigationItem.title = roomName
    }
    
    @objc func addRoom() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func cancelAdd() {
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: - AddPathwaysViewDelegate
extension AddPathwaysViewController: AddPathwaysDelegate {
    
    func addPath(recognizer: UITapGestureRecognizer) {
        let location = recognizer.location(in: self.view.superview)
        print(location.x)
    }
}

// MARK: - ScrollViewDelegate
extension AddPathwaysViewController: UIScrollViewDelegate {
    func setUpScrollView() {
        addPathView.scrollView.delegate = self
    }
}
