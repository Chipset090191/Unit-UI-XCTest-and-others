//
//  UnitTests.swift
//  UnitTests
//
//  Created by Mikhail Tikhomirov on 4/21/25.
//

import XCTest
@testable import DeliciousMeal

final class UnitTests: XCTestCase {
    
    var checkoutVC: CheckoutViewController!
    
    override func setUpWithError() throws {
        checkoutVC = CheckoutViewController()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testDataFromTheInternet() throws {
        var menu: [Menu] = []
        
        menu = try Bundle.main.decode(fileName: "Menu.json")
        
        // here we simply assert that we`ve got the full list of images
        XCTAssertTrue(menu.count == 10)
    }
    
    @MainActor
    func testorderAcceptance() async throws {

        checkoutVC.nameOfDish = "TestDish"
        checkoutVC.addressTextField.text = "TestAddress"
        checkoutVC.cityTextField.text = "TestCity"
        checkoutVC.phoneTextField.text = "TestPhone"
        
        await checkoutVC.placeOrder()
        
        XCTAssertNotNil(checkoutVC.acceptedOrder)
        
        if let myOrder = checkoutVC.acceptedOrder {
            XCTAssertEqual(myOrder.orderName, checkoutVC.nameOfDish)
        }
    }
        


}
