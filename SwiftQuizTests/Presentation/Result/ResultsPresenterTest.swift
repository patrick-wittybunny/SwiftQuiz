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
        let sut = ResultsPresenter(questions: [], result: .make(), correctAnswers: [:])
        
        XCTAssertEqual(sut.title, "Result")
    }
    
    func test_summary_withTwoQuestionsAndScoreOne_returnsSummary() {
        let answers = [singleAnswerQuestion: ["A1"], multipleAnswerQuestion: ["A2", "A3"]]
        let result = Results.make(answers: answers, score: 1)
        let orderedQuestions = [singleAnswerQuestion, multipleAnswerQuestion]
        let sut = ResultsPresenter(questions: orderedQuestions, result: result, correctAnswers: [:])
        XCTAssertEqual(sut.summary, "You got 1/2 correct")
    }
    
    func test_presentableAnswers_withoutQuestions_isEmpty() {
        let sut = ResultsPresenter(questions: [], result: .make(), correctAnswers: [:])
        
        XCTAssertTrue(sut.presentableAnswers.isEmpty)
    }
    
    func test_presentableAnswers_withWrongSingleAnswer_mapsAnswer() {
        let answers = [singleAnswerQuestion: ["A1"]]
        let correctAnswers = [singleAnswerQuestion: ["A2"]]
        let result = Results.make(answers: answers, score: 0)
        let sut = ResultsPresenter(questions: [singleAnswerQuestion], result: result, correctAnswers: correctAnswers)
        
        XCTAssertEqual(sut.presentableAnswers.count, 1)
        XCTAssertEqual(sut.presentableAnswers.first!.question, "Q1")
        XCTAssertEqual(sut.presentableAnswers.first!.answer, "A2")
        XCTAssertEqual(sut.presentableAnswers.first!.wrongAnswer, "A1")
    }
    
    func test_presentableAnswers_withWrongMultipleAnswers_mapsAnswer() {
        let answers = [multipleAnswerQuestion: ["A1", "A4"]]
        let correctAnswers = [multipleAnswerQuestion: ["A2", "A3"]]
        let result = Results.make(answers: answers, score: 0)
        let sut = ResultsPresenter(questions: [multipleAnswerQuestion], result: result, correctAnswers: correctAnswers)
        
        XCTAssertEqual(sut.presentableAnswers.count, 1)
        XCTAssertEqual(sut.presentableAnswers.first!.question, "Q2")
        XCTAssertEqual(sut.presentableAnswers.first!.answer, "A2, A3")
        XCTAssertEqual(sut.presentableAnswers.first!.wrongAnswer, "A1, A4")
    }
    
    func test_presentableAnswers_withTwoQuestions_mapsOrderedAnswers() {
        let answers = [multipleAnswerQuestion: ["A1", "A4"], singleAnswerQuestion: ["A1"]]
        let correctAnswers = [multipleAnswerQuestion: ["A1", "A4"], singleAnswerQuestion: ["A1"]]
        let orderedQuestions = [singleAnswerQuestion, multipleAnswerQuestion]
        let result = Results.make(answers: answers, score: 2)
        let sut = ResultsPresenter(questions: orderedQuestions, result: result, correctAnswers: correctAnswers)
        
        XCTAssertEqual(sut.presentableAnswers.count, 2)
        XCTAssertEqual(sut.presentableAnswers.first!.question, "Q1")
        XCTAssertEqual(sut.presentableAnswers.first!.answer, "A1")
        XCTAssertEqual(sut.presentableAnswers.first!.wrongAnswer, nil)
        
        XCTAssertEqual(sut.presentableAnswers.count, 2)
        XCTAssertEqual(sut.presentableAnswers.last!.question, "Q2")
        XCTAssertEqual(sut.presentableAnswers.last!.answer, "A1, A4")
        XCTAssertEqual(sut.presentableAnswers.last!.wrongAnswer, nil)
    }

}
