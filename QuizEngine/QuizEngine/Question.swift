//
//  Question.swift
//  SwiftQuiz
//
//  Created by Patrick Domingo on 3/6/20.
//  Copyright © 2020 Patrick Domingo. All rights reserved.
//

import Foundation

public enum Question<T: Hashable>: Hashable {
    case singleAnswer(T)
    case multipleAnswer(T)
}

public enum Answer<T: Hashable>: Hashable {
    case ordered([T])
    case unordered(Set<T>)
    case single(T)
}
