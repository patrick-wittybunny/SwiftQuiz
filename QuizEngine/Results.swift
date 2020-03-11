//
//  Results.swift
//  QuizEngine
//
//  Created by Patrick Domingo on 3/6/20.
//  Copyright © 2020 Patrick Domingo. All rights reserved.
//

import Foundation

public struct Results<Question: Hashable, Answer> {
    public var answers: [Question: Answer]
    public var score: Int
}
