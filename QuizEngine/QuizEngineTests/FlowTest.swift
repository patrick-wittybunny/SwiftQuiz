//
//  FlowTest.swift
//  QuizEngineTests
//
//  Created by Patrick Domingo on 3/5/20.
//  Copyright © 2020 Patrick Domingo. All rights reserved.
//

import Foundation
import XCTest
@testable import QuizEngine

class FlowTest: XCTestCase {
    
    let router = RouterSpy()
    
    func test_start_withNoQuestions_doesNotRouteToQuestion() {
        makeSUT(questions: []).start()
        XCTAssertTrue(router.routedQuestions.isEmpty)
    }
    
    func test_start_withOneQuestion_routesToCorrectQuestion() {
        makeSUT(questions: ["Q1"]).start()
        XCTAssertEqual(router.routedQuestions, ["Q1"])
    }
    
    func test_start_withOneQuestion_routesToCorrectQuestion_2() {
        makeSUT(questions: ["Q2"]).start()
        XCTAssertEqual(router.routedQuestions, ["Q2"])
    }
    
    func test_start_withTwoQuestion_routesToFirstQuestion() {
        makeSUT(questions: ["Q1", "Q2"]).start()
        XCTAssertEqual(router.routedQuestions, ["Q1"])
    }
    
    
    func test_startTwice_withTwoQuestion_routesToFirstQuestionTwice() {
        let sut = makeSUT(questions: ["Q1", "Q2"])

        sut.start()
        sut.start()
        
        XCTAssertEqual(router.routedQuestions, ["Q1", "Q1"])
    }
    
    func test_startAndAnswerFirstQuestionAndSecondQuestion_withThreeQuestions_routesToSecondAndThirdQuestion() {
        let sut = makeSUT(questions: ["Q1", "Q2", "Q3"])
        sut.start()
        
        router.answerCallback("A1")
        router.answerCallback("A2")
        
        XCTAssertEqual(router.routedQuestions, ["Q1", "Q2", "Q3"])
    }
    
    func test_startAndAnswerFirstQuestion_withOneQuestion_doesNotRouteToAnotherQuestion() {
        let sut = makeSUT(questions: ["Q1"])
        sut.start()
        
        router.answerCallback("A1")
        
        XCTAssertEqual(router.routedQuestions, ["Q1"])
    }
    
    func test_start_withNoQuestions_routesToResult() {
        let sut = makeSUT(questions: [])
        sut.start()
        
        XCTAssertEqual(router.routedResult!.answers, [:])
    }
    
    
    func test_start_withOneQuestion_doesNotRouteToResult() {
        makeSUT(questions: ["Q1"]).start()
        
        XCTAssertNil(router.routedResult)
    }
    
    func test_startAndAnswerFirstAndSecondQuestion_withTwoQuestion_routesToResult() {
        let sut = makeSUT(questions: ["Q1", "Q2"])
        sut.start()
         
        router.answerCallback("A1")
        router.answerCallback("A2")
        
        XCTAssertEqual(router.routedResult!.answers, ["Q1": "A1", "Q2" : "A2"])
    }
    
    func test_startAndAnswerFirst_withTwoQuestion_doesNotRoutesToResult() {
        let sut = makeSUT(questions: ["Q1", "Q2"])
        sut.start()
         
        router.answerCallback("A1")
        
        XCTAssertNil(router.routedResult)
    }
    
    
    func test_startAndAnswerFirstAndSecondQuestion_withTwoQuestion_scores() {
        let sut = makeSUT(questions: ["Q1", "Q2"], scoring: { _ in 20 })
        sut.start()
         
        router.answerCallback("A1")
        router.answerCallback("A2")
        
        XCTAssertEqual(router.routedResult!.score, 20)
    }
    
    func test_startAndAnswerFirstAndSecondQuestion_withTwoQuestion_scoresWithRightAnswers() {
        var receivedAnswers = [String:String]()
        let sut = makeSUT(questions: ["Q1", "Q2"], scoring: { answers in
            receivedAnswers = answers
            return 20
        })
        sut.start()
         
        router.answerCallback("A1")
        router.answerCallback("A2")
        
        XCTAssertEqual(receivedAnswers, ["Q1": "A1", "Q2" : "A2"])
    }
    
    
    // MARK: - Helpers
    
    func makeSUT(questions: [String], scoring: (@escaping ([String: String]) -> Int) = { _ in 0 }) -> Flow<String, String, RouterSpy> {
        return Flow(questions: questions, router: router, scoring: scoring)
    }
    
}
