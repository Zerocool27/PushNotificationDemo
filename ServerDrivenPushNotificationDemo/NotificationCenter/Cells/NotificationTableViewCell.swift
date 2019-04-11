//
//  NotificationTableViewCell.swift
//  ServerDrivenPushNotificationDemo
//
//  Created by fatih on 3/28/19.
//

import UIKit

class NotificationTableViewCell: UITableViewCell {
    static let reuseIdentifier = "NotificationTableViewCell"
    @IBOutlet weak var notificationImage: UIImageView!
    @IBOutlet weak var notificationText: UILabel!
    @IBOutlet weak var notificationDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
