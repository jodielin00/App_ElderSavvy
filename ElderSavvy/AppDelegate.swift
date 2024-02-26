//
//  AppDelegate.swift
//  ElderSavvy
//
//  Created by jodielin on 2024/2/25.
//

import UIKit


@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
//        let ifyu = IFlySetting()
//        
//        [IFlySetting setLogFile:LVL_ALL];
//
//        //Set whether to output log messages in Xcode console
//        [IFlySetting showLogcat:YES];
//
//        //Set the local storage path of SDK
//        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
//        NSString *cachePath = [paths objectAtIndex:0];
//        [IFlySetting setLogFilePath:cachePath];
//        NSString *appid = @"58219b80";
//
//
//        //Set APPID
//        NSString *initString = [[NSString alloc] initWithFormat:@"appid=%@",appid];
//
//        //Configure and initialize iflytek services.(This interface must been invoked in application:didFinishLaunchingWithOptions:)
//        [IFlySpeechUtility createUtility:initString];
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

