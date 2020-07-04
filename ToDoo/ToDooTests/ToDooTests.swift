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
//    let test = HomeViewController()
    let c = Calculate()
    override func setUp() {
        
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
        XCTAssertTrue(c.getIfCheckedArray([:], Int(Date().timeIntervalSince1970)) == [false])
        XCTAssertTrue(c.getIfCheckedArray([:], 1585742965) == [false, false, false, false, false, false, false])
        print(c.getIfCheckedArray(["1583769601": 1583810673, "1583683201": 1583700549, "1584201601": 1584240876], 1583700544))
        
        
        
        
        
//        XCTAssertTrue(c.getIfCheckedArray(["1584115201": 1584134002, "1583427601": 1583434543, "1583082001": 1583091393, "1584201601": 1584235321, "1583683201": 1583698862, "1582304401": 1582346843, "1583769601": 1583735499], 1582299129) == [true, false, false, false, false, false, false, false, false, true, false, false, false, true, false, false, true, true, false, false, false, true, true, false, false])
//        XCTAssertTrue(c.getIfCheckedArray(["1584201601": 1584235313, "1582304401": 1582318432, "1583683201": 1583703456, "1583769601": 1583810625, "1583082001": 1583091389, "1583254801": 1583259912, "1582909201": 1582940449], 1582299058) == [true, false, false, false, false, false, false, true, false, true, false, true, false, false, false, false, true, true, false, false, false, false, true, false, false])
//        XCTAssertTrue(c.getIfCheckedArray(["1583769601": 1583810673, "1583683201": 1583700549, "1584201601": 1584240876], 1583700544) == [true, true, false, false, false, false, true, false, false])
    }
    func testGetLongestStreak(){
        XCTAssertTrue(c.getLongestStreak([]) == 0)
        XCTAssertTrue(c.getCurrentStreak([false]) == 0)
        XCTAssertTrue(c.getCurrentStreak([true]) == 1)
        XCTAssertTrue(c.getCurrentStreak([true, true]) == 2)
        XCTAssertTrue(c.getCurrentStreak([false, false]) == 0)
        XCTAssertTrue(c.getLongestStreak([true,false,false,true, true,true]) == 3)
        XCTAssertTrue(c.getLongestStreak([true, false, false, false, false, false, false, true, false, true, false, true, false, false, false, false, true, true, false, false, false, false, true, false, false]) == 2)
        XCTAssertTrue(c.getLongestStreak([true, false, false, false, false, false, false, true, false, true, false, false, false, false, false, false, true, true, false, false, false, true, true, false, false]) == 2)
         XCTAssertTrue(c.getLongestStreak([true, true, false, false, false, true, true, false, false]) == 2)
    }
    func testGetCurrentStreak(){
        XCTAssertTrue(c.getCurrentStreak([true]) == 1)
        XCTAssertTrue(c.getCurrentStreak([false]) == 0)
        XCTAssertTrue(c.getCurrentStreak([true,false,false,false, true,true]) == 2)
        XCTAssertTrue(c.getCurrentStreak([true,false,false,false,false,true]) == 1)
        XCTAssertTrue(c.getCurrentStreak([true, false, false, false, false, false, false, true, false, true, false, false, false, false, false, false, true, true, false, false, false, true, true, false, false]) == 0)
        XCTAssertTrue(c.getCurrentStreak([true, true, false, false, false, true, true, false, false]) == 0)
        XCTAssertTrue(c.getCurrentStreak([true, true, false, false, false, true, true, true, false]) == 3)
    }
    
    func testEpochTimeDaysInterval(){
        XCTAssertTrue(epochTimeDaysInterval(1585742965, 1585742965) == 0)
        XCTAssertTrue(epochTimeDaysInterval(1585742965, 1585829365) == 1)
        XCTAssertTrue(epochTimeDaysInterval(1585742965, 1586347765) == 7)
    }
    
    func testEpochTimeToString(){
        XCTAssertTrue(epochTimeToString(1582978165, "yyyy-MM-dd") == "2020-02-29")
        XCTAssertTrue(epochTimeToString(1585742965, "yyyy-MM-dd") == "2020-04-01")
        XCTAssertTrue(epochTimeToString(1577794165, "yyyy-MM-dd") == "2019-12-31")
        XCTAssertTrue(epochTimeToString(0, "yyyy-MM-dd") == "1969-12-31")
    }
}
