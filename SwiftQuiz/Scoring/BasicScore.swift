//
//  BasicScore.swift
//  SwiftQuiz
//
//  Created by Patrick Domingo on 3/12/20.
//  Copyright © 2020 Patrick Domingo. All rights reserved.
//

import Foundation

final class BasicScore {
    static func score(for answers: [String], comparingTo matchingAnswers:[String] = []) -> Int {
        return zip(answers, matchingAnswers).reduce(0) { score, tuple in
            return score + (tuple.0 == tuple.1 ? 1 : 0)
        }
    }
}
