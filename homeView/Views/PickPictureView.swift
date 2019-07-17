//
//  PictureView.swift
//  homeView
//
//  Created by Suki Patwardhan on 7/16/19.
//  Copyright © 2019 Suki Patwardhan. All rights reserved.
//

import UIKit

// MARK: - PictureViewDelegate
protocol PickPictureDelegate: class {
    func presentImagePicker()
}

class PickPictureView: UIView {
    // MARK: - Properties
    weak var delegate: PickPictureDelegate?
    
    lazy var pickImageButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.setTitle("Pick Image", for: .normal)
        button.addTarget(self, action: #selector(openImagePicker(_:)), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        layoutView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        addSubviews()
        layoutView()
    }
    
    func addSubviews() {
        backgroundColor = .white
        
        self.addSubview(pickImageButton)
    }
    
    func layoutView() {
        pickImageButton.translatesAutoresizingMaskIntoConstraints = false
        pickImageButton.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor).isActive = true
        pickImageButton.centerYAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerYAnchor).isActive = true
    }
}

// MARK: - Actions
extension PickPictureView {
    @objc func openImagePicker(_ button: UIButton) {
        delegate?.presentImagePicker()
    }
}
