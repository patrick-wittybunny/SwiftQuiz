//
//  QuizTest.swift
//  QuizEngine
//
//  Created by Patrick Domingo on 3/11/20.
//  Copyright © 2020 Patrick Domingo. All rights reserved.
//

import Foundation
import XCTest
import QuizEngine

class QuizTest: XCTestCase {
    
    private var quiz: Quiz?
    
    func test_startQuiz_answerOneOutOfTwoCorrectly_scores1() {
        let delegate = DelegateSpy()
        
        quiz = Quiz.start(questions: ["Q1", "Q2"], delegate: delegate, correctAnswers: ["Q1": "A1", "Q2" : "A2"])
        
        delegate.answerCompletion("A1")
        delegate.answerCompletion("A2")
        
        assertEqual(delegate.completedQuizzes[0], [("Q1", "A1"), ("Q2", "A2")])
    }
    
    // MARK: - Helpers
    
    private func assertEqual(_ a1: [(String, String)], _ a2: [(String, String)], file: StaticString = #file, line: UInt = #line) {
        XCTAssertTrue(a1.elementsEqual(a2, by: ==), "\(a1) is not euqal to \(a2)", file: file, line: line)
    }
    
    private class DelegateSpy: QuizDelegate {
        
        var completedQuizzes: [[(String, String)]] = []
    
        var answerCompletion: (String) -> Void = { _ in }
        
        func answer(for question: String, completion answerCallback: @escaping (String) -> Void) {
            self.answerCompletion = answerCallback
        }
        
        func didCompleteQuiz(withAnswers answers: [(question: String, answer: String)]) {
            completedQuizzes.append(answers)
        }
        
        func handle(result: Results<String, String>) {}
    }
    
}
