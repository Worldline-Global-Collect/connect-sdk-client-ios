//
//  WCValidatorResidentIdNumberTestCase.m
//  WorldlineConnectExample
//
//  Created for Worldline Global Collect on 8/10/2020.
//  Copyright © 2020 Worldline Global Collect. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <XCTest/XCTest.h>
#import "WCValidatorResidentIdNumber.h"

@interface WCValidatorResidentIdNumberTestCase : XCTestCase

@property (strong, nonatomic) WCValidatorResidentIdNumber *validator;

@end

@implementation WCValidatorResidentIdNumberTestCase

- (void)setUp
{
    [super setUp];
    self.validator = [[WCValidatorResidentIdNumber alloc] init];
}

// MARK: - Valid ID Tests

- (void)testValidate15CharacterId
{
    [self.validator validate:@"123456789101112" forPaymentRequest:nil];
    XCTAssertTrue(self.validator.errors.count == 0, @"Valid address is considered invalid");
}

- (void)testValidate18CharacterId
{
    [self.validator validate:@"110101202009235416" forPaymentRequest:nil];
    XCTAssertTrue(self.validator.errors.count == 0, @"Valid address is considered invalid");
}

- (void)testValidateEndingInX
{
    [self.validator validate:@"11010120200922993X" forPaymentRequest:nil];
    XCTAssertTrue(self.validator.errors.count == 0, @"Valid address is considered invalid");
}

// MARK: - Invalid ID Tests

- (void)test16CharacterId
{
    [self.validator validate:@"1234567890123451" forPaymentRequest: nil];
    XCTAssertTrue(self.validator.errors.count > 0, @"Invalid address is considered invalid");
}

- (void)test17CharacterId
{
    [self.validator validate:@"1234567890123451X" forPaymentRequest:nil];
    XCTAssertTrue(self.validator.errors.count > 0, @"Invalid address is considered invalid");
}

- (void)testValidateTooShortId
{
    [self.validator validate:@"1" forPaymentRequest:nil];
    XCTAssertTrue(self.validator.errors.count > 0, @"Invalid address is considered invalid");
}

- (void)testValidateTooLongId
{
    [self.validator validate:@"110101202009224733110101202009224733" forPaymentRequest:nil];
    XCTAssertTrue(self.validator.errors.count > 0, @"Invalid address is considered invalid");
}

- (void)testValidateInvalidChecksum
{
    [self.validator validate:@"110101202009224734" forPaymentRequest:nil];
    XCTAssertTrue(self.validator.errors.count > 0, @"Invalid address is considered invalid");
}

@end
