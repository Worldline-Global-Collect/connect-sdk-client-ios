//
//  WCValidatorRangeTestCase.m
//  WorldlineConnectSDK
//
//  Created for Worldline Global Collect on 15/12/2016.
//  Copyright © 2017 Worldline Global Collect. All rights reserved.
//

#import <XCTest/XCTest.h>
#import  "WCValidatorRange.h"

@interface WCValidatorRangeTestCase : XCTestCase

@property (strong, nonatomic) WCValidatorRange *validator;

@end

@implementation WCValidatorRangeTestCase

- (void)setUp
{
    [super setUp];
    self.validator = [[WCValidatorRange alloc] init];
    self.validator.maxValue = 50;
    self.validator.minValue = 40;
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testValidateCorrect1
{
    [self.validator validate:@"40" forPaymentRequest:nil];
    XCTAssertTrue(self.validator.errors.count == 0, @"Valid value considered invalid");
}

- (void)testValidateCorrect2
{
    [self.validator validate:@"45" forPaymentRequest:nil];
    XCTAssertTrue(self.validator.errors.count == 0, @"Valid value considered invalid");
}
- (void)testValidateCorrect3
{
    [self.validator validate:@"50" forPaymentRequest:nil];
    XCTAssertTrue(self.validator.errors.count == 0, @"Valid value considered invalid");
}

- (void)testValidateIncorrect1
{
    [self.validator validate:@"aaa" forPaymentRequest:nil];
    XCTAssertTrue(self.validator.errors.count != 0, @"Invalid value considered valid");
}

- (void)testValidateIncorrect2
{
    [self.validator validate:@"39" forPaymentRequest:nil];
    XCTAssertTrue(self.validator.errors.count != 0, @"Invalid value considered valid");
}

- (void)testValidateIncorrect3
{
    [self.validator validate:@"51" forPaymentRequest:nil];
    XCTAssertTrue(self.validator.errors.count != 0, @"Invalid value considered valid");
}

@end
