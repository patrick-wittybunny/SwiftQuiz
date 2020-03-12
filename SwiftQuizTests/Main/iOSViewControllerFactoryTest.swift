//
//  iOSViewControllerFactoryTest.swift
//  SwiftQuizTests
//
//  Created by Patrick Domingo on 3/9/20.
//  Copyright © 2020 Patrick Domingo. All rights reserved.
//

import Foundation
import XCTest
@testable import QuizEngine
@testable import SwiftQuiz

class iOSViewControllerFactoryTest: XCTestCase {
    
    let options = ["A1", "A2"]
    let singleAnswerQuestion = Question.singleAnswer("Q1")
    let multipleAnswerQuestion = Question.multipleAnswer("Q2")
    
    
    func test_questionViewController_singleAnswer_createsController_withTitle() {
        let presenter = QuestionPresenter(questions: [singleAnswerQuestion], question: singleAnswerQuestion)
        XCTAssertEqual(makeQuestionController(question: singleAnswerQuestion).title, presenter.title)
    }
    
    func test_questionViewController_multipleAnswer_createsController_withTitle() {
       let presenter = QuestionPresenter(questions: [singleAnswerQuestion, multipleAnswerQuestion], question: multipleAnswerQuestion)
        XCTAssertEqual(makeQuestionController(question: multipleAnswerQuestion).title, presenter.title)
   }
       
    func test_questionViewController_singleAnswer_createsController_withQuestion() {
        XCTAssertEqual(makeQuestionController(question: singleAnswerQuestion).question, "Q1")
    }
    
    func test_questionViewController_singleAnswer_createsControllerWithOptions() {
        XCTAssertEqual(makeQuestionController(question: singleAnswerQuestion).options, options)
    }
    
    func test_questionViewController_singleAnswer_createsControllerWithSingleSelection() {
        XCTAssertFalse(makeQuestionController(question: singleAnswerQuestion).allowsMultipleSelection)
    }
     
    func test_questionViewController_multipleAnswer_createsController_withQuestion() {
        XCTAssertEqual(makeQuestionController(question: multipleAnswerQuestion).question, "Q2")
    }
    
    func test_questionViewController_multipleAnswer_createsControllerWithOptions() {
        XCTAssertEqual(makeQuestionController(question: multipleAnswerQuestion).options, options)
    }
    
    func test_questionViewController_multipleAnswer_createsControllerWithSingleSelection() {
        XCTAssertTrue(makeQuestionController(question: multipleAnswerQuestion).allowsMultipleSelection)
    }
    
    func test_resultViewController_createsControllerWithSummary() {
        let results = makeResults()

        XCTAssertEqual(results.controller.summary, results.presenter.summary)
    }
    
    func test_resultViewController_createsControllerWithPresentableAnswers() {
        let results = makeResults()
        
        XCTAssertEqual(results.controller.answers.count, results.presenter.presentableAnswers.count)
   }
    
    // MARK: - Helpers
    func makeSUT(options: Dictionary<Question<String>, [String]> = [:], correctAnswers: Dictionary<Question<String>, [String]> = [:]) -> iOSViewControllerFactory {
        return iOSViewControllerFactory(questions: [singleAnswerQuestion, multipleAnswerQuestion], options: options, correctAnswers: correctAnswers)
    }
    
    func makeSUT(options: Dictionary<Question<String>, [String]> = [:], correctAnswers: [(question: Question<String>, answers: [String])] = []) -> iOSViewControllerFactory {
        return iOSViewControllerFactory(options: options, correctAnswers: correctAnswers)
    }
    
    func makeResults() -> (controller: ResultsViewController, presenter: ResultsPresenter) {
        let userAnswers = [(singleAnswerQuestion, ["A1"]), (multipleAnswerQuestion, ["A2", "A3"])]
        let correctAnswers = [(singleAnswerQuestion, ["A1"]), (multipleAnswerQuestion, ["A2", "A3"])]
        
        let presenter = ResultsPresenter(userAnswers: userAnswers,
                                         correctAnswers: correctAnswers,
                                         scorer: BasicScore.score)
        let controller = makeSUT(correctAnswers: correctAnswers).resultViewController(for: userAnswers) as! ResultsViewController
        
        return (controller, presenter)
    }
    
    func makeQuestionController(question: Question<String> = .singleAnswer("")) -> QuestionViewController {
        return makeSUT(options: [question: options], correctAnswers: [:]).questionViewController(for: question, answerCallback: { _ in }) as! QuestionViewControllerç
    }
}
