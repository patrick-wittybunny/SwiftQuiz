//
//  ScoreTest.swift
//  QuizEngineTests
//
//  Created by Patrick Domingo on 3/12/20.
//  Copyright © 2020 Patrick Domingo. All rights reserved.
//

import Foundation
import XCTest

class ScoreTest: XCTestCase {
    
    func test_noAnswers_scoresZero() {
        XCTAssertEqual(BasicScore.score(for: [], comparingTo: []), 0)
    }
    
    func test_oneWrongAnswer_scoresZero() {
        XCTAssertEqual(BasicScore.score(for: ["wrong"], comparingTo: ["correct"]), 0)
    }
    
    func test_oneCorrectAnswer_scoresOne() {
        XCTAssertEqual(BasicScore.score(for: ["correct"], comparingTo: ["correct"]), 1)
    }
    
    func test_oneCorrectAnswerOneWrong_scoresOne() {
        let score = BasicScore.score(for: ["correct", "wrong"], comparingTo: ["correct", "correct 2"])
        
        XCTAssertEqual(score, 1)
    }
    
    func test_twoCorrectAnswers_scoresTwo() {
        let score = BasicScore.score(for: ["correct", "correct 2"], comparingTo: ["correct", "correct 2"])
        
        XCTAssertEqual(score, 2)
    }
    
    func test_withUnequalSizeData() {
        let score = BasicScore.score(for: ["correct", "correct 2", "an extra answer"], comparingTo: ["correct", "correct 2"])
        
        XCTAssertEqual(score, 2)
    }
    
    private class BasicScore {
        static func score(for answers: [String], comparingTo correctAnswers:[String] = []) -> Int {
            if answers.isEmpty { return 0 }
            var score = 0
            for (index, answer) in answers.enumerated() {
                if index >= correctAnswers.count { return score }
                score += (answer == correctAnswers[index]) ? 1 : 0
            }
            return score
        }
    }
    
}
