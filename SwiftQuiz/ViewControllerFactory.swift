//
//  ViewControllerFactory.swift
//  SwiftQuiz
//
//  Created by Patrick Domingo on 3/9/20.
//  Copyright © 2020 Patrick Domingo. All rights reserved.
//

import UIKit
import QuizEngine

protocol ViewControllerFactory {
    func questionViewController(for question: Question<String>, answerCallback: @escaping ([String]) -> Void) -> UIViewController
    func resultViewController(for result: Results<Question<String>, [String]>) -> UIViewController
}
