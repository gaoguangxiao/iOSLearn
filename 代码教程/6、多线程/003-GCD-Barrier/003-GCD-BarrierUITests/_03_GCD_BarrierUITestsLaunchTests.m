//
//  _03_GCD_BarrierUITestsLaunchTests.m
//  003-GCD-BarrierUITests
//
//  Created by 高广校 on 2023/8/10.
//

#import <XCTest/XCTest.h>

@interface _03_GCD_BarrierUITestsLaunchTests : XCTestCase

@end

@implementation _03_GCD_BarrierUITestsLaunchTests

+ (BOOL)runsForEachTargetApplicationUIConfiguration {
    return YES;
}

- (void)setUp {
    self.continueAfterFailure = NO;
}

- (void)testLaunch {
    XCUIApplication *app = [[XCUIApplication alloc] init];
    [app launch];

    // Insert steps here to perform after app launch but before taking a screenshot,
    // such as logging into a test account or navigating somewhere in the app

    XCTAttachment *attachment = [XCTAttachment attachmentWithScreenshot:XCUIScreen.mainScreen.screenshot];
    attachment.name = @"Launch Screen";
    attachment.lifetime = XCTAttachmentLifetimeKeepAlways;
    [self addAttachment:attachment];
}

@end
