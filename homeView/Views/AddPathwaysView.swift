//
//  AddPathwaysView.swift
//  homeView
//
//  Created by Suki Patwardhan on 7/16/19.
//  Copyright © 2019 Suki Patwardhan. All rights reserved.
//

import UIKit

// MARK: - AddPathwaysDelegate
protocol AddPathwaysDelegate: class {
    func presentPicturePicker()
}


class AddPathwaysView: UIView {
    // MARK: - Properties
    weak var delegate: AddPathwaysDelegate?
    
    lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.isScrollEnabled = true
        scroll.maximumZoomScale = 3
        return scroll
    }()
    
    lazy var pictureView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = UIImageView.ContentMode.scaleAspectFill
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    lazy var navBar: UINavigationBar = {
        let navigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 132))
        return navigationBar
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
        setupDoneButton()
        
        self.addSubview(scrollView)
        scrollView.addSubview(pictureView)
        self.addSubview(navBar)
    }
    
    func layoutView() {
        navBar.translatesAutoresizingMaskIntoConstraints = false
        navBar.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor).isActive = true
        navBar.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor).isActive = true
        navBar.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor).isActive = true
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        pictureView.translatesAutoresizingMaskIntoConstraints = false
        pictureView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        pictureView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        pictureView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        pictureView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor).isActive = true
    }
    
    func setupDoneButton() {
        let navItem = UINavigationItem(title: "Test")
        let button = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: nil, action: #selector(showPicker))
        navItem.rightBarButtonItem = button
        navBar.setItems([navItem], animated: true)
    }
}

// MARK: - Actions
extension AddPathwaysView {
    @objc func showPicker() {
        delegate?.presentPicturePicker()
        print("trying to go home")
    }
}
