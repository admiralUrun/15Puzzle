//
//  StopwatchTest.swift
//  15 puzzleTests
//
//  Created by Andrew Yakovenko on 6/11/19.
//  Copyright © 2019 Andrew Yakovenko. All rights reserved.
//

import XCTest

class StopwatchTest: XCTestCase {

    var stopwatch: StopWatch!
    override func setUp() {
        stopwatch = StopWatch()
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
