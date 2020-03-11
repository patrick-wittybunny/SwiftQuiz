//
//  QuizDelegate.swift
//  QuizEngine
//
//  Created by Patrick Domingo on 3/11/20.
//  Copyright © 2020 Patrick Domingo. All rights reserved.
//

import Foundation

public protocol QuizDelegate {
    associatedtype Question: Hashable
    associatedtype Answer
    func handle(question: Question, answerCallback: @escaping (Answer) -> Void)
    func handle(result: Results<Question, Answer>)
}
