//
//  UITests.swift
//  UITests
//
//  Created by Mikhail Tikhomirov on 4/21/25.
//

import XCTest

final class UITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    @MainActor
    func testMainOrderingWithOptions() throws {
        
        // run app from the start screen
        let app = XCUIApplication()
        app.activate()
        // we`ve previously added accesibility identifier for our button (look at the ViewController)
        let button = app.navigationBars.buttons["addOrder"]
        
        // check the button existence
        XCTAssertTrue(button.exists)
        button.tap()
        
        // check the existence of Menu VC
        XCTAssert(app.navigationBars["Menu"].waitForExistence(timeout: 1.0))
        
        // here we choose the second "Gold potato" item. This is a right applying.
        let choosedCell = app.collectionViews.cells.element(boundBy: 1)
        
        // or you can leverage another simple way like, it`s not good but anyway.
        // let choosedCell = app.collectionViews.staticTexts["Gold potato"]
        
        XCTAssert(choosedCell.exists)
        choosedCell.tap()
        
        // suppose to get access to extra options button and tap it
        app.tables.staticTexts["Extra options"].tap()
        
        // make switches activated inside of this loop
        for switch_element in app.switches.allElementsBoundByIndex {
            switch_element.tap()
        }
        
        // then we check Increment functionality of steppers
        for button in app.buttons.matching(identifier: "Increment").allElementsBoundByIndex {
            if button.identifier == "mainStepper-Increment" {
                button.doubleTap()
            } else {
                button.tap()
            }
        }
        
        // and then check Decrement functionality
        app.buttons["mainStepper-Decrement"].tap()
        
        // and finally on extra options we test picker. So as it is only one element we write "firts match"
        app.pickers.firstMatch.swipeUp()
        
        // then we go back to OrderVC
        app.buttons["Back"].tap()
        
        // confirm order
        app/*@START_MENU_TOKEN@*/.buttons["add to shopping cart"]/*[[".navigationBars.buttons[\"add to shopping cart\"]",".buttons[\"add to shopping cart\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        // asserting our alert on this step
        XCTAssert(app.alerts["Information about Your order"].waitForExistence(timeout: 1.0))
        
        app.buttons["Yes"].tap()
        
        XCTAssertTrue(app.staticTexts["Delivery address"].waitForExistence(timeout: 1.0))
        
        let addressField = app.textFields["addressField"]
        let cityField = app.textFields["cityField"]
        let phoneField = app.textFields["phoneField"]
        
        XCTAssertTrue(addressField.exists)
        XCTAssertTrue(cityField.exists)
        XCTAssert(phoneField.exists)
        
        addressField.tap()
        addressField.typeText("StreetTest")
        
        cityField.tap()
        cityField.typeText("CityTest")
        
        phoneField.tap()
        phoneField.typeText("phoneField")
        
        app.buttons["Accept"].tap()
        
        // and asserting our alert on the final step. Gotcha we are ordered food.
        XCTAssert(app.alerts["Accepted"].waitForExistence(timeout: 2.0))
       
    }

    
}
