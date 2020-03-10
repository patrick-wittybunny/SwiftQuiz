//
//  ResultsHelper.swift
//  SwiftQuizTests
//
//  Created by Patrick Domingo on 3/9/20.
//  Copyright © 2020 Patrick Domingo. All rights reserved.
//

import Foundation

@testable import QuizEngine

extension Results {
    static func make(answers: [Question: Answer] = [:], score: Int = 0) -> Results<Question, Answer> {
        return Results(answers: answers, score: score)
    }
}

extension Results: Equatable where Answer: Equatable {
    public static func == (lhs: Results<Question, Answer>, rhs: Results<Question, Answer>) -> Bool {
        return lhs.score == rhs.score && lhs.answers == rhs.answers
    }
}

extension Results: Hashable where Answer: Equatable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(1)
    }
}
