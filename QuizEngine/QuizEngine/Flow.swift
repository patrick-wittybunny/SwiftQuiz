//
//  Flow.swift
//  QuizEngine
//
//  Created by Patrick Domingo on 3/5/20.
//  Copyright © 2020 Patrick Domingo. All rights reserved.
//

import Foundation

class Flow <R: QuizDelegate> {
    typealias Question = R.Question
    typealias Answer = R.Answer
    
    private let delegate: R
    private let questions: [Question]
    private var answers: [Question: Answer] = [:]
    private var scoring: ([Question: Answer]) -> Int
    
    init(questions: [Question], router: R, scoring: @escaping ([Question: Answer]) -> Int) {
        self.questions = questions
        self.delegate = router
        self.scoring = scoring
    }
    
    func start() {
        if let firstQuestion = questions.first {
            delegate.handle(question: firstQuestion, answerCallback: nextCallback(from: firstQuestion))
        } else {
            delegate.handle(result: result())
        }
    }
    
    private func nextCallback(from question: Question) -> (Answer) -> Void {
        return { [weak self] in self?.routeNext(question, $0) }
    }
    
    private func routeNext(_ question: Question, _ answer: Answer) {
        if let currentQuestionIndex = questions.firstIndex(of: question) {
            answers[question] = answer
            let nextQuestionIndex = currentQuestionIndex + 1
            if nextQuestionIndex < questions.count {
                delegate.handle(question: questions[nextQuestionIndex], answerCallback: nextCallback(from: questions[nextQuestionIndex]))
            } else {
                delegate.handle(result: result())
            }
        }
    }
    
    private func result() -> Results<Question, Answer> {
        return Results(answers: answers, score: scoring(answers))
    }
}
