//
//  SceneDelegate.swift
//  SpaceXObserver
//
//  Created by Владимир on 29.05.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = LaunchesViewController(rocketId: "5e9d0d95eda69974db09d1ed")
        window?.makeKeyAndVisible()
    }

}
