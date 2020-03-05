//
//  ResultsViewController.swift
//  SwiftQuiz
//
//  Created by Patrick Domingo on 3/5/20.
//  Copyright © 2020 Patrick Domingo. All rights reserved.
//

import Foundation
import UIKit

struct PresentableAnswer {
    let isCorrect: Bool
}

class CorrectAnswerCell: UITableViewCell {
    
}
class WrongAnswerCell: UITableViewCell {
    
}

class ResultsViewController: UIViewController {
    
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    private var summary = ""
    private var answers = [PresentableAnswer]()
    
    convenience init(summary: String, answers: [PresentableAnswer]) {
        self.init()
        self.summary = summary
        self.answers = answers
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headerLabel.text = summary
    }
}

extension ResultsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return answers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        return WrongAnswerCell()
        let answer = answers[indexPath.row]
        return answer.isCorrect ? CorrectAnswerCell() : WrongAnswerCell()
    }
    
}
