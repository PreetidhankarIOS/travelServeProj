//
//  TokenPermission.swift
//  Work2go
//
//  Created by Rajesh Gupta on 6/23/18.
//  Copyright © 2018 Rajesh Gupta. All rights reserved.
//

import UIKit
import Firebase
import FirebaseMessaging
import SlideMenuControllerSwift



extension AppDelegate : UNUserNotificationCenterDelegate {
    
    class func instance() -> AppDelegate {
          return UIApplication.shared.delegate as! AppDelegate
      }
    
    func requestNotificationAuthorization(application: UIApplication) {
        
        if #available(iOS 10.0, *){
            UNUserNotificationCenter.current().delegate = self
            let authOptions: UNAuthorizationOptions = [.alert,.badge,.sound]
            UNUserNotificationCenter.current().requestAuthorization(options: authOptions, completionHandler: { (success, error) in
            })
        }else{
            let settings: UIUserNotificationSettings = UIUserNotificationSettings(types: [.alert,.badge,.sound], categories: nil)
            application.registerUserNotificationSettings(settings)

        }
        
    }
    
    // Receive displayed notifications for iOS 10 devices.
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        if UIApplication.shared.applicationState == .active {
            completionHandler([.sound, .badge])
        }else
        {
            completionHandler([.alert, .sound, .badge])
        }

        let userInfo = notification.request.content.userInfo
        print("Message UserIfonation: \(userInfo)")
        // Print message ID.
        if let messageID = userInfo[kGCMMessageIDKey] {
           print("Message ID: \(messageID)")
        }

        guard let type = (userInfo["gcm.notification.MessageType"]) else {
            return
        }
        let msgType = NotificationType(rawValue: type as! String)!
        switch msgType {
        case .NEW_BOOKING:

           // NotificationCenter.default.post(name: Notification.Name("forNewBookingNotification"), object: nil, userInfo: userInfo)
            forNewBooking()
            break
        case  .CANCEL_BOOKING:

          guard let fileBookingId = (userInfo["gcm.notification.FileBookingId"]) else {
             return
         }
         recalledBooking(fileBookingId as! String)
            
            break
        case .PAST_BOOKING:
                ForPastBooking()
            break
        case .LOGOUT:
            NotificationCenter.default.post(name: Notification.Name("logoutNotification"), object: nil, userInfo: userInfo)
            break
        case .RECALLED_BOOKING:

//         guard let fileBookingId = (userInfo["gcm.notification.FileBookingId"]) else {
//            return
//        }
//        recalledBooking(fileBookingId as! String)

            break
        case .MESSAGE:
            guard let chatType = (userInfo["gcm.notification.ChatType"]) else {
                return
            }
            if chatType as! String == "General" {
                debugPrint(chatType)
            ForChatView()
            NotificationCenter.default.post(name: Notification.Name("GernalaChatNotification"), object: nil, userInfo: userInfo)
            }
            break
        case .POOL:
         forPoolJob()
            break
        case .bookingUpdated:

               break
        }

        completionHandler([])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        // Print message ID.
        if let messageID = userInfo[kGCMMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        completionHandler()
    }
}
extension AppDelegate : MessagingDelegate {
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
        
