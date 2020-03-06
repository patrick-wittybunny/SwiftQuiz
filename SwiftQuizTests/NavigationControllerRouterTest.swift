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
    
    func test_routeToQuestion_presentsQuestionController() {
        let navigationController = UINavigationController()
        let sut = NavigationControllerRouter(navigationController)
        
        sut.routeTo(question: "Q1", answerCallback: { _ in })
        
        XCTAssertEqual(navigationController.viewControllers.count, 1)
    }
    
    func test_routeToQuestionTwice_presentsQuestionController() {
        let navigationController = UINavigationController()
        let sut = NavigationControllerRouter(navigationController)
        
        sut.routeTo(question: "Q1", answerCallback: { _ in })
        sut.routeTo(question: "Q2", answerCallback: { _ in })
        
        XCTAssertEqual(navigationController.viewControllers.count, 2)
    }
    
    
}
