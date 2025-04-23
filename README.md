# Unit-UI-XCTest-and-others

### Project `DeliciousMeal` and Unit\UI Tests by using XCTest framework.
Here I am gonna just share with you some basic techniques for testing your apps. I have covered not all my `DeliciousMeal` application with tests rather sensitive main parts of my app. 

1. Unit tests.

lets just start with unit tests. And on this step I am sure you know how to add a target with Unit XCTest framework to your app😁.
Ok open project `DeliciousMeal` and there file - [UnitTests](https://github.com/Chipset090191/Unit-UI-XCTest-and-others/blob/main/DeliciousMeal%20with%20tests/UnitTests/UnitTests.swift).

So as my app getting the data from the internet the method `decode` is supposed to be tested. I wrote down test in `testDataFromTheInternet` method to be certain my 10 menu images are gotten from net. And here to be sure that everything is ok we use comand from XCTest framework with our condition: `XCTAssertTrue(menu.count == 10)`. 
```swift
  func testDataFromTheInternet() throws {
        var menu: [Menu] = []
        
        menu = try Bundle.main.decode(fileName: "Menu.json")
        
        // here we simply assert that we`ve got the full list of images
        XCTAssertTrue(menu.count == 10)
    }
```



