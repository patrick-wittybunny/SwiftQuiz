//
//  AppDelegate.swift
//  SwiftQuiz
//
//  Created by Patrick Domingo on 3/5/20.
//  Copyright © 2020 Patrick Domingo. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        let viewController = QuestionViewController(question: "A question?", options: ["Options 1", "Options 2"]) {
            print($0)
        }
        _ = viewController.view
        viewController.tableView.allowsMultipleSelection = false
        
        window.rootViewController = viewController
        
        self.window = window
        window.makeKeyAndVisible()
        
        return true
    }

}

