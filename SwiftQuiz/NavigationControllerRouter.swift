//
//  NavigationControllerRouter.swift
//  SwiftQuiz
//
//  Created by Patrick Domingo on 3/6/20.
//  Copyright © 2020 Patrick Domingo. All rights reserved.
//

import Foundation
import UIKit
import QuizEngine

protocol ViewControllerFactory {
    func questionViewController(for question: String, answerCallback: @escaping (String) -> Void) -> UIViewController
}

class NavigationControllerRouter: Router {
    
    private let navigationController: UINavigationController
    private let factory: ViewControllerFactory
    
    init(_ navigationController: UINavigationController, factory: ViewControllerFactory) {
        self.navigationController = navigationController
        self.factory = factory
    }
    
    func routeTo(question: String, answerCallback: @escaping (String) -> Void) {
        let viewController = factory.questionViewController(for: question, answerCallback: answerCallback)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func routeTo(result: Results<String, String>) {
        
    }
}
