//
//  Page3Controller.swift
//  ServerDrivenPushNotificationDemo
//
//  Created by fatih on 4/4/19.
//

import UIKit

class Page3Controller: UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension Page3Controller{
    static func initController()-> Page3Controller{
        return Page3Controller(nibName: "Page3Controller", bundle: nil)
    }
}
