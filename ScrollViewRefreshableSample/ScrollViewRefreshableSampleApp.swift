//
//  ScrollViewRefreshableSampleApp.swift
//  ScrollViewRefreshableSample
//
//  Created by ykkd on 2023/12/05.
//

import UIKit

// AppDelegateを更新
@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    /// this works XCode 15.0
//    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
//        let sceneConfig = UISceneConfiguration(
//            name: "Default Configuration",
//            sessionRole: connectingSceneSession.role
//        )
//        sceneConfig.delegateClass = SceneDelegate.self
//        return sceneConfig
//    }

    /// this shows black screen XCode 15.0~. (worked when XCode 14.2)
    func application(
        _ application: UIApplication,
        configurationForConnecting connectingSceneSession: UISceneSession,
        options: UIScene.ConnectionOptions
    ) -> UISceneConfiguration {
        return UISceneConfiguration(
            name: "Default Configuration",
            sessionRole: connectingSceneSession.role
        )
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        return true
    }
}
