//
//  ToDooTests.swift
//  ToDooTests
//
//  Created by tiankai on 2020-01-14.
//  Copyright © 2020 tiankai. All rights reserved.
//

import XCTest
@testable import ToDoo


class ToDooTests: XCTestCase {
    let test = HomeViewController()
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
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
    func testGetIfCheckedArray(){
        XCTAssertTrue(test.getIfCheckedArray(["1584115201": 1584134002, "1583427601": 1583434543, "1583082001": 1583091393, "1584201601": 1584235321, "1583683201": 1583698862, "1582304401": 1582346843, "1583769601": 1583735499], 1582299129) == [true, false, false, false, false, false, false, false, false, true, false, false, false, true, false, false, true, true, false, false, false, true, true, false, false])
        XCTAssertTrue(test.getIfCheckedArray(["1584201601": 1584235313, "1582304401": 1582318432, "1583683201": 1583703456, "1583769601": 1583810625, "1583082001": 1583091389, "1583254801": 1583259912, "1582909201": 1582940449], 1582299058) == [true, false, false, false, false, false, false, true, false, true, false, true, false, false, false, false, true, true, false, false, false, false, true, false, false])
        XCTAssertTrue(test.getIfCheckedArray(["1583769601": 1583810673, "1583683201": 1583700549, "1584201601": 1584240876], 1583700544) == [true, true, false, false, false, false, true, false, false])
    }
    func testGetLongestStreak(){
        XCTAssertTrue(test.getLongestStreak([true,false,false,true, true,true]) == 3)
        XCTAssertTrue(test.getLongestStreak([true, false, false, false, false, false, false, true, false, true, false, true, false, false, false, false, true, true, false, false, false, false, true, false, false]) == 2)
        XCTAssertTrue(test.getLongestStreak([true, false, false, false, false, false, false, true, false, true, false, false, false, false, false, false, true, true, false, false, false, true, true, false, false]) == 2)
         XCTAssertTrue(test.getLongestStreak([true, true, false, false, false, true, true, false, false]) == 2)
    }
    func testGetCurrentStreak(){
        XCTAssertTrue(test.getCurrentStreak([true,false,false,false, true,true]) == 2)
        XCTAssertTrue(test.getCurrentStreak([true,false,false,false,false,true]) == 1)
        XCTAssertTrue(test.getCurrentStreak([true, false, false, false, false, false, false, true, false, true, false, false, false, false, false, false, true, true, false, false, false, true, true, false, false]) == 0)
        XCTAssertTrue(test.getCurrentStreak([true, true, false, false, false, true, true, false, false]) == 0)
    }
}
