//
//  ViewController.swift
//  homeView
//
//  Created by Suki Patwardhan on 7/14/19.
//  Copyright © 2019 Suki Patwardhan. All rights reserved.
//

import UIKit

class BaseViewController<V: BaseView>: UIViewController {
    
    override func loadView() {
        view = V()
    }
    
    var customView: V {
        return view as! V
    }
}

