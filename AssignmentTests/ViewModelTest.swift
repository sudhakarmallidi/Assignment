//
//  ViewModelTest.swift
//  AssignmentTests
//
//  Created by sudhakar reddy on 06/10/19.
//  Copyright © 2019 sudhakar reddy. All rights reserved.
//

import XCTest
@testable import Assignment
class DataListViewModelTest: XCTestCase {
    var viewModel: ViewModel?
    var responseDataModel: ResponseDataModel?
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        viewModel = ViewModel()
        //let dataResult = DataResult(resourceID: "1", fields: [], records: [], links: nil, limit: 1, total: 3)
        let result = DataResult(resourceID: "1", fields: [], records: [], links: nil,
                                limit: 1,
                                total: 3)
        self.responseDataModel = ResponseDataModel(help: "", success: true,
                                              result: result)
        
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
