//
//  ResultsHelper.swift
//  SwiftQuizTests
//
//  Created by Patrick Domingo on 3/9/20.
//  Copyright © 2020 Patrick Domingo. All rights reserved.
//

import Foundation
import QuizEngine

extension Results: Hashable {
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(1)
    }
    
    public static func == (lhs: Results<Question, Answer>, rhs: Results<Question, Answer>) -> Bool {
        return lhs.score == rhs.score
    }
    
}
