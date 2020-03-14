//
//  ToDooUITests.swift
//  ToDooUITests
//
//  Created by tiankai on 2020-01-14.
//  Copyright © 2020 tiankai. All rights reserved.
//

import XCTest
@testable import ToDoo

class ToDooUITests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        let app = XCUIApplication()
        app.launchEnvironment = ["UITEST_DISABLE_ANIMATIONS" : "YES"]
        app.launch()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testExample() {
        
        
        
        let app = XCUIApplication()
        let loginButton = app.buttons["Login"]
        loginButton.tap()
        app.textFields["Email"].tap()
        
        
        let moreKey = app/*@START_MENU_TOKEN@*/.keys["more"]/*[[".keyboards",".keys[\"numbers\"]",".keys[\"more\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/
        moreKey.tap()
        
        let key = app/*@START_MENU_TOKEN@*/.keys["1"]/*[[".keyboards.keys[\"1\"]",".keys[\"1\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        key.tap()
        
        let key2 = app/*@START_MENU_TOKEN@*/.keys["@"]/*[[".keyboards.keys[\"@\"]",".keys[\"@\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        key2.tap()
        
        
        let key3 = app/*@START_MENU_TOKEN@*/.keys["2"]/*[[".keyboards.keys[\"2\"]",".keys[\"2\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        key3.tap()
        
        app.keyboards.children(matching: .other).element.children(matching: .other).element.children(matching: .key).matching(identifier: ".").element(boundBy: 1).tap()
        
        let moreKey2 = app/*@START_MENU_TOKEN@*/.keys["more"]/*[[".keyboards",".keys[\"letters\"]",".keys[\"more\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/
        moreKey2.tap()
        
        
        let cKey = app/*@START_MENU_TOKEN@*/.keys["c"]/*[[".keyboards.keys[\"c\"]",".keys[\"c\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        cKey.tap()
        
        
        let oKey = app/*@START_MENU_TOKEN@*/.keys["o"]/*[[".keyboards.keys[\"o\"]",".keys[\"o\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        oKey.tap()
        
        
        let mKey = app/*@START_MENU_TOKEN@*/.keys["m"]/*[[".keyboards.keys[\"m\"]",".keys[\"m\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        mKey.tap()
        
        app.secureTextFields["Password"].tap()
        moreKey.tap()
        
        
        key.tap()
        
        key3.tap()
        
        let key4 = app/*@START_MENU_TOKEN@*/.keys["3"]/*[[".keyboards.keys[\"3\"]",".keys[\"3\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        key4.tap()
        
        
        let key5 = app/*@START_MENU_TOKEN@*/.keys["4"]/*[[".keyboards.keys[\"4\"]",".keys[\"4\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        key5.tap()
        
        
        let key6 = app/*@START_MENU_TOKEN@*/.keys["5"]/*[[".keyboards.keys[\"5\"]",".keys[\"5\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        key6.tap()
        
        
        let key7 = app/*@START_MENU_TOKEN@*/.keys["6"]/*[[".keyboards.keys[\"6\"]",".keys[\"6\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        key7.tap()
        
        loginButton.tap()
        
        
        
    }
    
    func testDoneUndo() {
        
        let tablesQuery = XCUIApplication().tables
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["paul"]/*[[".cells.staticTexts[\"paul\"]",".staticTexts[\"paul\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.swipeRight()
        tablesQuery/*@START_MENU_TOKEN@*/.buttons["Done"]/*[[".cells.buttons[\"Done\"]",".buttons[\"Done\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["test color 000"]/*[[".cells.staticTexts[\"test color 000\"]",".staticTexts[\"test color 000\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.swipeRight()
        tablesQuery/*@START_MENU_TOKEN@*/.buttons["Done"]/*[[".cells.buttons[\"Done\"]",".buttons[\"Done\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        tablesQuery.staticTexts["color 3"].swipeRight()
        tablesQuery/*@START_MENU_TOKEN@*/.buttons["Done"]/*[[".cells.buttons[\"Done\"]",".buttons[\"Done\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        tablesQuery.staticTexts["color 4"].swipeRight()
        tablesQuery/*@START_MENU_TOKEN@*/.buttons["Done"]/*[[".cells.buttons[\"Done\"]",".buttons[\"Done\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        tablesQuery.staticTexts["color 8"].swipeRight()
        tablesQuery/*@START_MENU_TOKEN@*/.buttons["Done"]/*[[".cells.buttons[\"Done\"]",".buttons[\"Done\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        tablesQuery.staticTexts["testEdit2"].swipeRight()
        tablesQuery/*@START_MENU_TOKEN@*/.buttons["Done"]/*[[".cells.buttons[\"Done\"]",".buttons[\"Done\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        tablesQuery.staticTexts["yyyyy"].swipeRight()
        tablesQuery/*@START_MENU_TOKEN@*/.buttons["Done"]/*[[".cells.buttons[\"Done\"]",".buttons[\"Done\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        tablesQuery.staticTexts["complete"].swipeRight()
        tablesQuery/*@START_MENU_TOKEN@*/.buttons["Done"]/*[[".cells.buttons[\"Done\"]",".buttons[\"Done\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["paul"]/*[[".cells.staticTexts[\"paul\"]",".staticTexts[\"paul\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.swipeRight()
        tablesQuery.buttons["Undo"].tap()
        
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["test color 000"]/*[[".cells.staticTexts[\"test color 000\"]",".staticTexts[\"test color 000\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.swipeRight()
        tablesQuery.buttons["Undo"].tap()
        
        tablesQuery.staticTexts["color 3"].swipeRight()
        tablesQuery.buttons["Undo"].tap()
        
        tablesQuery.staticTexts["color 4"].swipeRight()
        tablesQuery.buttons["Undo"].tap()
        
        tablesQuery.staticTexts["color 8"].swipeRight()
        tablesQuery.buttons["Undo"].tap()
        
        tablesQuery.staticTexts["testEdit2"].swipeRight()
        tablesQuery.buttons["Undo"].tap()
        
        tablesQuery.staticTexts["yyyyy"].swipeRight()
        tablesQuery.buttons["Undo"].tap()
        
        tablesQuery.staticTexts["complete"].swipeRight()
        tablesQuery.buttons["Undo"].tap()
        
        
    }
    
    func testTaskEdit() {
        
        let app = XCUIApplication()
        let tablesQuery = app.tables
        tablesQuery.staticTexts["test"].tap()
        
        
        let editButton = app.buttons["edit"]
        editButton.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.collectionViews/*[[".cells.collectionViews",".collectionViews"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.children(matching: .cell).element(boundBy: 4).children(matching: .other).element.tap()

        app.navigationBars["ToDoo.AddHabitView"].buttons["Done"].tap()
        
        tablesQuery.staticTexts["test"].tap()
        
        
        let deleteButton = app.buttons["Delete habit"]
        deleteButton.tap()
    
    }
    
    
    func testAddNewTask() {
        
        let app = XCUIApplication()
        app.navigationBars["Home"].buttons["plus"].tap()
        
        let app2 = app
        app2.tables/*@START_MENU_TOKEN@*/.textFields["Habit Name"]/*[[".cells.textFields[\"Habit Name\"]",".textFields[\"Habit Name\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        
        let tKey = app2/*@START_MENU_TOKEN@*/.keys["t"]/*[[".keyboards.keys[\"t\"]",".keys[\"t\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        
        tKey.tap()
        
        
        let eKey = app2/*@START_MENU_TOKEN@*/.keys["e"]/*[[".keyboards.keys[\"e\"]",".keys[\"e\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        eKey.tap()
        
        
        let sKey = app2/*@START_MENU_TOKEN@*/.keys["s"]/*[[".keyboards.keys[\"s\"]",".keys[\"s\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        sKey.tap()
        
        tKey.tap()
        app2/*@START_MENU_TOKEN@*/.buttons["Return"]/*[[".keyboards",".buttons[\"return\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.navigationBars["ToDoo.AddHabitView"].buttons["Done"].tap()
        
        
        
        let tablesQuery = app.tables
        tablesQuery.staticTexts["test"].tap()
        
        
        let editButton = app.buttons["edit"]
        editButton.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.collectionViews/*[[".cells.collectionViews",".collectionViews"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.children(matching: .cell).element(boundBy: 4).children(matching: .other).element.tap()

        app.navigationBars["ToDoo.AddHabitView"].buttons["Done"].tap()
        
        tablesQuery.staticTexts["test"].tap()
        
        
        let deleteButton = app.buttons["Delete habit"]
        deleteButton.tap()
        
        
    }
    
    
    func testCountCalder() {
        let app = XCUIApplication()
        XCUIApplication().tabBars.buttons["Calendar"].tap()
        let count1 = app.tables.staticTexts.count
        
        let tabBarsQuery = app.tabBars
        tabBarsQuery.buttons["Home"].tap()
        
        let tablesQuery = app.tables
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["color 3"]/*[[".cells.staticTexts[\"color 3\"]",".staticTexts[\"color 3\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.swipeRight()
        tablesQuery/*@START_MENU_TOKEN@*/.buttons["Done"]/*[[".cells.buttons[\"Done\"]",".buttons[\"Done\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tabBarsQuery.buttons["Calendar"].tap()
        
        let count2 = app.tables.staticTexts.count
        
        print("count1", count1)
        print("count2", count2)
        XCTAssertTrue(count2 - count1 == 2)
        
    }
    
    
    
     func testSettings() {
        
        let app = XCUIApplication()
        let element = app.children(matching: .window).element(boundBy: 4).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 2)
        element.swipeUp()
        element.tap()
        app/*@START_MENU_TOKEN@*/.otherElements["com.ece651project.ToDoo"]/*[[".windows[\"SBSwitcherWindow\"]",".otherElements[\"AppSwitcherContentView\"]",".otherElements[\"ToDoo\"]",".otherElements[\"com.ece651project.ToDoo\"]"],[[[-1,3],[-1,2],[-1,1,2],[-1,0,1]],[[-1,3],[-1,2],[-1,1,2]],[[-1,3],[-1,2]]],[0]]@END_MENU_TOKEN@*/.swipeUp()
        app/*@START_MENU_TOKEN@*/.icons["ToDoo"]/*[[".otherElements[\"Home screen icons\"]",".icons.icons[\"ToDoo\"]",".icons[\"ToDoo\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
                
        
    }
    
    
    
    
    
    
    func testLaunchPerformance() {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
}
