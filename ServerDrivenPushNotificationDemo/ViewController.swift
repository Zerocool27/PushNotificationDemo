//
//  ViewController.swift
//  ServerDrivenPushNotificationDemo
//
//  Created by fatih on 3/27/19.
//

import UIKit

class ViewController: UIViewController {

    @IBAction func showNotificationsOnClick(_ sender: Any) {
        
        self.navigationController?.pushViewController(NotificationViewController.initializeViewController(), animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    

}

