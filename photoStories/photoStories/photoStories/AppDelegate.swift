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
import LeanplumUIEditor

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    
    var window: UIWindow?
    
    var welcomeMessage = LPVar.define("welcomeMessage",with: "Welcome to Leanplum!")
    var profileImage = LPVar.define("loginImage", withFile: "plum")
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        #if DEBUG
            Leanplum.setAppId("app_",
                              withDevelopmentKey:"dev_")
        #else
            Leanplum.setAppId("app_",
                              withProductionKey: "prod_")
        #endif
        
        LeanplumUIEditor.shared().allowInterfaceEditing()
        
        Leanplum.setVerboseLoggingInDevelopmentMode(true)
        
        configureUserNotifications()
        
        Leanplum.start()
        Leanplum.onStartResponse{ (success:Bool) in
            print("Start call resposne Success")
        }
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
    }

    func applicationWillTerminate(_ application: UIApplication) {
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error)
    {
        print("Error = ",error.localizedDescription)
    }

    func configureUserNotifications(){
        
        if #available(iOS 10.0, *) {
            print("IOS 10 push registration")
            let userNotifCenter = UNUserNotificationCenter.current()
            userNotifCenter.delegate = self
            
            userNotifCenter.requestAuthorization(options: [.sound, .alert, .badge]) { (granted,error) in
                if error == nil {
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

