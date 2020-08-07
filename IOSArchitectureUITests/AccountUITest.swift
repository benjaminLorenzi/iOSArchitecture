//
//  AccountUITest.swift
//  IOSArchitectureUITests
//
//  Created by Benjamin LORENZI on 08/03/2020.
//  Copyright © 2020 Benjamin LORENZI. All rights reserved.
//

import XCTest

class AccountUITest: XCTestCase {

    var app: XCUIApplication = XCUIApplication()
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app.launchArguments = ["testMode", "viewModel"]
    }
    
    func testAccountFaceId() {
        let json = """
        {
                    "view_controller_type": "account",
                    "view_model_type": "accountViewModel",
                    "payload": {
                        "supportedBiometry": "faceId",
                        "biometryEnabled": true,
                        "username": "Stan"
                    }
        }
        """
        app.launchEnvironment["viewModelInjector"] = json
        app.launch()
        XCTAssert(app.staticTexts["usernameLabel"].label == "Welcome Stan")
        //XCTAssertEqual(app.staticTexts["biometryLabel"].label, localizedString("face_id"))
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

}
