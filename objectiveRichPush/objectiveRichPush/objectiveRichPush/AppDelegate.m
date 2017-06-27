//
//  AppDelegate.m
//  objectiveRichPush
//
//  Created by Sasho Hadzhiev on 6/23/17.
//  Copyright © 2017 Sasho Hadzhiev. All rights reserved.
//

#import "AppDelegate.h"
#import <Leanplum/Leanplum.h>
#import <UserNotifications/UserNotifications.h>

#define SYSTEM_VERSION_GRATERTHAN_OR_EQUALTO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

@interface AppDelegate ()

@end

@implementation AppDelegate

DEFINE_VAR_FLOAT(shootSpeed, 1.0);
DEFINE_VAR_BOOL(showAds, false);

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self registerForRemoteNotification];
   
    #ifdef DEBUG
        [Leanplum setAppId:@"app_ua6v9eO9Uwwap3GuZ8QMLQ9PIz2OapxKuda6AZZ6wYs"
        withDevelopmentKey:@"dev_eJdJom0MgAA2C2tjYUEHMZzOgDPTyAq1OuKYctFUo2E"];
    #else
        [Leanplum setAppId:@"app_ua6v9eO9Uwwap3GuZ8QMLQ9PIz2OapxKuda6AZZ6wYs"
         withProductionKey:@"prod_wpWlRQ01WGR3xsOaGCUUR2MC9DkC9VP1Q4ByXDsZhhM"];
    #endif

    [Leanplum setVerboseLoggingInDevelopmentMode:YES];
   
    [Leanplum start];

    [Leanplum onStartResponse:^(BOOL success) {
        NSLog(@"Variants: %@", [Leanplum variants]);
        NSLog(@"Messages: %@", [Leanplum messageMetadata]);
    }];

    return YES;
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center
       willPresentNotification:(UNNotification *)notification
         withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler {
    
    NSLog(@"Will present notification: %@", notification);
    completionHandler(UNNotificationPresentationOptionAlert |
                      UNNotificationPresentationOptionBadge |
                      UNNotificationPresentationOptionSound);
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response
         withCompletionHandler:(void (^)())completionHandler {
    
    NSLog(@"didReceiveNotificationResponse: %@", response);
    completionHandler();
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSLog(@"Token: %@", deviceToken);
}


- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"Failed to register: %@", error);
}


- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    NSLog(@"Received remote %@", userInfo);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
        fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    if (completionHandler) {
        completionHandler(UIBackgroundFetchResultNoData);
    }
}

/**
 Notification Registration
 */
- (void)registerForRemoteNotification {
    // Otherwise use boilerplate code from docs.
    id notificationCenterClass = NSClassFromString(@"UNUserNotificationCenter");
    if (notificationCenterClass) {
        // iOS 10.
        SEL selector = NSSelectorFromString(@"currentNotificationCenter");
        id notificationCenter =
        ((id (*)(id, SEL)) [notificationCenterClass methodForSelector:selector])
        (notificationCenterClass, selector);
        if (notificationCenter) {
            selector = NSSelectorFromString(@"requestAuthorizationWithOptions:completionHandler:");
            IMP method = [notificationCenter methodForSelector:selector];
            void (*func)(id, SEL, unsigned long long, void (^)(BOOL, NSError *__nullable)) =
            (void *) method;
            func(notificationCenter, selector,
                 0b111, /* badges, sounds, alerts */
                 ^(BOOL granted, NSError *__nullable error) {
                     if (error) {
                         NSLog(@"Leanplum: Failed to request authorization for user "
                               "notifications: %@", error);
                     }
                 });
        }
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    }
}


@end
