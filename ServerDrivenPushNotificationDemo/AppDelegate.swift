//
//  AppDelegate.swift
//  ServerDrivenPushNotificationDemo
//
//  Created by fatih on 3/27/19.
//

import UIKit
import UserNotifications
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    let gcmMessageIDKey = "YOUR_GCM_ID"
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        
        // [START set_messaging_delegate]
        Messaging.messaging().delegate = self
        // [END set_messaging_delegate]
        // Register for remote notifications. This shows a permission dialog on first run, to
        // show the dialog at a more appropriate time move this registration accordingly.
        // [START register_for_notifications]
        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self
            
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_, _ in })
        } else {
            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        
        application.registerForRemoteNotifications()
        
        // [END register_for_notifications]
        return true
    }
    
    // [START receive_message]
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
        // If you are receiving a notification message while your app is in the background,
        // this callback will not be fired till the user taps on the notification launching the application.
        // TODO: Handle data of notification
        // With swizzling disabled you must let Messaging know about the message, for Analytics
        // Messaging.messaging().appDidReceiveMessage(userInfo)
        // Print message ID.
        print("DID RECEIVE REMOTE NOTIFICATION")
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        
        if let userInfo = userInfo as? NSDictionary{
            handleNotificationPageNavigation(userInfo: userInfo)
        }
        // Print full message.
        print(userInfo)
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        // If you are receiving a notification message while your app is in the background,
        // this callback will not be fired till the user taps on the notification launching the application.
        // TODO: Handle data of notification
        // With swizzling disabled you must let Messaging know about the message, for Analytics
        // Messaging.messaging().appDidReceiveMessage(userInfo)
        // Print message ID.
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        print("DID RECEIVE REMOTE NOTIFICATION WITH HANDLER")
        // Print full message.
        print(userInfo)
        
        if let aps = userInfo["aps"] as? NSDictionary{
            handleBadgeCount(userInfo: aps)
        }
        completionHandler(UIBackgroundFetchResult.newData)
    }
    // [END receive_message]
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Unable to register for remote notifications: \(error.localizedDescription)")
    }
    
    // This function is added here only for debugging purposes, and can be removed if swizzling is enabled.
    // If swizzling is disabled then this function must be implemented so that the APNs token can be paired to
    // the FCM registration token.
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        print("APNs token retrieved: \(deviceToken)")
        
        // With swizzling disabled you must set the APNs token here.
        // Messaging.messaging().apnsToken = deviceToken
    }
}

// [START ios_10_message_handling]
@available(iOS 10, *)
extension AppDelegate : UNUserNotificationCenterDelegate {
    
    // Receive displayed notifications for iOS 10 devices.
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let userInfo = notification.request.content.userInfo
        
        // With swizzling disabled you must let Messaging know about the message, for Analytics
        // Messaging.messaging().appDidReceiveMessage(userInfo)
        // Print message ID.
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        print("WILL PRESENT REMOTE NOTIFICATION")
        
        //UPDATE BADGE COUNT WHILE APP IS OPENED
        if let aps = userInfo["aps"] as? NSDictionary{
            handleBadgeCount(userInfo: aps)
        }
        if let userInfo = userInfo as? NSDictionary{
            handleNotificationPageNavigation(userInfo: userInfo)
        }        // Print full message.
        print(userInfo)
        
        // Change this to your preferred presentation option
        completionHandler([])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        // Print message ID.
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        print("USER CLICKED TO NOTIFICATION")
        
        //RESET BADGE WHEN NOTIFICATION OPENED
//        UIApplication.shared.applicationIconBadgeNumber = 0
        
        
        
        if let userInfo = userInfo as? NSDictionary{
            handleNotificationPageNavigation(userInfo: userInfo)
        }
        // Print full message.
        print(userInfo)
        
        
        
        completionHandler()
    }
}
// [END ios_10_message_handling]

extension AppDelegate : MessagingDelegate {
    // [START refresh_token]
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
        print("Firebase registration token: \(fcmToken)")
        
        let dataDict:[String: String] = ["token": fcmToken]
        NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil, userInfo: dataDict)
        // TODO: If necessary send token to application server.
        // Note: This callback is fired at each app startup and whenever a new token is generated.
    }
    // [END refresh_token]
    // [START ios_10_data_message]
    // Receive data messages on iOS 10+ directly from FCM (bypassing APNs) when the app is in the foreground.
    // To enable direct data messages, you can set Messaging.messaging().shouldEstablishDirectChannel to true.
    func messaging(_ messaging: Messaging, didReceive remoteMessage: MessagingRemoteMessage) {
        print("Received data message: \(remoteMessage.appData)")
    }
    // [END ios_10_data_message]
    
    func handleNotificationPageNavigation(userInfo: NSDictionary){
        if let pageType = userInfo.object(forKey: "page_type")as? String{
            print("PAGE TYPE IS", pageType)
            let vc = UIApplication.shared.keyWindow?.rootViewController as? UINavigationController
            
            if pageType == PageTypes.page1.rawValue{
                vc?.pushViewController(Page1Controller.initController(), animated: true)
            }else if pageType == PageTypes.page2.rawValue{
                vc?.pushViewController(Page2Controller.initController(), animated: true)
            }else if pageType == PageTypes.page3.rawValue{
                vc?.pushViewController(Page3Controller.initController(), animated: true)
            }else if pageType == PageTypes.page4.rawValue{
                vc?.pushViewController(Page4Controller.initController(), animated: true)
            }
        }else{
            //OPEN NOTIFICATION CENTER IF NO PAGE TYPE DEFINED
            let vc = UIApplication.shared.keyWindow?.rootViewController as? UINavigationController
            vc?.pushViewController(NotificationViewController.initializeViewController(), animated: true)
        }
    }
    func handleBadgeCount(userInfo:NSDictionary){
        if let badge = (userInfo.object(forKey: "badge")as? NSString)?.intValue{
            UIApplication.shared.applicationIconBadgeNumber = Int(badge)
        }
    }
}
