//
//  ViewController.swift
//  LocalPushNotification
//
//  Created by JinBae Jeong on 2020/09/29.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {
  
  private let cache: NSCache = NSCache<NSString, UIImage>()
  let userNotificationCenter = UNUserNotificationCenter.current()

  override func viewDidLoad() {
    super.viewDidLoad()
    
    requestNotificationAuthorization()
    sendNotification(seconds: 10)
  }
  
  func requestNotificationAuthorization() {
    let authOptions = UNAuthorizationOptions(arrayLiteral: .alert, .badge, .sound)
    
    userNotificationCenter.requestAuthorization(options: authOptions) { success, error in
      if let error = error {
        print("Error: \(error)")
      }
    }
  }
  
  func sendNotification(seconds: Double) {
    let notificationContent = UNMutableNotificationContent()
    
    notificationContent.title = "알림 테스트"
    notificationContent.body = "알림 테스트 중"
    notificationContent.sound = UNNotificationSound.default
    notificationContent.categoryIdentifier = "image-message"
    
    // UserDefaults에 저장한 이미지를 불러오면 될듯?
//    let imageURLString = "https://i.ytimg.com/vi/7qkbRYM7YP8/maxresdefault.jpg"
//    guard let imageURL:URL = URL(string: imageURLString) else { return }
//    do {
//      let attach = try UNNotificationAttachment(identifier: "image-test", url: imageURL, options: nil)
//      notificationContent.attachments = [attach]
//    } catch {
//      print(error)
//    }
    
    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: seconds, repeats: false)
    let request = UNNotificationRequest(identifier: "testNotification", content: notificationContent, trigger: trigger)
    
    userNotificationCenter.add(request) { error in
      if let error = error {
        print("Notification Error: ", error)
      }
    }
  }


}

extension ViewController: UNUserNotificationCenterDelegate {
  func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
    completionHandler()
  }
  
  func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
    if #available(iOS 14, *) {
      completionHandler([.list, .banner, .badge, .sound])
    } else {
      completionHandler([.alert, .badge, .sound])
    }
  }
}
