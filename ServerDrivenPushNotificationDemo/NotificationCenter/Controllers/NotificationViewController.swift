//
//  NotificationViewController.swift
//  ServerDrivenPushNotificationDemo
//
//  Created by fatih on 3/28/19.
//

import UIKit

class NotificationViewController: UIViewController{
    /* Table View Datasource Variables*/
    var notificationList = [Any]()
    
    @IBOutlet weak var notificationTableView: UITableView!
    
    
}

//MARK: View Override Methods
extension NotificationViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
}

//MARK: Setup Methods
extension NotificationViewController{
    func setupView(){
        setupTableView()
    }
    func setupTableView(){
        self.notificationTableView.delegate = self
        self.notificationTableView.dataSource = self
        self.notificationTableView.register(UINib(nibName: "NotificationTableViewCell", bundle:nil), forCellReuseIdentifier: NotificationTableViewCell.reuseIdentifier)
        
    }
}


//MARK: Viewcontroller Init Methods
extension NotificationViewController{
    static func initializeViewController() -> NotificationViewController{
        return NotificationViewController(nibName: "NotificationViewController", bundle: nil)
    }
}
