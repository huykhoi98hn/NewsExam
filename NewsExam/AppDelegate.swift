//
//  AppDelegate.swift
//  NewsExam
//
//  Created by Nguyen Huy Khoi on 28/10/2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let window = UIWindow()
        let vc = UIViewController()
        vc.view.backgroundColor = .red
        window.rootViewController = vc
        window.makeKeyAndVisible()
        self.window = window
        return true
    }
}

