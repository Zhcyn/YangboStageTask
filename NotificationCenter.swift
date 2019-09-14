//
//  NotificationCenter.swift
//  DoItToday
//
//  Created by nguyen.duc.huyb on 7/15/19.
//  Copyright © 2019 nguyen.duc.huyb. All rights reserved.
//

import UserNotifications

final class NotificationManager {
    static let shared = NotificationManager()
    
    let notificationCenter = UNUserNotificationCenter.current()
    let localID = "local_notification"
    private init() {}
}

extension NotificationManager {
    func handleLocalNotification(message: Message?, completionHandler: @escaping (String) -> Void) {
        // Request Notification Settings
        UNUserNotificationCenter.current().getNotificationSettings { [weak self] (notificationSettings) in
            guard let self = self else { return }
            guard let message = message else {
                completionHandler(ErrorMessages.messageIsNil.rawValue)
                return
            }
            
            switch notificationSettings.authorizationStatus {
            case .notDetermined:
                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (success, error) in
                    guard success else {
                        completionHandler("Request Authorization Failed \(error?.localizedDescription ?? "")")
                        return
                    }
                    // Schedule Local Notification
                    self.scheduleLocalNotification(message)
                }
            case .authorized:
                // Schedule Local Notification
                self.scheduleLocalNotification(message)
            case .denied:
                completionHandler(ErrorMessages.denied.rawValue)
            default:
                break
            }
        }
    }
    
    func scheduleLocalNotification(_ message: Message) {
        // Create Notification Content
        let notificationContent = UNMutableNotificationContent()
        
        // Configure Notification Content
        notificationContent.title = message.title
        notificationContent.body = message.body
        notificationContent.badge = 1
        notificationContent.sound = UNNotificationSound.default
        
        // Add Trigger
        let componentsFromDate = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: message.dateInterval)
        let notificationTrigger = UNCalendarNotificationTrigger(dateMatching: componentsFromDate, repeats: false)
        
        // Create Notification Request
        let notificationRequest = UNNotificationRequest(identifier: localID, content: notificationContent, trigger: notificationTrigger)
        
        // Add Request to User Notification Center
        UNUserNotificationCenter.current().add(notificationRequest) { (error) in
            if let error = error {
                print("Unable to Add Notification Request (\(error), \(error.localizedDescription))")
            }
        }
    }
    
    func setupLocalNotification(_ date: Date, message: String) {
        let message = Message(title: "Alert Message", body: message, dateInterval: date)
        NotificationManager.shared.handleLocalNotification(message: message) { errDesc in
            print(errDesc)
        }
    }
}
