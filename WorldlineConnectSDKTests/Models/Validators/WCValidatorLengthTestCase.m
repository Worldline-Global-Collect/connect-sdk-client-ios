//
//  WCValidatorLengthTestCase.m
//  WorldlineConnectSDK
//
//  Created for Worldline Global Collect on 15/12/2016.
//  Copyright © 2017 Worldline Global Collect. All rights reserved.
//

#import <XCTest/XCTest.h>
#import  "WCValidatorLength.h"
#import  "WCPaymentRequest.h"

@interface WCValidatorLengthTestCase : XCTestCase

@property (strong, nonatomic) WCValidatorLength *validator;
@property (strong, nonatomic) WCPaymentRequest *paymentRequest;

@end

@implementation WCValidatorLengthTestCase

- (void)setUp
{
    [super setUp];
    self.validator = [[WCValidatorLength alloc] init];
    self.validator.maxLength = 3;
    self.validator.minLength = 1;
    self.paymentRequest = [[WCPaymentRequest alloc] init];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testValidateCorrect1
{
    [self.validator validate:@"1" forPaymentRequest:nil];
    XCTAssertTrue(self.validator.errors.count == 0, @"Valid value considered invalid");
}

- (void)testValidateCorrect2
{
    [self.validator validate:@"12" forPaymentRequest:nil];
    XCTAssertTrue(self.validator.errors.count == 0, @"Valid value considered invalid");
}

- (void)testValidateCorrect3
{
    [self.validator validate:@"123" forPaymentRequest:self.paymentRequest];
    XCTAssertTrue(self.validator.errors.count == 0, @"Valid value considered invalid");
}

- (void)testValidateIncorrect1
{
    [self.validator validate:@"" forPaymentRequest:self.paymentRequest];
    XCTAssertTrue(self.validator.errors.count != 0, @"Invalid value considered valid");
}

- (void)testValidateIncorrect2
{
    [self.validator validate:@"1234" forPaymentRequest:self.paymentRequest];
    XCTAssertTrue(self.validator.errors.count != 0, @"Invalid value considered valid");
}

@end
