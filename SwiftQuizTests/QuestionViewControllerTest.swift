//
//  QuestionViewControllerTest.swift
//  SwiftQuizTests
//
//  Created by Patrick Domingo on 3/5/20.
//  Copyright © 2020 Patrick Domingo. All rights reserved.
//

import Foundation
import XCTest
@testable import SwiftQuiz

class QuestionViewControllerTest: XCTestCase {
    
    func test_viewDidLoad_rendersHeaderText() {
        XCTAssertEqual(makeSUT(question: "Q1").headerLabel.text, "Q1")
    }
    
    func test_viewDidLoad_renderOptions() {
        // if options is empty
        XCTAssertEqual(makeSUT(options: []).tableView.numberOfRows(inSection: 0), 0)
        // if there is an option
        XCTAssertEqual(makeSUT(options: ["A1"]).tableView.numberOfRows(inSection: 0), 1)
        XCTAssertEqual(makeSUT(options: ["A1", "A2"]).tableView.numberOfRows(inSection: 0), 2)
    }
    
    func test_viewDidLoad_rendersOptionsText() {
        XCTAssertEqual(makeSUT(options: ["A1"]).tableView.title(at: 0), "A1")
        XCTAssertEqual(makeSUT(options: ["A1", "A2"]).tableView.title(at: 0), "A1")
        XCTAssertEqual(makeSUT(options: ["A1", "A2"]).tableView.title(at: 1), "A2")
    }
    
    func test_optionSelected_notifiesDelegate() {
        var receivedAnswer = ""
        let sut = makeSUT(options: ["A1"]) {
            receivedAnswer = $0
        }
        
        let indexPath = IndexPath(row: 0, section: 0)
        sut.tableView.delegate?.tableView?(sut.tableView, didSelectRowAt: indexPath)
        
        XCTAssertEqual(receivedAnswer, "A1")
    }
    
    // MARK: - Helpers
    
    func makeSUT(question: String = "",
                 options: [String] = [],
                 selection: @escaping (String) -> Void = { _ in }) -> QuestionViewController {
        let sut = QuestionViewController(question: question, options: options, selection: selection)
        _ = sut.view
        return sut
    }
    
}

private extension UITableView {
    
    func cell(at row: Int) -> UITableViewCell? {
        return dataSource?.tableView(self, cellForRowAt: IndexPath(row: row, section: 0))
    }
    
    func title(at row: Int) -> String? {
        return cell(at: row)?.textLabel?.text
    }
}
