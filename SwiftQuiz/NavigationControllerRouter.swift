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

class NavigationControllerRouter: Router {
    
    private let navigationController: UINavigationController
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func routeTo(question: String, answerCallback: @escaping (String) -> Void) {
        navigationController.pushViewController(UIViewController(), animated: false)
    }
    
    func routeTo(result: Results<String, String>) {
        
    }
}
