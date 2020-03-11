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
    
    let aValue = "a value"
    let anotherValue = "anotherValue"
    
    func test_hashValue_forSingleAnswer() {
        XCTAssertEqual(Question.singleAnswer(aValue).hashValue, Question.singleAnswer(aValue).hashValue)
        XCTAssertEqual(Question.singleAnswer(anotherValue).hashValue, Question.singleAnswer(anotherValue).hashValue)
        
        XCTAssertNotEqual(Question.singleAnswer(aValue).hashValue, Question.singleAnswer(anotherValue).hashValue)
    }
    
    func test_hashValue_forMutipleAnswer() {
        XCTAssertEqual(Question.multipleAnswer(aValue).hashValue, Question.multipleAnswer(aValue).hashValue)
        XCTAssertEqual(Question.multipleAnswer(anotherValue).hashValue, Question.multipleAnswer(anotherValue).hashValue)
        
        XCTAssertNotEqual(Question.multipleAnswer(aValue).hashValue, Question.multipleAnswer(anotherValue).hashValue)
    }
    
    func test_hashValue_isDifferentForSingleAnswerAndMultipleAnswer() {
        XCTAssertNotEqual(Question.multipleAnswer(aValue).hashValue, Question.singleAnswer(aValue).hashValue)
        XCTAssertNotEqual(Question.multipleAnswer(anotherValue).hashValue, Question.singleAnswer(anotherValue).hashValue)
        
        XCTAssertNotEqual(Question.multipleAnswer(aValue).hashValue, Question.singleAnswer(anotherValue).hashValue)
    }
    
}
