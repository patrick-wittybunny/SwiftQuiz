//
//  ResultPresenter.swift
//  SwiftQuiz
//
//  Created by Patrick Domingo on 3/9/20.
//  Copyright © 2020 Patrick Domingo. All rights reserved.
//

import Foundation
import QuizEngine

struct ResultsPresenter {
    let questions: [Question<String>]
    let result: Results<Question<String>, [String]>
    let correctAnswers: Dictionary<Question<String>, [String]>
    
    var summary: String {
        return "You got \(result.score)/\(result.answers.count) correct"
    }
    
    var presentableAnswers: [PresentableAnswer] {
        return questions.map { question in
            guard let userAnswer = result.answers[question] else {
                fatalError("Couldn't find user answer for question: \(question)")
            }
            
            guard let correctAnswer = correctAnswers[question] else {
                fatalError("Couldn't find correct answer for question: \(question)")
            }
            
            return presentableAnswer(question, userAnswer, correctAnswer)
        }
    }
    
    private func presentableAnswer(_ question: Question<String>, _ userAnswer: [String], _ correctAnswer: [String]) -> PresentableAnswer {
        
        switch question {
        case .singleAnswer(let value), .multipleAnswer(let value):
            return PresentableAnswer(question: value,
                                     answer: formattedAnswer(correctAnswer),
                                     wrongAnswer: formattedWrongAnswer(userAnswer, correctAnswer))
        }
    }
    
    private func formattedWrongAnswer(_ userAnswer: [String], _ correctAnswer: [String]) -> String? {
        return correctAnswer == userAnswer ? nil : formattedAnswer(userAnswer)
    }
    
    private func formattedAnswer(_ answer: [String]) -> String {
        return answer.joined(separator: ", ")
    }
}
