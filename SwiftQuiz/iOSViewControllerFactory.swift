//
//  iOSViewControllerFactory.swift
//  SwiftQuiz
//
//  Created by Patrick Domingo on 3/9/20.
//  Copyright © 2020 Patrick Domingo. All rights reserved.
//

import Foundation
import UIKit
import QuizEngine

class iOSViewControllerFactory: ViewControllerFactory {
    
    private let options: Dictionary<Question<String>, [String]>
    
    init(options: Dictionary<Question<String>, [String]>) {
        self.options = options
    }
    
    func questionViewController(for question: Question<String>, answerCallback: @escaping ([String]) -> Void) -> UIViewController {
        switch question {
        case .singleAnswer(let a):
            return QuestionViewController(question: a, options: options[question]!, selection: answerCallback)
        default:
            return UIViewController()
        }
    }
    
    func resultViewController(for result: Results<Question<String>, [String]>) -> UIViewController {
        return UIViewController()
    }
    
}
