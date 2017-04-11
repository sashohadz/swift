//
//  AppDelegate.swift
//  photoStories
//
//  Created by Sasho Hadzhiev on 2/21/17.
//  Copyright © 2017 Sasho Hadzhiev. All rights reserved.
//
import UserNotifications
import UIKit
#if DEBUG
    import AdSupport
#endif
import Leanplum

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    enum Actions:String{
        case increment = "INCREMENT"
        case decrement = "DECREMENT"
    }
    
    var window: UIWindow?
    
    var welcomeMessage = LPVar.define("welcomeMessage",with: "Welcome to Leanplum!")
    var profileImage = LPVar.define("loginImage", withFile: "plum")

    
    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
        UNUserNotificationCenter.current().delegate = self
        return true
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        #if DEBUG
            Leanplum.setDeviceId("Deviced13123123")
//            Leanplum.setDeviceId(ASIdentifierManager.shared().advertisingIdentifier.uuidString)
            Leanplum.setAppId("app_Ct6WcCuzwLPZwDGwLFg3bc8A0VxKEEMbLuXBr6PvNK4",
                              withDevelopmentKey:"dev_WfRQHaMVNkKSNW015fgejFyborCNXdwAQrsC2LEaGPI")
        #else
            Leanplum.setAppId("app_Ct6WcCuzwLPZwDGwLFg3bc8A0VxKEEMbLuXBr6PvNK4",
                              withProductionKey: "prod_HySDSeoN8GshFmTRFlnThakIth5M15C6Hnu2qJv70iQ")
        #endif
        
        configureUserNotifications()
//        Leanplum.allowInterfaceEditing()
        Leanplum.setVerboseLoggingInDevelopmentMode(true)
        print("called start")
        Leanplum.start()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print("response received for: \(response.actionIdentifier))")
        //        Leanplum.handleAction(withIdentifier: response.actionIdentifier, forRemoteNotification: response.notification.request.content.userInfo, completionHandler: nil)
        completionHandler()
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        print(notification.request.content.userInfo)
        completionHandler(.alert)
    }

    func configureUserNotifications(){

        let incrementAction = UNNotificationAction(identifier: "INCREMENT", title: "INCREMENT", options: [])
        let decrementAction = UNNotificationAction(identifier: "DECREMENT", title: "DECREMENT", options: [])
        let category = UNNotificationCategory(identifier: "myNotificationCategory", actions: [incrementAction,decrementAction], intentIdentifiers: [], options: [])
        
        if #available(iOS 10.0, *) {
            print("IOS 10 push registration")
            let userNotifCenter = UNUserNotificationCenter.current()
            userNotifCenter.setNotificationCategories([category])
            
            userNotifCenter.requestAuthorization(options: [.badge,.alert,.sound]){ (granted,error) in
                if error == nil{
                    UIApplication.shared.registerForRemoteNotifications()
                } else {
                    print(error?.localizedDescription ?? "Error while registering push")
                }
            }
            
        }
        //iOS 8-10
        else {
            let settings = UIUserNotificationSettings.init(types: [UIUserNotificationType.alert,
                                                                   UIUserNotificationType.badge,
                                                                   UIUserNotificationType.sound],
                                                           categories: nil)
            UIApplication.shared.registerUserNotificationSettings(settings)
            UIApplication.shared.registerForRemoteNotifications()
        }
    }
}

