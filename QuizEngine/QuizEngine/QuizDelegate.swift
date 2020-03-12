//
//  QuizDelegate.swift
//  QuizEngine
//
//  Created by Patrick Domingo on 3/11/20.
//  Copyright © 2020 Patrick Domingo. All rights reserved.
//

import Foundation


public typealias QuestionAndAnswer<Question, Answer> = (question: Question, answer: Answer)

public protocol QuizDelegate {
    associatedtype Question: Hashable
    associatedtype Answer
    
    func answer(for question: Question, completion: @escaping (Answer) -> Void)
    func didCompleteQuiz(withAnswers: [(question: Question, answer: Answer)])
    
    @available(*, deprecated, message: "use didComplete(withAnswers:) instead")
    func handle(result: Results<Question, Answer>)
}

public extension QuizDelegate {
    func didCompleteQuiz(withAnswers: [(question: Question, answer: Answer)]) {}
}

public protocol QuizResultBuilder {
    associatedtype Question: Hashable
    associatedtype Answer
    associatedtype Results
    
    func build(from: [Question: Answer]) -> Results
    
}
