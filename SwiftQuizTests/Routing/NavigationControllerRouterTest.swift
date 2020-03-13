//
//  NavigationControllerRouterTest.swift
//  SwiftQuizTests
//
//  Created by Patrick Domingo on 3/6/20.
//  Copyright © 2020 Patrick Domingo. All rights reserved.
//

import Foundation
import XCTest
@testable import SwiftQuiz
@testable import QuizEngine

class NavigationControllerRouterTest: XCTestCase {

    
    func test_answerForQuestion_showsQuestionController() {
        let viewController = UIViewController()
        let secondViewController = UIViewController()
        factory.stub(question: singleAnswerQuestion, with: viewController)
        factory.stub(question: multipleAnswerQuestion, with: secondViewController)
        
        sut.answer(for: singleAnswerQuestion, completion: { _ in })
        sut.answer(for: multipleAnswerQuestion, completion: { _ in })
        
        XCTAssertEqual(navigationController.viewControllers.count, 2)
        XCTAssertEqual(navigationController.viewControllers.first, viewController)
        XCTAssertEqual(navigationController.viewControllers.last, secondViewController)
    }
    
    func test_answerForQuestion_singleAnswer_answerCallback_progressesToNextQuestion() {
        var callbackFired = false
        
        sut.answer(for: singleAnswerQuestion, completion: { _ in callbackFired = true })
        
        factory.answerCallbacks[singleAnswerQuestion]!([""])
        
        XCTAssertTrue(callbackFired)
    }
    
    func test_answerForuestion_multipleAnswer_answerCallback_doesNotProgressToNextQuestion() {
        var callbackFired = false
        
        sut.answer(for: multipleAnswerQuestion, completion: { _ in callbackFired = true })
        
        factory.answerCallbacks[multipleAnswerQuestion]!(["anything"])
        
        XCTAssertFalse(callbackFired)
    }
    
    func test_answerForQuestion_multipleAnswer_configuresViewControllerWithSubmitButton() {
        let viewController = UIViewController()
        
        factory.stub(question: multipleAnswerQuestion, with: viewController)
        
        sut.answer(for: multipleAnswerQuestion, completion: { _ in })
     
        XCTAssertNotNil(viewController.navigationItem.rightBarButtonItem)
    }
    
    func test_answerForQuestion_singleAnswer_configuresViewControllerWithoutSubmitButton() {
        let viewController = UIViewController()
        
        factory.stub(question: singleAnswerQuestion, with: viewController)
        
        sut.answer(for: singleAnswerQuestion, completion: { _ in })
     
        XCTAssertNil(viewController.navigationItem.rightBarButtonItem)
    }
    
    func test_answerForQuestion_multipleAnswerSubmitButton_isDisabledWhenNoAnswerSelected() {
        let viewController = UIViewController()

        factory.stub(question: multipleAnswerQuestion, with: viewController)

        sut.answer(for: multipleAnswerQuestion, completion: { _ in })
        XCTAssertFalse(viewController.navigationItem.rightBarButtonItem!.isEnabled)

        factory.answerCallbacks[multipleAnswerQuestion]!([""])
        XCTAssertTrue(viewController.navigationItem.rightBarButtonItem!.isEnabled)
        
        factory.answerCallbacks[multipleAnswerQuestion]!([])
        XCTAssertFalse(viewController.navigationItem.rightBarButtonItem!.isEnabled)
    }
    
    func test_answerForQuestion_multipleAnswerSubmitButton_progressesToNextQuestion() {
        let viewController = UIViewController()
        
        var callbackFired = false
        
        factory.stub(question: multipleAnswerQuestion, with: viewController)

        sut.answer(for: multipleAnswerQuestion, completion: { _ in callbackFired = true })

        factory.answerCallbacks[multipleAnswerQuestion]!([""])
        XCTAssertTrue(viewController.navigationItem.rightBarButtonItem!.isEnabled)
        
        viewController.navigationItem.rightBarButtonItem!.simulateTap()
        
        XCTAssertTrue(callbackFired)
    }

    
    func test_didCompleteQuiz_showsResultsController() {
        let viewController = UIViewController()
        let userAnswers = [(singleAnswerQuestion, ["A1"])]
        
        let secondViewController = UIViewController()
        let userAnswers2 = [(multipleAnswerQuestion, ["A2"])]
        
        factory.stub(resultForQuestions: [singleAnswerQuestion], with: viewController)
        factory.stub(resultForQuestions: [multipleAnswerQuestion], with: secondViewController)
        
        sut.didComplete(withAnswers: userAnswers)
        sut.didComplete(withAnswers: userAnswers2)
        
        XCTAssertEqual(navigationController.viewControllers.count, 2)
        XCTAssertEqual(navigationController.viewControllers.first, viewController)
        XCTAssertEqual(navigationController.viewControllers.last, secondViewController)
    }
    
    // MARK: - Helpers
    
    class NonAnimatedNavigationController: UINavigationController {
        override func pushViewController(_ viewController: UIViewController, animated: Bool) {
            super.pushViewController(viewController, animated: false)
        }
    }
    
    class ViewControllerFactoryStub: ViewControllerFactory {
        
        private var stubbedQuestions = Dictionary<Question<String>, UIViewController>()
        private var stubbedResults = Dictionary<[Question<String>], UIViewController>()
        
        var answerCallbacks = Dictionary<Question<String>, ([String]) -> Void>()
        
        func stub(question: Question<String>, with viewController: UIViewController) {
            stubbedQuestions[question] = viewController
        }
//
//        func stub(result: Results<Question<String>, [String]>, with viewController: UIViewController) {
//            stubbedResults[result] = viewController
//        }
        
        func stub(resultForQuestions questions: [Question<String>], with viewController: UIViewController) {
            stubbedResults[questions] = viewController
        }
        
        func questionViewController(for question: Question<String>, answerCallback: @escaping ([String]) -> Void) -> UIViewController {
            answerCallbacks[question] = answerCallback
            return stubbedQuestions[question] ?? UIViewController()
        }
        
        func resultViewController(for userAnswers: Answers) -> UIViewController {
            return stubbedResults[userAnswers.map { $0.question }] ?? UIViewController()
        }
    }
    
    // MARK: - Helpers
    private let navigationController = NonAnimatedNavigationController()
    private let factory = ViewControllerFactoryStub()
    private let singleAnswerQuestion = Question.singleAnswer("Q1")
    private let multipleAnswerQuestion = Question.multipleAnswer("Q2")
    
    private lazy var sut: NavigationControllerRouter = {
        return NavigationControllerRouter(self.navigationController, factory: self.factory)
    } ()

    
}



private extension UIBarButtonItem {
    func simulateTap() {
        target!.performSelector(onMainThread: action!, with: nil, waitUntilDone: true)
    }
}
