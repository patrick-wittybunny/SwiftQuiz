//
//  Router.swift
//  QuizEngine
//
//  Created by Patrick Domingo on 3/6/20.
//  Copyright © 2020 Patrick Domingo. All rights reserved.
//

import Foundation

public protocol Router {
    associatedtype Question: Hashable
    associatedtype Answer
    func routeTo(question: Question, answerCallback: @escaping (Answer) -> Void)
    func routeTo(result: Results<Question, Answer>)
}
