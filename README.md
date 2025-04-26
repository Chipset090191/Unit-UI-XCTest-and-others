# Unit-UI-XCTest-and-others

### Project `DeliciousMeal` and Unit\UI Tests by using XCTest framework.
Introduction to App Testing
In this section, I’ll walk you through some foundational techniques for testing iOS applications. While I haven’t written tests for every single feature of my `DeliciousMeal` app, I have focused on covering the most critical and sensitive components. 

## Unit tests.
### Step 1: Setting Up Unit Tests



We’ll begin with unit testing. I am gonna give you the sequance of actions for adding a ` Unit test target` to Xcode Project😁. 
To get started:
- Open `DeliciousMeal` project in Xcode and choose File -> New -> Target;
- In search field type `Unit` and choose `Unit Testing Bundle` click next;
- In Product name give the `name` and choose XCtest(testing systme) as you can see on `Pic 1` screenshots. I put the name `UnitTests`.

Now you you know how to add the target. For my app `DeliciousMeal` I have added it yet so you do not need this one. Instead of doing this just locate and open the file - [UnitTests](https://github.com/Chipset090191/Unit-UI-XCTest-and-others/blob/main/DeliciousMeal%20with%20tests/UnitTests/UnitTests.swift).

#### Pic #1
<div align="center">
<img width="727" alt="Screenshot 2025-04-25 at 1 41 20 AM" src="https://github.com/user-attachments/assets/4013ddef-7932-48b3-8956-36c5c404874b" />
<img width="729" alt="Screenshot 2025-04-25 at 1 49 35 AM" src="https://github.com/user-attachments/assets/be822625-2c57-4146-867b-0c06d33b5e75" />
</div>

### Step 2: Testing Data Decoding from the Internet

Since `DeliciousMeal` retrieves data from the internet, one of the most crucial methods to test is the `decode` function, which processes the incoming data. I created a unit test method named `testDataFromTheInternet` to validate this behavior. Specifically, this test ensures that the app successfully fetches and decodes 10 menu images from the internet.

Here’s how it works:
- Before the test, I define a variable:
```swift
var menu: [Menu] = []
```
- I then assign the result of the `decode` method to this `menu` variable;
- To confirm that the decoding works correctly and all 10 items are fetched, I use the `XCTAssertTrue` function from the `XCTest` framework with the following condition:
```swift
XCTAssertTrue(menu.count == 10)
```  
This full code of the test ensures the integrity of the decoding process and verifies that our app retrieves the expected number of menu items.

```swift
  func testDataFromTheInternet() throws {
        // made preparations for test
        var menu: [Menu] = []
        
        menu = try Bundle.main.decode(fileName: "Menu.json")
        
        // here we simply assert that we`ve gotten the full list of images
        XCTAssertTrue(menu.count == 10)
    }
```

### Step 3: Running the Unit Test

To execute your test method, simply click on the diamond-shaped icon (rhombus) located next to the function name in the editor. This will run the specific test case individually. As shown in `Pic #2`, the test passed successfully, indicated by the green ✅ symbol. This visual confirmation means the `decode` method is functioning as expected for the scenario being tested.
Additionally, on the right side of the test result, you’ll notice a number — in this case, 1. This number represents the number of times the test method has been executed during the current session. It can be helpful for tracking execution counts, especially when diagnosing test flakiness or reruns.

#### Pic #2
<div align="center">
<img width="1289" alt="Screenshot 2025-04-23 at 10 41 16 PM" src="https://github.com/user-attachments/assets/2110cbc3-e510-4a48-8e28-c89b1fb8ba11" />
</div>

### Step 4: Analyzing Test Results and Performance Metrics

Once your test has passed, you can explore detailed statistics and performance insights. As illustrated in `Pic #3`, click on the `Show Report Navigator` button in Xcode (located in the left sidebar, typically represented by a speech bubble icon).

This opens the Report Navigator, where you can:
- Review test execution logs;
- Analyze the performance of individual code blocks;
- Monitor execution time for each step;
- Check test coverage to see which parts of your code were actually exercised during testing.
This deeper level of analysis is particularly useful for identifying bottlenecks, optimizing performance, and ensuring that your tests are effectively covering the most important parts of your codebase.

#### Pic #3
<div align="center">
<img width="1667" alt="Screenshot 2025-04-23 at 11 04 12 PM" src="https://github.com/user-attachments/assets/904b1d10-a5a2-423f-9b4e-7444f9c1e31c" />
</div>

Now, let’s take a closer look at how the `decode` function is covered during testing.

To do this:

1. Open the file `Bundle-decodable.swift` in Xcode;
2. With code coverage enabled, you’ll see visual indicators directly in the gutter of your code (refer to `Pic #4`).
Here’s what the colors mean:

- `Green` lines indicate code that was executed during testing. In our case, the green lines show that the decode function was called twice, and the execution successfully passed through the guard block, meaning a valid URL was found and no error occurred.
- `Red` lines represent code that was not executed. This usually highlights alternate branches such as error handling or edge cases that didn't occur during the test run.

