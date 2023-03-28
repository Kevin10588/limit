//
//  NotificationsHandler.swift
//  FirebaseTest
//
//  Created by Angel Martinez on 2/28/23.
//
import SwiftUI
import Foundation
import UserNotifications

class NotificationHandler: NSObject, UNUserNotificationCenterDelegate {
    
    func askPermission() {
        UNUserNotificationCenter.current()
            .requestAuthorization(options:[.alert,.badge, .sound])
        {success, error in
            if success {
                print("Access Granted!")
            }
            else if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    func sendNotification(date: Date, type: String, timeInterval: Double = 10, title: String, body: String) {
        var trigger: UNNotificationTrigger?
        
        if type == "date" {
            let dateComponents = Calendar.current.dateComponents([.day, .month, .hour, .minute], from: date)
            trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        }
        else if type == "time" {
            trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInterval, repeats: false)
        }
        
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = UNNotificationSound.default
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().delegate = self

        UNUserNotificationCenter.current().add(request)
    }
    
    func userNotificationCenter (_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionhandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        completionhandler([.banner, .sound])
    }
}
