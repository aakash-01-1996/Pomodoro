//
//  PomodoroNotification.swift
//  Pomodoro Timer
//
//  Created by Aakash Ambodkar
//

import Foundation
import UserNotifications

class PomodoroNotification {
    
    static func checkAuthorization(completion: @escaping (Bool) -> Void) {
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.getNotificationSettings { settings in
            switch settings.authorizationStatus {
            case .authorized:
                completion(true)
            
            case .denied:
                completion(false)
            
            case .notDetermined:
                notificationCenter.requestAuthorization(options: [.alert, .badge, .sound]) { allowed, error in
                        completion(allowed)
                }
                
            default:
                completion(false)
            }
        }
    }
    
    static func scheduleNotification(seconds: TimeInterval, title: String, body: String) {
        let notificationCenter = UNUserNotificationCenter.current()
        
        // remove all notifications
        notificationCenter.removeAllDeliveredNotifications()
        notificationCenter.removeAllPendingNotificationRequests()
        
        // setup the content
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = .default
        content.sound = UNNotificationSound(named: UNNotificationSoundName(rawValue: PomodoroAudioSounds.done.resource))
        
        // Trigger Notification
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: seconds, repeats: false)
        
        // Creating request
        let request = UNNotificationRequest(identifier: "my-notification", content: content, trigger: trigger)
        
        // add Notification to center
        notificationCenter.add(request)
        
    }
}
