//
//  Page1Controller.swift
//  ServerDrivenPushNotificationDemo
//
//  Created by fatih on 4/4/19.
//

import UIKit

//Page type enum to handle navigation based on received notification payload
enum PageTypes :String{
    case page1 = "page_1"
    case page2 = "page_2"
    case page3 = "page_3"
    case page4 = "page_4"
}

//MARK: Override Methods
class Page1Controller: UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

//MARK: Initialize View Controller Methods
extension Page1Controller{
    static func initController()-> Page1Controller{
        return Page1Controller(nibName: "Page1Controller", bundle: nil)
    }
}
