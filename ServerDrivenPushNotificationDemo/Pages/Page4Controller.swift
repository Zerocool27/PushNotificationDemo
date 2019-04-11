//
//  Page4Controller.swift
//  ServerDrivenPushNotificationDemo
//
//  Created by fatih on 4/4/19.
//

import UIKit

class Page4Controller: UIViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension Page4Controller{
    static func initController()-> Page4Controller{
        return Page4Controller(nibName: "Page4Controller", bundle: nil)
    }
}
