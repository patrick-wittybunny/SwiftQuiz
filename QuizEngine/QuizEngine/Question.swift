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
    
    public func hash(into hasher: inout Hasher) {
        switch self {
        case .singleAnswer(let a):
            hasher.combine(a)
        case .multipleAnswer(let a):
            hasher.combine(a)
        }
    }
    
}
