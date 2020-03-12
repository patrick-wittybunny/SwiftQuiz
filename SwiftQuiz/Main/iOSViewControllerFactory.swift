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
    typealias Answers = [(question: Question<String>, answers: [String])]
    
    private let questions: [Question<String>]
    private let options: Dictionary<Question<String>, [String]>
    private let correctAnswers: () -> Answers
    
    init(options: Dictionary<Question<String>, [String]>, correctAnswers: Answers) {
        self.questions = correctAnswers.map { $0.question }
        self.options = options
        self.correctAnswers = { correctAnswers }
    }
    
    init(questions: [Question<String>], options: Dictionary<Question<String>, [String]>, correctAnswers: Dictionary<Question<String>, [String]>) {
        self.questions = questions
        self.options = options
        self.correctAnswers = { questions.map { ($0, correctAnswers[$0]!) } }
    }
    
    func questionViewController(for question: Question<String>, answerCallback: @escaping ([String]) -> Void) -> UIViewController {
        
        guard let options = self.options[question] else {
            fatalError("Couldn't find options for question: \(question)")
        }
        
        return questionViewController(for: question,
                                      options: options, answerCallback: answerCallback)
        
    }
    
    private func questionViewController(for question: Question<String>, options: [String], answerCallback: @escaping ([String]) -> Void) -> UIViewController {
        switch question {
        case .singleAnswer(let value):
            return questionViewController(for: question,
                                          value: value,
                                          options: options,
                                          allowsMultipleSelection: false,
                                          answerCallback: answerCallback)
        case .multipleAnswer(let value):
            return questionViewController(for: question,
                                          value: value,
                                          options: options,
                                          allowsMultipleSelection: true,
                                          answerCallback: answerCallback)
        }
    }
    
    private func questionViewController(for question: Question<String>, value: String, options: [String], allowsMultipleSelection: Bool, answerCallback: @escaping ([String]) -> Void) -> QuestionViewController {
        let presenter = QuestionPresenter(questions: questions, question: question)
        let controller = QuestionViewController(question: value,
                                                options: options,
                                                allowsMultipleSelection: allowsMultipleSelection,
                                                selection: answerCallback)
        controller.title = presenter.title
        return controller
    }
    
    func resultViewController(for result: Results<Question<String>, [String]>) -> UIViewController {
        let presenter = ResultsPresenter(userAnswers: questions.map { ($0, result.answers[$0]!) },
                                         correctAnswers: correctAnswers(),
                                         scorer: { _, _ in result.score })
        let controller = ResultsViewController(summary: presenter.summary, answers: presenter.presentableAnswers)
        controller.title = presenter.title
        return controller
    }
    
    func resultViewController(for userAnswers: Answers) -> UIViewController {
        let presenter = ResultsPresenter(userAnswers: userAnswers,
                                         correctAnswers: correctAnswers(),
                                         scorer: BasicScore.score)
        let controller = ResultsViewController(summary: presenter.summary, answers: presenter.presentableAnswers)
        controller.title = presenter.title
        return controller
    }
    
}
