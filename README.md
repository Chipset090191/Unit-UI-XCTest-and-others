# Unit-UI-XCTest-and-others

### Project `DeliciousMeal` and Unit\UI Tests by using XCTest framework.
Here I am gonna just share with you some basic techniques for testing your apps. I have covered not all my `DeliciousMeal` application with tests rather sensitive main parts of my app. 

1. Unit tests.

lets just start with unit tests. And on this step I am sure you know how to add a target with Unit XCTest framework to your app😁.
Ok open project `DeliciousMeal` and there file - [UnitTests](https://github.com/Chipset090191/Unit-UI-XCTest-and-others/blob/main/DeliciousMeal%20with%20tests/UnitTests/UnitTests.swift).

So as my app getting the data from the internet the method `decode` is supposed to be tested. I wrote down test in `testDataFromTheInternet` method to be certain my 10 menu images are gotten from net. And here to be sure that everything is ok we use comand from XCTest framework with our condition: `XCTAssertTrue(menu.count == 10)`. Notice that I created `var menu: [Menu] = []` right before test to assing the result of decode func so as in real code.
### Pic #1
```swift
  func testDataFromTheInternet() throws {
        // made preparations for test
        var menu: [Menu] = []
        
        menu = try Bundle.main.decode(fileName: "Menu.json")
        
        // here we simply assert that we`ve gotten the full list of images
        XCTAssertTrue(menu.count == 10)
    }
```
To run test you should click on rhombus next to your func name. So as you can see on `Pic #2` we`ve passed our test) succesfully with indicator ✅. Also from right side there is a number - 1 that indicates number of calls for this method.
### Pic #2
<div align="center">
<img width="1289" alt="Screenshot 2025-04-23 at 10 41 16 PM" src="https://github.com/user-attachments/assets/2110cbc3-e510-4a48-8e28-c89b1fb8ba11" />
</div>

When our test has passed we can dive deeply in statistics as you may look on `Pic #3`. Just click `Show report navigator icon-button` to open it. In this tree you are able to analize the speed of block executions and test coverage. 
### Pic #3
<div align="center">
<img width="1667" alt="Screenshot 2025-04-23 at 11 04 12 PM" src="https://github.com/user-attachments/assets/904b1d10-a5a2-423f-9b4e-7444f9c1e31c" />
</div>

Lets just check out how our decode function is covered inside. To do that click on file `Bundle-decodable.swift`.  So on `Pic #4` with green color we know that our func was called two times where guard block found `url` and no error wasn`t there, means lines with red color were not run. That is good.
### Pic #4
<div align="center">
<img width="1235" alt="Screenshot 2025-04-23 at 11 21 19 PM" src="https://github.com/user-attachments/assets/87a12773-ef82-4a76-abe4-cf9b37e8f423" />
</div>

Ok, I show you ability how to observe statistics when you are on testing. Now you know it.

In Unit tests we have got one more sensitive method which is responsible for order confirmation we have chosen `testorderAcceptance`. 
Lets look at this closer.

The main thing here
```swift
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




