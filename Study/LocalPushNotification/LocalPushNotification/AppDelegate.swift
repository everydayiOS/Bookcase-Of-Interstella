//
//  AppDelegate.swift
//  LocalPushNotification
//
//  Created by JinBae Jeong on 2020/09/29.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
    let center = UNUserNotificationCenter.current()
    center.delegate = self
    
    return true
  }

}

extension AppDelegate: UNUserNotificationCenterDelegate {
  func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
    completionHandler()
  }
  
  func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
    // iOS 14부터는 .alert이 사라짐 (대신 list, banner 사용)
    if #available(iOS 14, *) {
      completionHandler([.list, .banner, .badge, .sound])
    } else {
      completionHandler([.alert, .badge, .sound])
    }
  }
}
