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
    var quiz: Quiz?

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
        let options1 = [option1, option2, option3]

        let option4 = "Nayeon"
        let option5 = "Sana"
        let option6 = "Sojin"
        let options2 = [option4, option5, option6]
        
        let options = [question: options1, question2: options2]
        
        let correctAnswers = [(question, [option1]), (question2, [option5, option4])]

        let navigationController = UINavigationController()
        let factory = iOSViewControllerFactory(options: options, correctAnswers: correctAnswers)
        let router = NavigationControllerRouter(navigationController, factory: factory)

        window.rootViewController = navigationController

        self.window = window
        window.makeKeyAndVisible()
        quiz = Quiz.start(questions: questions, delegate: router)
//
        
        return true
    }

}

