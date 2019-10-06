//
//  ExtensionsTest.swift
//  AssignmentTests
//
//  Created by sudhakar reddy on 07/10/19.
//  Copyright © 2019 sudhakar reddy. All rights reserved.
//

import XCTest
@testable import Assignment
class ExtensionsTest: XCTestCase {
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    func testArraySafeIndex() {
        let array: [Int] = [10,20,30]
        XCTAssertTrue(array[safe: 1] == 20)
        XCTAssertNotNil(array[safe: 0])
        XCTAssertNil(array[safe: 10])
    }
}
