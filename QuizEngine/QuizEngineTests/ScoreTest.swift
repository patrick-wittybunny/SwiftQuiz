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
    
    func test_oneNonMatchingAnswer_scoresZero() {
        XCTAssertEqual(BasicScore.score(for: ["not an match"], comparingTo: ["an answer"]), 0)
    }
    
    func test_oneMatchingAnswer_scoresOne() {
        XCTAssertEqual(BasicScore.score(for: ["an answer"], comparingTo: ["an answer"]), 1)
    }
    
    func test_oneMatchingAnswerOneNonMatching_scoresOne() {
        let score = BasicScore.score(for: ["an answer", "not an match"], comparingTo: ["an answer", "another answer"])
        
        XCTAssertEqual(score, 1)
    }
    
    func test_twoMatchingAnswers_scoresTwo() {
        let score = BasicScore.score(for: ["an answer", "another answer"], comparingTo: ["an answer", "another answer"])
        
        XCTAssertEqual(score, 2)
    }
    
    func test_withTooManyAnswers_twoMatchingAnswers_scoresTwo() {
        let score = BasicScore.score(for: ["an answer", "another answer", "an extra answer"], comparingTo: ["an answer", "another answer"])
        
        XCTAssertEqual(score, 2)
    }
    
    private class BasicScore {
        static func score(for answers: [String], comparingTo matchingAnswers:[String] = []) -> Int {
            if answers.isEmpty { return 0 }
            var score = 0
            for (index, answer) in answers.enumerated() {
                if index >= matchingAnswers.count { return score }
                score += (answer == matchingAnswers[index]) ? 1 : 0
            }
            return score
        }
    }
    
}
