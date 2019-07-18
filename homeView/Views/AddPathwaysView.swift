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
    func addPath(recognizer: UITapGestureRecognizer)
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
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(pictureTapped(_ :)))
        imageView.addGestureRecognizer(tapRecognizer)
        return imageView
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
        
        self.addSubview(scrollView)
        scrollView.addSubview(pictureView)
    }
    
    func layoutView() {
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
}

// MARK: - Actions
extension AddPathwaysView {
    
    @objc func pictureTapped(_ tapRecognizer: UITapGestureRecognizer) {
        delegate?.addPath(recognizer: tapRecognizer)
    }
}
