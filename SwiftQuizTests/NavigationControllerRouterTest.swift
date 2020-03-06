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

class NavigationControllerRouterTest: XCTestCase {

    let navigationController = NonAnimatedNavigationController()
    let factory = ViewControllerFactoryStub()
    
    lazy var sut: NavigationControllerRouter = {
        return NavigationControllerRouter(self.navigationController, factory: self.factory)
    } ()
    
    func test_routeTouestion_showsQuestionController() {
        let viewController = UIViewController()
        let secondViewController = UIViewController()
        factory.stub(question: "Q1", with: viewController)
        factory.stub(question: "Q2", with: secondViewController)
        
        sut.routeTo(question: "Q1", answerCallback: { _ in })
        sut.routeTo(question: "Q2", answerCallback: { _ in })
        
        XCTAssertEqual(navigationController.viewControllers.count, 2)
        XCTAssertEqual(navigationController.viewControllers.first, viewController)
        XCTAssertEqual(navigationController.viewControllers.last, secondViewController)
    }
    
    func test_routeToSecondQuestion_presentsQuestionController_withRightCallback() {
        
        var callbackFired = false
        
        sut.routeTo(question: "Q1", answerCallback: { _ in callbackFired = true })
        factory.answerCallbacks["Q1"]!("")
        XCTAssertTrue(callbackFired)
    }
    
    // MARK: - Helpers
    
    
    class NonAnimatedNavigationController: UINavigationController {
        override func pushViewController(_ viewController: UIViewController, animated: Bool) {
            super.pushViewController(viewController, animated: false)
        }
    }
    
    class ViewControllerFactoryStub: ViewControllerFactory {
        private var stubbedQuestions = [String: UIViewController]()
        var answerCallbacks = [String: (String) -> Void]()
        
        func stub(question: String, with viewController: UIViewController) {
            stubbedQuestions[question] = viewController
        }
        
        func questionViewController(for question: String, answerCallback: @escaping (String) -> Void) -> UIViewController {
            answerCallbacks[question] = answerCallback
            return stubbedQuestions[question] ?? UIViewController()
        }
    }
    
}
