//
//  WCValidatorExpirationDateTestCase.m
//  WorldlineConnectSDK
//
//  Created for Worldline Global Collect on 15/12/2016.
//  Copyright © 2017 Worldline Global Collect. All rights reserved.
//

#import <XCTest/XCTest.h>
#import  "WCValidatorExpirationDate.h"

@interface WCValidatorExpirationDateTestCase : XCTestCase

@property (strong, nonatomic) WCValidatorExpirationDate *validator;
@property (strong, nonatomic) NSCalendar *gregorianCalendar;
@property (strong, nonatomic) NSDate *now;
@property (strong, nonatomic) NSDate *futureDate;

@end

@interface WCValidatorExpirationDate (Testing)

- (BOOL)validateDateIsBetween:(NSDate *)now andFutureDate:(NSDate *)futureDate withDateToValidate:(NSDate *)dateToValidate;

@end

@implementation WCValidatorExpirationDateTestCase

- (void)setUp
{
    [super setUp];
    self.validator = [WCValidatorExpirationDate new];

    // Create Gregorian calendar
    self.gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    // Set current date to 08-05-2025
    NSDateComponents *nowComponents = [[NSDateComponents alloc] init];
    nowComponents.year = 2025;
    nowComponents.month = 5;
    nowComponents.day = 8;
    self.now = [self.gregorianCalendar dateFromComponents:nowComponents];

    // Set future date to 08-05-2050 (25 years from 'current' date)
    NSDateComponents *futureDateComponents = [[NSDateComponents alloc] init];
    futureDateComponents.year = 2050;
    futureDateComponents.month = 5;
    futureDateComponents.day = 8;
    self.futureDate = [self.gregorianCalendar dateFromComponents:futureDateComponents];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testValid
{
    [self.validator validate:@"1244" forPaymentRequest:nil];
    XCTAssertTrue(self.validator.errors.count == 0, @"Valid expiration date considered invalid");
}

- (void)testInvalidNil
{
    [self.validator validate:nil forPaymentRequest:nil];
    XCTAssertTrue(self.validator.errors.count != 0, @"Invalid expiration date considered invalid");
}

- (void)testInvalidEmptyString
{
    [self.validator validate:@"" forPaymentRequest:nil];
    XCTAssertTrue(self.validator.errors.count != 0, @"Invalid expiration date considered invalid");
}

- (void)testInvalidLength
{
    [self.validator validate:@"13" forPaymentRequest:nil];
    XCTAssertTrue(self.validator.errors.count != 0, @"Invalid expiration date considered invalid");
}

- (void)testInvalidNonNumerical
{
    [self.validator validate:@"aaaa" forPaymentRequest:nil];
    XCTAssertTrue(self.validator.errors.count != 0, @"Invalid expiration date considered valid");
}

- (void)testInvalidPartiallyNonNumerical
{
    [self.validator validate:@"12ab" forPaymentRequest:nil];
    XCTAssertTrue(self.validator.errors.count > 0, @"Invalid expiration date considered valid");
}

- (void)testInvalidMonth
{
    [self.validator validate:@"1350" forPaymentRequest:nil];
    XCTAssertTrue(self.validator.errors.count != 0, @"Invalid expiration date considered valid");
}

- (void)testInvalidYearTooEarly
{
    [self.validator validate:@"0112" forPaymentRequest:nil];
    XCTAssertTrue(self.validator.errors.count != 0, @"Invalid expiration date considered valid");
}

- (void)testInvalidYearTooLate
{
    [self.validator validate:@"1299" forPaymentRequest:nil];
    XCTAssertTrue(self.validator.errors.count != 0, @"Invalid expiration date considered valid");
}

- (void)testInvalidInputTooLong
{
    [self.validator validate:@"122044" forPaymentRequest:nil];
    XCTAssertTrue(self.validator.errors.count != 0, @"Invalid expiration date considered valid");
}

- (void)testInvalidWhitespace
{
    [self.validator validate:@"12 30" forPaymentRequest:nil];
    XCTAssertTrue(self.validator.errors.count != 0, @"Invalid expiration date considered valid");
}

- (void)testInvalidSpecialCharacters
{
    [self.validator validate:@"12-30" forPaymentRequest:nil];
    XCTAssertTrue(self.validator.errors.count != 0, @"Invalid expiration date considered valid");
}

- (void)testValidLowerSameMonthAndYear
{
    NSDateComponents *nowComponents = [[NSDateComponents alloc] init];
    nowComponents.year = 2025;
    nowComponents.month = 5;
    NSDate *testDate = [self.gregorianCalendar dateFromComponents:nowComponents];

    BOOL validationResult = [self.validator validateDateIsBetween:self.now andFutureDate:self.futureDate withDateToValidate:testDate];
    XCTAssertTrue(validationResult, @"Valid expiration date considered invalid");
}

- (void)testValidLowerNextMonth
{
    NSDateComponents *nowComponents = [[NSDateComponents alloc] init];
    nowComponents.year = 2025;
    nowComponents.month = 6;
    NSDate *testDate = [self.gregorianCalendar dateFromComponents:nowComponents];

    BOOL validationResult = [self.validator validateDateIsBetween:self.now andFutureDate:self.futureDate withDateToValidate:testDate];
    XCTAssertTrue(validationResult, @"Valid expiration date considered invalid");
}

- (void)testInValidLowerMonth
{
    NSDateComponents *nowComponents = [[NSDateComponents alloc] init];
    nowComponents.year = 2018;
    nowComponents.month = 8;
    NSDate *testDate = [[NSCalendar currentCalendar] dateFromComponents:nowComponents];

    BOOL validationResult = [self.validator validateDateIsBetween:self.now andFutureDate:self.futureDate withDateToValidate:testDate];
    XCTAssertFalse(validationResult, @"Invalid expiration date considered valid");
}

- (void)testInValidLowerYear
{
    NSDateComponents *nowComponents = [[NSDateComponents alloc] init];
    nowComponents.year = 2017;
    nowComponents.month = 9;
    NSDate *testDate = [[NSCalendar currentCalendar] dateFromComponents:nowComponents];

    BOOL validationResult = [self.validator validateDateIsBetween:self.now andFutureDate:self.futureDate withDateToValidate:testDate];
    XCTAssertFalse(validationResult, @"Invalid expiration date considered valid");
}

- (void)testValidUpperSameMonthAndYear
{
    NSDateComponents *nowComponents = [[NSDateComponents alloc] init];
    nowComponents.year = 2050;
    nowComponents.month = 4;
    NSDate *testDate = [self.gregorianCalendar dateFromComponents:nowComponents];

    BOOL validationResult = [self.validator validateDateIsBetween:self.now andFutureDate:self.futureDate withDateToValidate:testDate];
    XCTAssertTrue(validationResult, @"Valid expiration date considered invalid");
}

- (void)testValidUpperHigherMonthSameYear
{
    NSDateComponents *nowComponents = [[NSDateComponents alloc] init];
    nowComponents.year = 2050;
    nowComponents.month = 3;
    NSDate *testDate = [self.gregorianCalendar dateFromComponents:nowComponents];

    BOOL validationResult = [self.validator validateDateIsBetween:self.now andFutureDate:self.futureDate withDateToValidate:testDate];
    XCTAssertTrue(validationResult, @"Valid expiration date considered invalid");
}

- (void)testInValidUpperHigherYear
{
    NSDateComponents *nowComponents = [[NSDateComponents alloc] init];
    nowComponents.year = 2051;
    nowComponents.month = 1;
    NSDate *testDate = [[NSCalendar currentCalendar] dateFromComponents:nowComponents];

    BOOL validationResult = [self.validator validateDateIsBetween:self.now andFutureDate:self.futureDate withDateToValidate:testDate];
    XCTAssertFalse(validationResult, @"Invalid expiration date considered valid");
}

- (void)testInValidUpperMuchHigherYear
{
    NSDateComponents *testDateComponents = [[NSDateComponents alloc] init];
    testDateComponents.year = 2099;
    testDateComponents.month = 1;
    NSDate *testDate = [[NSCalendar currentCalendar] dateFromComponents:testDateComponents];

    BOOL validationResult = [self.validator validateDateIsBetween:self.now andFutureDate:self.futureDate withDateToValidate:testDate];
    XCTAssertFalse(validationResult, @"Invalid expiration date considered valid");
}

/*
 To test calendars other than Gregorian, you will need to change the region / calendar of the simulator on which you run the unit tests.
 */
- (void)testValidationAlternativeCalendars
{
    // Valid expiration date
    [self.validator validate:@"1226" forPaymentRequest:nil];
    XCTAssertTrue(self.validator.errors.count == 0, @"Valid expiration date should pass validation with alternative calendar");
    
    // Invalid expiration date - past
    [self.validator validate:@"0324" forPaymentRequest:nil];
    XCTAssertTrue(self.validator.errors.count > 0, @"Expired date should fail validation with alternative calendar");
    
    // Invalid expiration date - future
    [self.validator validate:@"1290" forPaymentRequest:nil];
    XCTAssertTrue(self.validator.errors.count > 0, @"Date beyond limit should fail validation with alternative calendar");
}

@end
