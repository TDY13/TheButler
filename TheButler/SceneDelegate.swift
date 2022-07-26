//
//  SceneDelegate.swift
//  InterQR-Internship
//
//  Created by Дмитрий Тимофеев on 30.05.2022.
//

import UIKit
import SnapKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        let viewController = VerificationViewController()
        let homeVC = HomeViewController()
        let residentVC = ResidentsViewController()
        let navigation = UINavigationController(rootViewController: viewController)
        navigation.isNavigationBarHidden = true
        window?.rootViewController = navigation
        window?.makeKeyAndVisible()
    }
}

