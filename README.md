# Unit-UI-XCTest-and-others

### Project `DeliciousMeal` and Unit\UI Tests by using XCTest framework.
Here I am gonna just share with you some basic techniques for testing your apps. I have covered not all my `DeliciousMeal` application with tests rather sensitive main parts of my app. 

1. Unit tests.

let`s just start with unit tests. And on this step I am sure you know how to add a target with Unit XCTest framework to your app😁.

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


