//
//  SwiftUI_DataSendTool_ObUITestsLaunchTests.swift
//  SwiftUI_DataSendTool_ObUITests
//
//  Created by gaoguangxiao on 2022/9/13.
//

import XCTest

class SwiftUI_DataSendTool_ObUITestsLaunchTests: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()

        // Insert steps here to perform after app launch but before taking a screenshot,
        // such as logging into a test account or navigating somewhere in the app

        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}
