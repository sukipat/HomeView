//
//  FindHouseView.swift
//  homeView
//
//  Created by Suki Patwardhan on 7/18/19.
//  Copyright © 2019 Suki Patwardhan. All rights reserved.
//

import UIKit

protocol FindHouseViewDelegate: class {
    func showhouse()
}

class FindHouseView: UIView {
    // MARK: - Properties
    weak var delegate: FindHouseViewDelegate?
    
    lazy var chooseHouseButton: UIButton = {
        let button = UIButton(type: UIButton.ButtonType.system)
        button.setTitle("Open House", for: UIControl.State.normal)
        button.addTarget(self, action: #selector(presentHouse), for: .touchUpInside)
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
        
        self.addSubview(chooseHouseButton)
    }
    
    func layoutView() {
        chooseHouseButton.translatesAutoresizingMaskIntoConstraints = false
        chooseHouseButton.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor).isActive = true
        chooseHouseButton.centerYAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerYAnchor).isActive = true
    }
}

// MARK: - Actions
extension FindHouseView {
    @objc func presentHouse() {
        delegate?.showhouse()
    }
}
