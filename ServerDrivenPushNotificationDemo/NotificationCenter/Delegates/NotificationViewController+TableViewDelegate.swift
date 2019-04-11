//
//  NotificationViewController+TableViewDelegate.swift
//  ServerDrivenPushNotificationDemo
//
//  Created by fatih on 3/28/19.
//

import UIKit

//MARK: Table View Delegate
extension NotificationViewController: UITableViewDelegate{
    
    
}

//MARK: Table View Datasource
extension NotificationViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NotificationTableViewCell.reuseIdentifier, for: indexPath) as! NotificationTableViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    
}
