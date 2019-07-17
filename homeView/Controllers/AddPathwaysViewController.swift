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
    let addPathways = AddPathwaysView()
    
    override func loadView() {
        view = addPathways
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpScrollView()
    }
}

// MARK: - Actions
extension AddPathwaysViewController {
    func setUpScrollView() {
        addPathways.scrollView.delegate = self
    }
    
    func setImage(selectedImage: UIImage) {
        addPathways.pictureView.image = selectedImage

        let viewHeight = UIScreen.main.bounds.height
        let imageHeight = selectedImage.size.height
        let imageWidth = selectedImage.size.width
        let scaleFactor = viewHeight/imageHeight
        addPathways.pictureView.widthAnchor.constraint(equalToConstant: CGFloat(scaleFactor*imageWidth)).isActive = true
    }
}

// MARK: - AddPathwaysViewDelegate
extension AddPathwaysViewController: AddPathwaysDelegate {
    func presentPicturePicker() {
        let pictureViewController = PickPictureViewController()
        self.navigationController?.pushViewController(pictureViewController, animated: true)
    }
}

// MARK: - ScrollViewDelegate
extension AddPathwaysViewController: UIScrollViewDelegate {
}
