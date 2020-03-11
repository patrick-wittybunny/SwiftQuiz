//
//  QuestionTest.swift
//  SwiftQuizTests
//
//  Created by Patrick Domingo on 3/6/20.
//  Copyright © 2020 Patrick Domingo. All rights reserved.
//

import Foundation
import XCTest
@testable import QuizEngine

class QuestionTest: XCTestCase {
    
    func test_hashValue_singleAnswer_returnsTypeHash() {
        let type = "a string"
        
        let sut = Question.singleAnswer(type)
        
        XCTAssertEqual(sut.hashValue, type.hashValue)
    }
    
    func test_hashValue_multipleAnswer_returnsTypeHash() {
        let type = "a string"

        let sut = Question.multipleAnswer(type)

        XCTAssertEqual(sut.hashValue, type.hashValue)
    }
    
}
