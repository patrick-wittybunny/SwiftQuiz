//
//  AppDelegate.swift
//  SwiftQuiz
//
//  Created by Patrick Domingo on 3/5/20.
//  Copyright © 2020 Patrick Domingo. All rights reserved.
//

import UIKit
import QuizEngine

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var game: Game<Question<String>, [String], NavigationControllerRouter>?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
//
        let window = UIWindow(frame: UIScreen.main.bounds)

        let question = Question.singleAnswer("Favorite Twice member?")
        let question2 = Question.multipleAnswer("Twice member/s?")

        let questions = [question, question2]

        let option1 = "Sana"
        let option2 = "Chaeyoung"
        let option3 = "Minju"
        let options = [option1, option2, option3]

        let correctAnswers = [question: [option1], question2: [option1, option2]]

        let navigationController = UINavigationController()
        let factory = iOSViewControllerFactory(questions: questions, options: [question: options, question2: options], correctAnswers: correctAnswers)
        let router = NavigationControllerRouter(navigationController, factory: factory)

        window.rootViewController = navigationController

        self.window = window
        window.makeKeyAndVisible()
        game = startGame(questions: questions, router: router, correctAnswers: correctAnswers)
//
        
        return true
    }

}

