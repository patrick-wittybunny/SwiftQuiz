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
    
    func answer(for question: Question, completion: @escaping (Answer) -> Void)
    func didCompleteQuiz(withAnswers answers: [(question: Question, answer: Answer)])
    
    @available(*, deprecated, message: "use didComplete(withAnswers:) instead")
    func handle(result: Results<Question, Answer>)
}
