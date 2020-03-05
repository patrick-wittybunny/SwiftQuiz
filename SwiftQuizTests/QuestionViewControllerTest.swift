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
    
    func test_optionSelected_withSingleSelection_notifiesDelegateWithLastSelection() {
        var receivedAnswer = [String]()
        let sut = makeSUT(options: ["A1", "A2"]) { receivedAnswer = $0 }
        
        sut.tableView.select(row: 0)
        XCTAssertEqual(receivedAnswer, ["A1"])
        
        sut.tableView.select(row: 1)
        XCTAssertEqual(receivedAnswer, ["A2"])
    }
    
    func test_optionDeselected_withSingleSelection_doesNotNotifyDelegateWithEmptySelection() {
        
        var callbackCount = 0
        let sut = makeSUT(options: ["A1", "A2"]) { _ in callbackCount += 1 }
        
        sut.tableView.select(row: 0)
        XCTAssertEqual(callbackCount, 1)
        
        sut.tableView.deselect(row: 0)
        XCTAssertEqual(callbackCount, 1)
    }
    
    func test_optionSelected_withMultipleSelectionsEnabled_notifiesDelegateSelection() {
        var receivedAnswer = [String]()
        let sut = makeSUT(options: ["A1", "A2"]) { receivedAnswer = $0 }
        sut.tableView.allowsMultipleSelection = true
        
        sut.tableView.select(row: 0)
        XCTAssertEqual(receivedAnswer, ["A1"])
        
        sut.tableView.select(row: 1)
        XCTAssertEqual(receivedAnswer, ["A1", "A2"])
    }
    
    func test_optionSelected_withMultipleSelectionsEnabled_notifiesDelegate() {
        var receivedAnswer = [String]()
        let sut = makeSUT(options: ["A1", "A2"]) { receivedAnswer = $0 }
        sut.tableView.allowsMultipleSelection = true
        
        sut.tableView.select(row: 0)
        XCTAssertEqual(receivedAnswer, ["A1"])
        
        sut.tableView.deselect(row: 0)
        XCTAssertEqual(receivedAnswer, [])
    }
    
    // MARK: - Helpers
    
    func makeSUT(question: String = "",
                 options: [String] = [],
                 selection: @escaping ([String]) -> Void = { _ in }) -> QuestionViewController {
        let sut = QuestionViewController(question: question, options: options, selection: selection)
        _ = sut.view
        return sut
    }
    
}
