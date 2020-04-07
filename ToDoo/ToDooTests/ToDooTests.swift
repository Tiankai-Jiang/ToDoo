//
//  ToDooTests.swift
//  ToDooTests
//
//  Created by tiankai on 2020-01-14.
//  Copyright © 2020 tiankai. All rights reserved.
//

import XCTest
@testable import ToDoo

class Calculate{
    func getIfCheckedArray(_ checked: [String: Int], _ start: Int) -> [Bool]{
        print(checked, start)
        let interval = 1 + epochTimeDaysInterval(start, Int(Date().timeIntervalSince1970))
        var ifChecked: Array<Bool> = Array(repeating: false, count: interval)
        checked.forEach{
            ifChecked[epochTimeDaysInterval(start, $1)] = true
        }
        print(ifChecked)
        return ifChecked
    }
    
    func getLongestStreak(_ ifChecked: [Bool]) -> Int{
        var cur = 0
        var max = 0
        for v in ifChecked{
            cur = v ? cur + 1 : 0
            max = cur > max ? cur : max
        }
        return max
    }
    
    func getCurrentStreak(_ ifChecked: [Bool]) -> Int{
        if(ifChecked.count == 1){
            return ifChecked[0] ? 1 : 0
        }else{
            var res = 0
            for v in (0 ... ifChecked.count - 2).reversed(){
                if(ifChecked[v]){
                    res += 1
                }else{
                    break
                }
            }
            if(ifChecked.last!){
                res += 1
            }
            return res
        }
    }
}

class ToDooTests: XCTestCase {
    let test = HomeViewController()
    let c = Calculate()
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    func testGetIfCheckedArray(){
        XCTAssertTrue(c.getIfCheckedArray(["1584201601": 1584235799, "1583514001": 1583532971, "1583341201": 1583333375],1583333362) == [true, false, true, false, false, false, false, false, false, false, true, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false])
        XCTAssertTrue(c.getIfCheckedArray(["1584201601": 1584235799, "1583514001": 1583532971, "1583341201": 1583333375],1583333362) == [true, false, true, false, false, false, false, false, false, false, true, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false])
        XCTAssertTrue(c.getIfCheckedArray(["1584201601": 1584235712],1584235570) == [true, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false])
        //empty list
        XCTAssertTrue(c.getIfCheckedArray([:], Int(Date().timeIntervalSince1970)) == [false])
    }
    func testGetLongestStreak(){
        XCTAssertTrue(c.getLongestStreak([true,false,false,true, true,true]) == 3)
        XCTAssertTrue(c.getLongestStreak([true, false, false, false, false, false, false, true, false, true, false, true, false, false, false, false, true, true, false, false, false, false, true, false, false]) == 2)
        XCTAssertTrue(c.getLongestStreak([true, false, false, false, false, false, false, true, false, true, false, false, false, false, false, false, true, true, false, false, false, true, true, false, false]) == 2)
         XCTAssertTrue(c.getLongestStreak([true, true, false, false, false, true, true, false, false]) == 2)
        //test empty list
        XCTAssertTrue(c.getLongestStreak([]) == 0)
        
    }
    
    func testGetCurrentStreak(){
        XCTAssertTrue(c.getCurrentStreak([true]) == 1)
        XCTAssertTrue(c.getCurrentStreak([false]) == 0)
        XCTAssertTrue(c.getCurrentStreak([true, true]) == 2)
        XCTAssertTrue(c.getCurrentStreak([false, false]) == 0)
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
