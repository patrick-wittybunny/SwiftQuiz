//
//  QuestionPresenterTest.swift
//  SwiftQuizTests
//
//  Created by Patrick Domingo on 3/9/20.
//  Copyright © 2020 Patrick Domingo. All rights reserved.
//

import Foundation
import XCTest
@testable import SwiftQuiz
@testable import QuizEngine

class QuestionPresenterTest: XCTestCase {
    
    let singleAnswerQuestion = Question.singleAnswer("A1")
    let multipleAnswerQuestion = Question.multipleAnswer("A2")
    
    func test_title_forFirstQuestion_formatsTitleForIndex() {
        let sut = QuestionPresenter(questions: [singleAnswerQuestion], question: singleAnswerQuestion)
        
        XCTAssertEqual(sut.title, "Question #1")
    }
    
    func test_title_forSecondQuestion_formatsTitleForIndex() {
        let sut = QuestionPresenter(questions: [singleAnswerQuestion, multipleAnswerQuestion], question: multipleAnswerQuestion)
        
        XCTAssertEqual(sut.title, "Question #2")
    }
    
    func test_title_forNonExistentQuestion_isEmpty() {
        let sut = QuestionPresenter(questions: [], question: singleAnswerQuestion)
        
        XCTAssertEqual(sut.title, "")
    }
    
}
