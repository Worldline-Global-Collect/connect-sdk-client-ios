//
//  WCValidatorRegularExpressionTestCase.m
//  WorldlineConnectSDK
//
//  Created for Worldline Global Collect on 15/12/2016.
//  Copyright © 2017 Worldline Global Collect. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "WCValidatorRegularExpression.h"

@interface WCValidatorRegularExpressionTestCase : XCTestCase

@property (strong, nonatomic) WCValidatorRegularExpression *validator;

@end

@implementation WCValidatorRegularExpressionTestCase

- (void)setUp
{
    [super setUp];
    NSRegularExpression *regularExpression = [NSRegularExpression regularExpressionWithPattern:@"\\d{3}" options:0 error:NULL];
    self.validator = [[WCValidatorRegularExpression alloc] initWithRegularExpression:regularExpression];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testValidateCorrect
{
    [self.validator validate:@"123" forPaymentRequest:nil];
    XCTAssertTrue(self.validator.errors.count == 0, @"Valid value considered invalid");
}

- (void)testValidateIncorrect
{
    [self.validator validate:@"abc" forPaymentRequest:nil];
    XCTAssertTrue(self.validator.errors.count != 0, @"Invalid value considered valid");
}

@end