In this context, seeing the red lines in the error-handling path is actually a positive sign — it means our test scenario didn’t trigger any failures, which aligns with expected behavior.

#### Pic #4
<div align="center">
<img width="1235" alt="Screenshot 2025-04-23 at 11 21 19 PM" src="https://github.com/user-attachments/assets/87a12773-ef82-4a76-abe4-cf9b37e8f423" />
</div>

### Step 6: Testing Asynchronous Order Placement

In addition to testing decoding logic, our unit tests also cover a critical asynchronous method—one that handles the final step of placing an order with the food server. This logic is validated in the method `testOrderAcceptance`, located in the same `UnitTests` file.
Let’s break down how this works step by step.

#### Preparing for the Test

Before diving into the actual test, we need to handle setup and teardown:
- Xcode provides two lifecycle methods:
  - `setUpWithError()` — called before each test method runs.
  - `tearDownWithError()` — called after each test method completes.
In `setUpWithError()`, I instantiate the `CheckoutViewController` and assign it to a property `checkoutVC`, which I declare at the class level inside `final class UnitTests: XCTestCase`.

We initialize it before every test run because we need to access the `placeOrder()` method, which is asynchronous.

#### Writing the Async Test

Since `placeOrder()` is an async function, the test method `testOrderAcceptance()` is also marked as async.

Here’s what happens inside the test:
- I populate the required fields address, city, and phone on checkoutVC. This ensures the guard conditions inside `placeOrder()` pass successfully;
- I then call - `let myOrder = await checkoutVC.placeOrder()` and validate that the result is not `nil` - `XCTAssertNotNil(myOrder)`;
- Finally, to confirm data integrity, I verify that the order returned contains the expected dish name - `XCTAssertEqual(myOrder.orderName, checkoutVC.nameOfDish)`.
This ensures not only that the order is successfully placed but also that the returned data matches what we expect from the input—offering both functional and data-level validation.

```swift

 var checkoutVC: CheckoutViewController!
    
    override func setUpWithError() throws {
        checkoutVC = CheckoutViewController()
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
```

## UI tests.

Now, lets change the gear to UI tests. UI test helps us to check user interactions with our application.

### Step 1: Setting Up UI Tests

As with the Unit tests project `DeliciousMeal` had UI target added. But again there are actions you would know how to add it:
- Open `DeliciousMeal` project in Xcode and choose File -> New -> Target;
- In search field type `UI` and choose `UI Testing Bundle` click next;
- In Product name give the `name` for the test targer as you see on `Pic 5` screenshots. I put the name `UITests`;
- In created folder `UITests` to choose UITests file.
Now we are ready for UI testing🫡.

#### Pic #5
<div align="center">
<img width="737" alt="Screenshot 2025-04-25 at 1 21 34 AM" src="https://github.com/user-attachments/assets/45f1c324-a9c4-4f00-9fe0-ead76e38d2af" />

<img width="730" alt="Screenshot 2025-04-25 at 1 27 04 AM" src="https://github.com/user-attachments/assets/9f6c5988-b071-434b-8959-8790ab67eaea" />

</div>

### Step 2: Testing UITest

Now locate the file [UITests](https://github.com/Chipset090191/Unit-UI-XCTest-and-others/blob/main/DeliciousMeal%20with%20tests/UITests/UITests.swift). We are gonna test function `testMainOrderingWithOptions()`.
In this test the system picks up order going through extra options and accept it. 

I attached code here down below with redundant comments. Check this out run and enjoy system`s test actions.

#### Pic #6
<div align="center">
<img width="630" alt="Screenshot 2025-04-26 at 2 20 14 PM" src="https://github.com/user-attachments/assets/9191a8b8-f1a2-46fa-964e-ca44490469f1" />
</div>

```swift
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
        app.buttons["add to shopping cart"].tap()
        
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
```

#### Some explanations on "func testMainOrderingWithOptions()"

In this line of code I use `addOrder` accessibilityIdentifier. 
```swift
let button = app.navigationBars.buttons["addOrder"]
```

I do so because I assigned this name in ViewController. In UI testing it is easy to create identifiers so then you simply apply to them.

```swift
// viewDidLoad() in ViewController
 addButton.accessibilityIdentifier = "addOrder"
```

So the list identifiers I used in my code:
- "mainStepper";
- "firstOptionStepper";
- "SecondOptionStepper";
- "addressField";
- "cityField";
- "phoneField".

Also, if you do not know how to apply to an element of your UI you can leverage it by using `record button` while you are on tests.
To do so:
- Choose the method you want to test, for example `testMainOrderingWithOptions()`;
- Set the pointer of mouse to the line where you want to start;
- Tap the `record` as showen down below on Pic #7;
- Now when you do actions the system will write down code automatically.
 
#### Pic #7
<img width="345" alt="Screenshot 2025-04-26 at 2 46 21 PM" src="https://github.com/user-attachments/assets/edb57a1c-ee36-4f51-8856-438db39ff86b" />


We have done ✅. I wrote the concept of how to test your code whether you on Unit or UI. Hope it is clear).






