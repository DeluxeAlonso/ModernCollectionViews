//
//  SceneDelegate.swift
//  ModernCollectionViews
//
//  Created by Alonso on 10/6/20.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(windowScene: windowScene)
        self.window?.rootViewController = UINavigationController(rootViewController: MainViewController(collectionViewLayout: UICollectionViewLayout()))
        self.window?.makeKeyAndVisible()
    }

}
