//
//  ResultsPresenterTest.swift
//  SwiftQuizTests
//
//  Created by Patrick Domingo on 3/9/20.
//  Copyright © 2020 Patrick Domingo. All rights reserved.
//

import Foundation
import UIKit
import XCTest
@testable import QuizEngine
@testable import SwiftQuiz

class ResultsPresenterTest: XCTestCase {
    
    let singleAnswerQuestion = Question.singleAnswer("Q1")
    let multipleAnswerQuestion = Question.multipleAnswer("Q2")
    
    func test_title_returnsFormattedTitle() {
        XCTAssertEqual(makeSUT().title, "Result")
    }
    
    func test_summary_withTwoQuestionsAndScoreOne_returnsSummary() {
        let userAnswers = [(singleAnswerQuestion, ["A1"]), (multipleAnswerQuestion, ["A2", "A3"])]
        let correctAnswers = [(singleAnswerQuestion, ["A1"]), (multipleAnswerQuestion, ["A1", "A4"])]
        let sut = makeSUT(userAnswers: userAnswers, correctAnswers: correctAnswers, score: 1)
        XCTAssertEqual(sut.summary, "You got 1/2 correct")
    }
    
    func test_presentableAnswers_withoutQuestions_isEmpty() {
        XCTAssertTrue(makeSUT().presentableAnswers.isEmpty)
    }
    
    func test_presentableAnswers_withWrongSingleAnswer_mapsAnswer() {
        let userAnswers = [(singleAnswerQuestion, ["A1"])]
        let correctAnswers = [(singleAnswerQuestion, ["A2"])]
        let sut = makeSUT(userAnswers: userAnswers, correctAnswers: correctAnswers)
        
        XCTAssertEqual(sut.presentableAnswers.count, 1)
        XCTAssertEqual(sut.presentableAnswers.first!.question, "Q1")
        XCTAssertEqual(sut.presentableAnswers.first!.answer, "A2")
        XCTAssertEqual(sut.presentableAnswers.first!.wrongAnswer, "A1")
    }
    
    func test_presentableAnswers_withWrongMultipleAnswers_mapsAnswer() {
        let userAnswers = [(multipleAnswerQuestion, ["A1", "A4"])]
        let correctAnswers = [(multipleAnswerQuestion, ["A2", "A3"])]
        let sut = makeSUT(userAnswers: userAnswers, correctAnswers: correctAnswers)
        
        XCTAssertEqual(sut.presentableAnswers.count, 1)
        XCTAssertEqual(sut.presentableAnswers.first!.question, "Q2")
        XCTAssertEqual(sut.presentableAnswers.first!.answer, "A2, A3")
        XCTAssertEqual(sut.presentableAnswers.first!.wrongAnswer, "A1, A4")
    }
    
    func test_presentableAnswers_withTwoQuestions_mapsOrderedAnswers() {
        let userAnswers = [(multipleAnswerQuestion, ["A1", "A4"]), (singleAnswerQuestion, ["A1"])]
        let correctAnswers = [(multipleAnswerQuestion, ["A1", "A4"]), (singleAnswerQuestion, ["A1"])]
        let sut = makeSUT(userAnswers: userAnswers, correctAnswers: correctAnswers)
        
        XCTAssertEqual(sut.presentableAnswers.count, 2)
        XCTAssertEqual(sut.presentableAnswers.first!.question, "Q2")
        XCTAssertEqual(sut.presentableAnswers.first!.answer, "A1, A4")
        XCTAssertEqual(sut.presentableAnswers.first!.wrongAnswer, nil)
        
        XCTAssertEqual(sut.presentableAnswers.count, 2)
        XCTAssertEqual(sut.presentableAnswers.last!.question, "Q1")
        XCTAssertEqual(sut.presentableAnswers.last!.answer, "A1")
        XCTAssertEqual(sut.presentableAnswers.last!.wrongAnswer, nil)
    }
    
    // MARK: - Helpers
    
    private func makeSUT(
            userAnswers: ResultsPresenter.Answers = [],
            correctAnswers: ResultsPresenter.Answers = [],
            score: Int = 0) -> ResultsPresenter {
        return ResultsPresenter(userAnswers: userAnswers,
                                correctAnswers: correctAnswers,
                                scorer: { _,_ in score })
    }

}
