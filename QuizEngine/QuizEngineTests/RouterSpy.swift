//
//  RouterSpy.swift
//  QuizEngine
//
//  Created by Patrick Domingo on 3/6/20.
//  Copyright © 2020 Patrick Domingo. All rights reserved.
//

import Foundation
@testable import QuizEngine

class RouterSpy: Router {
    var routedQuestions: [String] = []
    var routedResult: Results<String, String>? = nil
    var answerCallback: (String) -> Void = { _ in }
    
    func routeTo(question: String, answerCallback: @escaping (String) -> Void ) {
        routedQuestions.append(question)
        self.answerCallback = answerCallback
    }
    
    func routeTo(result: Results<String, String>) {
        routedResult = result
    }
}