        print("Firebase registration token: \(fcmToken)")
       // UserDefaults.standard.setToken(value: fcmToken)
        UserDetail.shared.setUserToken_id(fcmToken)
        InstanceID.instanceID().instanceID { (result, error) in
            if let error = error {
               print("Error fetching remote instange ID: \(error)")
            } else if let result = result {
                print("Remote instance ID token: \(result.token)")
                
                UserDetail.shared.setUserToken_id(result.token)
//                self.instanceIDTokenMessage.text  = "Remote InstanceID token: \(result.token)"
            }
        }
    }
    
    func application(application: UIApplication,
                     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        Messaging.messaging().apnsToken = deviceToken as Data
         print("Remote instance ID token: \(deviceToken)")
         UserDetail.shared.setUserToken_id("\(deviceToken)")
        
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {


        
        UIApplication.shared.applicationIconBadgeNumber = 0

        if let messageID = userInfo[kGCMMessageIDKey] {
            print("Message ID: \(messageID)")
            
        }
        if UIApplication.shared.applicationState == .active {
            
            guard let type = (userInfo["gcm.notification.MessageType"]) else {
                return
            }
            
            let msgType = NotificationType(rawValue: type as! String)!
            switch msgType {
            case .NEW_BOOKING:
                
                forNewBooking()
                
                break
            case  .CANCEL_BOOKING:
                
                guard let fileBookingId = (userInfo["gcm.notification.FileBookingId"]) else {
                     return
                 }
                 recalledBooking(fileBookingId as! String)
                
                break
            case .PAST_BOOKING:
                
                ForPastBooking()
                
                break
            case .LOGOUT:
                
                NotificationCenter.default.post(name: Notification.Name("logoutNotification"), object: nil, userInfo: userInfo)
                
                break
            case .RECALLED_BOOKING:
            
//                guard let fileBookingId = (userInfo["gcm.notification.FileBookingId"]) else {
//                   return
//               }
//               recalledBooking(fileBookingId as! String)
                
                break
                
            case .MESSAGE:
                
                guard let chatType = (userInfo["gcm.notification.ChatType"]) else {
                    return
                }
                if chatType as! String == "General" {
                    NotificationCenter.default.post(name: Notification.Name("GernalaChatNotification"), object: nil, userInfo: userInfo)
                }
                    
                // ForChatView()
                
                break
            case .POOL :
                
                forPoolJob()
                
                break
                
            case .bookingUpdated:
                
                break
            }
            

       }
     if UIApplication.shared.applicationState == .inactive {
            
        
            guard let type = (userInfo["gcm.notification.MessageType"]) else {
                return
            }
            
            let msgType = NotificationType(rawValue: type as! String)!
            switch msgType {
            case .NEW_BOOKING:
                
                forNewBooking()
                
                break
            case  .CANCEL_BOOKING:
                
                guard let fileBookingId = (userInfo["gcm.notification.FileBookingId"]) else {
                     return
                 }
                 recalledBooking(fileBookingId as! String)
                
                break
            case .PAST_BOOKING:
                
                ForPastBooking()
                
                break
            case .LOGOUT:
                
                NotificationCenter.default.post(name: Notification.Name("logoutNotification"), object: nil, userInfo: userInfo)
                
                break
            case .RECALLED_BOOKING:
//              guard let fileBookingId = (userInfo["gcm.notification.FileBookingId"]) else {
//                   return
//               }
//               recalledBooking(fileBookingId as! String)
              
                break
                
            case .MESSAGE:
                
                guard let chatType = (userInfo["gcm.notification.ChatType"]) else {
                    return
                }
                if chatType as! String == "General" {
                    NotificationCenter.default.post(name: Notification.Name("GernalaChatNotification"), object: nil, userInfo: userInfo)
                }

                break
            case .POOL :
                
                forPoolJob()
                
                break
                
            case .bookingUpdated:
                break
        }
            
        }else if UIApplication.shared.applicationState == .background {
            debugPrint("background")
            
            guard let type = (userInfo["gcm.notification.MessageType"]) else {
                return
            }
            
            let msgType = NotificationType(rawValue: type as! String)!
            switch msgType {
            case .NEW_BOOKING:
                
                  forNewBooking()
                
                break
            case  .CANCEL_BOOKING:
                
                guard let fileBookingId = (userInfo["gcm.notification.FileBookingId"]) else {
                        return
                    }
                    recalledBooking(fileBookingId as! String)
                
                break
            case .PAST_BOOKING:
                
               ForPastBooking()
                
                break
            case .LOGOUT:
                
                UserDefaults.standard.set(true, forKey: logoutBackgroundNotification)
                NotificationCenter.default.post(name: Notification.Name("logoutNotification"), object: nil, userInfo: userInfo)
                
                break
            case .RECALLED_BOOKING:
                
//                guard let fileBookingId = (userInfo["gcm.notification.FileBookingId"]) else {
//                    return
//                }
//                recalledBooking(fileBookingId as! String)
                
                break
            case .MESSAGE:
                
                guard let chatType = (userInfo["gcm.notification.ChatType"]) else {
                    return
                }
                if chatType as! String == "General" {
                ForChatView()
                    NotificationCenter.default.post(name: Notification.Name("GernalaChatNotification"), object: nil, userInfo: userInfo)
            }
                break
            case .POOL :
                
                forPoolJob()
                
                break
            case .bookingUpdated:
                
                break
        }

        }
       print(userInfo)
        completionHandler(.newData)
        
    }

func forPoolJob(){
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mainViewController = storyboard.instantiateViewController(withIdentifier: "poolViewController")
            as! poolViewController
        let leftViewController = storyboard.instantiateViewController(withIdentifier: "menuViewController") as! menuViewController
        let nvc: UINavigationController = UINavigationController(rootViewController: mainViewController)
        leftViewController.jobPoolVC = nvc
        
        let slideMenuController = SlideMenuController(mainViewController: nvc, leftMenuViewController: leftViewController)
        slideMenuController.automaticallyAdjustsScrollViewInsets = true
        self.window?.rootViewController = slideMenuController
    }

    func ForChatView(){
        
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let mainViewController = storyboard.instantiateViewController(withIdentifier: "chatViewController")
                as! chatViewController
            let leftViewController = storyboard.instantiateViewController(withIdentifier: "menuViewController") as! menuViewController
            let nvc: UINavigationController = UINavigationController(rootViewController: mainViewController)
            leftViewController.chatVc = nvc

            let slideMenuController = SlideMenuController(mainViewController: nvc, leftMenuViewController: leftViewController)
            slideMenuController.automaticallyAdjustsScrollViewInsets = true
            self.window?.rootViewController = slideMenuController
        
        
    }
    
    
    func ForPastBooking(){
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mainViewController = storyboard.instantiateViewController(withIdentifier: "RideCompletedViewController")
            as! RideCompletedViewController
        let leftViewController = storyboard.instantiateViewController(withIdentifier: "menuViewController") as! menuViewController
        let nvc: UINavigationController = UINavigationController(rootViewController: mainViewController)
        leftViewController.RideCompletedVC = nvc
        
        let slideMenuController = SlideMenuController(mainViewController: nvc, leftMenuViewController: leftViewController)
        slideMenuController.automaticallyAdjustsScrollViewInsets = true
        self.window?.rootViewController = slideMenuController
        
    }
    
    
    func forNewBooking(){
        
        
        let alert = UIAlertController(title: "Wow", message: "You got a new job.", preferredStyle: .alert)

           let actionYes = UIAlertAction(title: "Yes", style: .default, handler: { action in
            
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let mainViewController = storyboard.instantiateViewController(withIdentifier: "upcomingRequestViewController")
                        as! upcomingRequestViewController
                    let leftViewController = storyboard.instantiateViewController(withIdentifier: "menuViewController") as! menuViewController
                    let nvc: UINavigationController = UINavigationController(rootViewController: mainViewController)
                    leftViewController.UpcomingRequestVC = nvc
                    let slideMenuController = SlideMenuController(mainViewController: nvc, leftMenuViewController: leftViewController)
                    slideMenuController.automaticallyAdjustsScrollViewInsets = true
                    self.window?.rootViewController = slideMenuController
            
           })

        
        
           let actionCancel = UIAlertAction(title: "Cancel", style: .destructive, handler: { action in
               print("Handler CANCEL")
           })

           alert.addAction(actionYes)
           alert.addAction(actionCancel)

           DispatchQueue.main.async {
               self.window?.rootViewController?.present(alert, animated: true, completion: nil)
           }
        
    
        
    }
    
    
    
    func recalledBooking(_ fileBookingId: String){
        
        let alert = UIAlertController(title: "Alert!", message: "Your BookingId-\(fileBookingId) Have Been Recalled,So Please ignore this Booking", preferredStyle: .alert)

              let actionYes = UIAlertAction(title: "Yes", style: .default, handler: { action in
               
                       let storyboard = UIStoryboard(name: "Main", bundle: nil)
                       let mainViewController = storyboard.instantiateViewController(withIdentifier: "upcomingRequestViewController")
                           as! upcomingRequestViewController
                       let leftViewController = storyboard.instantiateViewController(withIdentifier: "menuViewController") as! menuViewController
                       let nvc: UINavigationController = UINavigationController(rootViewController: mainViewController)
                       leftViewController.UpcomingRequestVC = nvc
                       let slideMenuController = SlideMenuController(mainViewController: nvc, leftMenuViewController: leftViewController)
                       slideMenuController.automaticallyAdjustsScrollViewInsets = true
                       self.window?.rootViewController = slideMenuController
               
              })

              let actionCancel = UIAlertAction(title: "Cancel", style: .destructive, handler: { action in
                  print("Handler CANCEL")
              })

              alert.addAction(actionYes)
              alert.addAction(actionCancel)

              DispatchQueue.main.async {
                  self.window?.rootViewController?.present(alert, animated: true, completion: nil)
              }
    }
     

}

enum NotificationType :String {
    
        case PAST_BOOKING =  "past booking"
        case LOGOUT =  "logout"
        case NEW_BOOKING = "new booking"
        case CANCEL_BOOKING  = "cancel booking"
        case RECALLED_BOOKING = "recalled booking"
        case MESSAGE = "message"
        case POOL = "Pool Booking"
        case bookingUpdated = "booking updated"

}


