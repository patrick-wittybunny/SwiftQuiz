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
    
    
    private class BasicScore {
        static func score(for answers: [String], comparingTo correctAnswers:[String] = []) -> Int {
            if answers.isEmpty { return 0 }
            return answers == correctAnswers ? 1 : 0
        }
    }
    
}
