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
        // Launch the app from the initial screen
        let app = XCUIApplication()
        app.activate()
        // Access the "Add Order" button using its accessibility identifier (defined in ViewController)
        let button = app.navigationBars.buttons["addOrder"]
        
        // Verify the button exists and simulate a tap
        XCTAssertTrue(button.exists)
        button.tap()
        
        // Confirm that the Menu view controller is displayed
        XCTAssert(app.navigationBars["Menu"].waitForExistence(timeout: 1.0))
        
        // Select the second menu item (e.g., "Gold potato")
        // Alternatively, access the cell using a label (less reliable)
        // let choosedCell = app.collectionViews.staticTexts["Gold potato"]
        let choosedCell = app.collectionViews.cells.element(boundBy: 1)
        
        
        XCTAssert(choosedCell.exists)
        choosedCell.tap()
        
        // Navigate to the "Extra Options" section
        app.tables.staticTexts["Extra options"].tap()
        
        // Toggle all available switches
        for switch_element in app.switches.allElementsBoundByIndex {
            switch_element.tap()
        }
        
        // Test the increment functionality of steppers
        for button in app.buttons.matching(identifier: "Increment").allElementsBoundByIndex {
            if button.identifier == "mainStepper-Increment" {
                button.doubleTap()
            } else {
                button.tap()
            }
        }
        
        // Test the decrement functionality for the main stepper
        app.buttons["mainStepper-Decrement"].tap()
        
        // Interact with the picker (swipe up on the first available picker)
        app.pickers.firstMatch.swipeUp()
        
        // Navigate back to the Order view controller
        app.buttons["Back"].tap()
        
        // Confirm the order by tapping the cart button
        app/*@START_MENU_TOKEN@*/.buttons["add to shopping cart"]/*[[".navigationBars.buttons[\"add to shopping cart\"]",".buttons[\"add to shopping cart\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        // Verify that the confirmation alert appears
        XCTAssert(app.alerts["Information about Your order"].waitForExistence(timeout: 1.0))
        
        // Confirm the alert by tapping "Yes"
        app.buttons["Yes"].tap()
        
        // Ensure the Checkout view controller is displayed
        XCTAssertTrue(app.staticTexts["Delivery address"].waitForExistence(timeout: 1.0))
        
        // Access the text fields using assigned accessibility identifiers
        let addressField = app.textFields["addressField"]
        let cityField = app.textFields["cityField"]
        let phoneField = app.textFields["phoneField"]
        
        // Verify all input fields exist
        XCTAssertTrue(addressField.exists)
        XCTAssertTrue(cityField.exists)
        XCTAssert(phoneField.exists)
        
        // Populate each field with test data
        addressField.tap()
        addressField.typeText("StreetTest")
        
        cityField.tap()
        cityField.typeText("CityTest")
        
        phoneField.tap()
        phoneField.typeText("phoneField")
        
        // Finalize the order by tapping the "Accept" button
        app.buttons["Accept"].tap()
        
        // Confirm the final success alert appears
        XCTAssert(app.alerts["Accepted"].waitForExistence(timeout: 2.0))
        
    }

    
}
