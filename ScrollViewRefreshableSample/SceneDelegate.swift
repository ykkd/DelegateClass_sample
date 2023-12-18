//
//  SceneDelegate.swift
//  ScrollViewRefreshableSample
//
//  Created by ykkd on 2023/12/06.
//

import UIKit

// MARK: - SceneDelegate
class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    /// アプリ未起動からディープリンクで起動した場合はこのメソッドが呼ばれる
    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else {
            return
        }
        let window = UIWindow(windowScene: windowScene)
        self.window = window
        window.makeKeyAndVisible()

        print("hoge")
        let vc = MainViewController()

        window.rootViewController = vc
    }
}
