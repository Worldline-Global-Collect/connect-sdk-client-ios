//
//  WCPaymentProductFieldTestCase.m
//  WorldlineConnectSDK
//
//  Created for Worldline Global Collect on 15/12/2016.
//  Copyright © 2017 Worldline Global Collect. All rights reserved.
//

#import <XCTest/XCTest.h>
#import  "WCPaymentProductField.h"
#import  "WCValidatorLength.h"
#import  "WCValidatorRange.h"
#import  "WCPaymentRequest.h"

@interface WCPaymentProductFieldTestCase : XCTestCase

@property (strong, nonatomic) WCPaymentProductField *field;
@property (strong, nonatomic) WCPaymentRequest *paymentRequest;

@end

@implementation WCPaymentProductFieldTestCase

- (void)setUp
{
    [super setUp];
    self.field = [[WCPaymentProductField alloc] init];
    WCValidatorLength *length = [[WCValidatorLength alloc] init];
    length.minLength = 4;
    length.maxLength = 6;
    WCValidatorRange *range = [[WCValidatorRange alloc] init];
    range.minValue = 50;
    range.maxValue = 60;
    [self.field.dataRestrictions.validators.validators addObject:length];
    [self.field.dataRestrictions.validators.validators addObject:range];
    self.paymentRequest = [[WCPaymentRequest alloc] init];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testValidateValueCorrect
{
    [self.field validateValue:@"0055" forPaymentRequest:_paymentRequest];
    XCTAssertTrue(self.field.errors.count == 0, @"Unexpected errors after validation");
}

- (void)testValidateValueIncorrect
{
    [self.field validateValue:@"0" forPaymentRequest:_paymentRequest];
    XCTAssertTrue(self.field.errors.count == 2, @"Unexpected number of errors after validation");
}

@end
