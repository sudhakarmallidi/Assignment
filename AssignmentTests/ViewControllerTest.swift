//
//  ViewControllerTest.swift
//  AssignmentTests
//
//  Created by sudhakar reddy on 06/10/19.
//  Copyright © 2019 sudhakar reddy. All rights reserved.
//

import XCTest
@testable import Assignment
class DataListViewControllerTest: XCTestCase {
    var viewController: ViewController!
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        self.viewController = storyBoard.instantiateViewController(withIdentifier: "DataListViewController") as? ViewController
        DispatchQueue.main.async {
            self.viewController.loadView()
            self.viewController.viewDidLoad()
            self.viewController.viewWillAppear(true)
        }
    }
    
    func testCollectionView() {
        XCTAssertNotNil(self.viewController.view)
        XCTAssertNotNil(self.viewController.collectionView)
        XCTAssert(self.viewController.conforms(to: UICollectionViewDataSource.self))
        XCTAssertTrue(self.viewController.responds(to: #selector(self.viewController.collectionView(_:numberOfItemsInSection:))))
        XCTAssertTrue(self.viewController.responds(to: #selector(self.viewController.collectionView(_:cellForItemAt:))))
        //XCTAssertNotNil(viewController.collectionView.delegate)
        XCTAssert(self.viewController.conforms(to: UICollectionViewDelegate.self))
        XCTAssert(self.viewController.conforms(to: UICollectionViewDelegateFlowLayout.self))
        XCTAssertTrue(viewController.responds(to: #selector(viewController.collectionView(_:layout:sizeForItemAt:))))
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
