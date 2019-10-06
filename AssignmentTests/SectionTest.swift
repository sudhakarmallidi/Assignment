//
//  SectionTest.swift
//  AssignmentTests
//
//  Created by sudhakar reddy on 07/10/19.
//  Copyright © 2019 sudhakar reddy. All rights reserved.
//

import XCTest
@testable import Assignment
class SectionTest: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSectionStructureModel() {
        let sectionObj = Section(records: [Record](), yearObj: "2019")
        XCTAssertNotNil(sectionObj)
        XCTAssertNotNil(sectionObj.year)
        XCTAssertTrue(sectionObj.year == "2019")
        XCTAssertTrue(sectionObj.rows.isEmpty)
        XCTAssertNotNil(sectionObj.totalVolumeOfData)
        XCTAssertTrue(sectionObj.totalVolumeOfData == 0.0)
    }
    func testSectionNextMethod() {
        
        var records: [Record]?
        let json = "[{\"volume_of_mobile_data\": \"16.47121\", \"quarter\": \"2018-Q1\", \"_id\": 55}, {\"volume_of_mobile_data\": \"18.47368\", \"quarter\": \"2018-Q2\", \"_id\": 56}, {\"volume_of_mobile_data\": \"19.97554729\", \"quarter\": \"2018-Q3\", \"_id\": 57}, {\"volume_of_mobile_data\": \"20.43921113\", \"quarter\": \"2018-Q4\", \"_id\": 58}]"
        do {
            records = try JSONDecoder().decode([Record].self, from: json.data(using: .utf8)!)
        } catch {
            print(error)
            XCTFail()
        }

        var sectionObj = Section(records: records ?? [Record](), yearObj: "2018")
        XCTAssertNotNil(sectionObj)
        XCTAssertNotNil(sectionObj.year)
        XCTAssertTrue(sectionObj.year == "2018")
        XCTAssertNotNil(sectionObj.rows)
        XCTAssertTrue(!sectionObj.rows.isEmpty)
        XCTAssertNotNil(sectionObj.totalVolumeOfData)
        XCTAssertTrue(sectionObj.totalVolumeOfData == 75.35964842)
        XCTAssertNotNil(sectionObj.minVolOfMobileData)
        let obj = sectionObj.next()
        XCTAssertNotNil(obj)
    }

}
