//
//  Quick_Map_UITests.swift
//  Quick Map UITests
//
//  Created by Chatsopon Deepateep on 17/6/2565 BE.
//

import XCTest

class Quick_Map_UITests: XCTestCase {
    let app = XCUIApplication()

    override func setUpWithError() throws {
      continueAfterFailure = false
      app.launch()
    }

    func testSearchCity() {
        let bangkokThStaticText = app.staticTexts["Bangkok, TH"]
        bangkokThStaticText.tap()
        
        let searchTextField = app.textFields["Search…"]
        searchTextField.tap()
        searchTextField.typeText("Alabama")
    
        let alabamaCell = app.scrollViews.otherElements.staticTexts["Alabama, US"]
        expectation(for: NSPredicate(format: "exists == 1"), evaluatedWith: alabamaCell)
        waitForExpectations(timeout: 2)
    }
}
