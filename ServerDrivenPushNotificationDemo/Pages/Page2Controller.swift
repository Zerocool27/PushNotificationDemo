//
//  Page2Controller.swift
//  ServerDrivenPushNotificationDemo
//
//  Created by fatih on 4/4/19.
//

import UIKit

class Page2Controller: UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension Page2Controller{
    static func initController()-> Page2Controller{
        return Page2Controller(nibName: "Page2Controller", bundle: nil)
    }
}
