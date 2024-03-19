//
//  WCValidatorLuhnTestCase.m
//  WorldlineConnectSDK
//
//  Created for Worldline Global Collect on 15/12/2016.
//  Copyright © 2017 Worldline Global Collect. All rights reserved.
//

#import <XCTest/XCTest.h>
#import  "WCValidatorLuhn.h"

@interface WCValidatorLuhnTestCase : XCTestCase

@property (strong, nonatomic) WCValidatorLuhn *validator;

@end

@implementation WCValidatorLuhnTestCase

- (void)setUp
{
    [super setUp];
    self.validator = [[WCValidatorLuhn alloc] init];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testValidateCorrect
{
    [self.validator validate:@"4242424242424242" forPaymentRequest:nil];
    XCTAssertTrue(self.validator.errors.count == 0, @"Valid value considered invalid");
}

- (void)testValidateIncorrect
{
    [self.validator validate:@"1111" forPaymentRequest:nil];
    XCTAssertTrue(self.validator.errors.count != 0, @"Invalid value considered valid");
}


@end
