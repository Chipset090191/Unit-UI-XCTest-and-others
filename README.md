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
To run test you should click on rhombus next to your func name. So as you can see we`ve passed our test) succesfully.
<div align="center">
<img width="867" alt="Screenshot 2025-04-23 at 7 11 55 PM" src="https://github.com/user-attachments/assets/26c2cd18-9c27-4c26-a45f-d5f6eeae0975" />
</div>

