//
//  DelegateSpy.swift
//  QuizEngineTests
//
//  Created by Patrick Domingo on 3/12/20.
//  Copyright © 2020 Patrick Domingo. All rights reserved.
//

import Foundation
import QuizEngine

class DelegateSpy: QuizDelegate {
       var questionsAsked: [String] = []
       var answerCompletions: [(String) -> Void] = []

       var completedQuizzes: [[(String, String)]] = []
       
       func answer(for question: String, completion: @escaping (String) -> Void) {
           questionsAsked.append(question)
           answerCompletions.append(completion)
       }
       
       func didComplete(withAnswers answers: [(question: String, answer: String)]) {
           completedQuizzes.append(answers)
       }
   }
