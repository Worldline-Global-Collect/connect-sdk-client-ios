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
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    // Set current date to 2025-04-08
    NSDateComponents *nowComponents = [[NSDateComponents alloc] init];
    nowComponents.year = 2025;
    nowComponents.month = 4;
    nowComponents.day = 8;
    nowComponents.hour = 0;
    nowComponents.minute = 0;
    nowComponents.second = 0;
    self.now = [gregorianCalendar dateFromComponents:nowComponents];

    // Set future date to 2050-04-08 (25 years from now)
    NSDateComponents *futureDateComponents = [[NSDateComponents alloc] init];
    futureDateComponents.year = 2050;
    futureDateComponents.month = 4;
    futureDateComponents.day = 8;
    futureDateComponents.hour = 0;
    futureDateComponents.minute = 0;
    futureDateComponents.second = 0;
    self.futureDate = [gregorianCalendar dateFromComponents:futureDateComponents];
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

- (void)testInvalidNonNumerical
{
    [self.validator validate:@"aaaa" forPaymentRequest:nil];
    XCTAssertTrue(self.validator.errors.count != 0, @"Invalid expiration date considered valid");
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

- (void)testValidLowerSameMonthAndYear
{
    // Create Gregorian calendar
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDateComponents *nowComponents = [[NSDateComponents alloc] init];
    nowComponents.year = 2025;
    nowComponents.month = 4;
    NSDate *testDate = [gregorianCalendar dateFromComponents:nowComponents];

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
    // Create Gregorian calendar
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDateComponents *nowComponents = [[NSDateComponents alloc] init];
    nowComponents.year = 2050;
    nowComponents.month = 4;
    NSDate *testDate = [gregorianCalendar dateFromComponents:nowComponents];

    BOOL validationResult = [self.validator validateDateIsBetween:self.now andFutureDate:self.futureDate withDateToValidate:testDate];
    XCTAssertTrue(validationResult, @"Valid expiration date considered invalid");
}

- (void)testValidUpperHigherMonthSameYear
{
    // Create Gregorian calendar
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDateComponents *nowComponents = [[NSDateComponents alloc] init];
    nowComponents.year = 2050;
    nowComponents.month = 3;
    NSDate *testDate = [gregorianCalendar dateFromComponents:nowComponents];

    BOOL validationResult = [self.validator validateDateIsBetween:self.now andFutureDate:self.futureDate withDateToValidate:testDate];
    XCTAssertTrue(validationResult, @"Valid expiration date considered invalid");
}

- (void)testInValidUpperHigherYear
{
    NSDateComponents *nowComponents = [[NSDateComponents alloc] init];
    nowComponents.year = 2034;
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

- (void)testValidateWithBuddhistCalendar
{
    // Create Buddhist calendar
    NSCalendar *buddhistCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierBuddhist];
    NSLocale *thaiLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"th_TH"];
    
    // Store original locale
    NSLocale *originalLocale = [NSLocale currentLocale];
    
    // Set system locale to Thai
    [[NSUserDefaults standardUserDefaults] setObject:@"th_TH" forKey:@"AppleLocale"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    // Create a new validator
    WCValidatorExpirationDate *buddhistValidator = [[WCValidatorExpirationDate alloc] init];
    
    // Test valid expiration date (MMYY format)
    [buddhistValidator validate:@"1226" forPaymentRequest:nil];
    XCTAssertTrue(buddhistValidator.errors.count == 0, @"Valid expiration date should pass validation with Buddhist calendar");
    
    // Test expired date
    [buddhistValidator validate:@"0324" forPaymentRequest:nil];
    XCTAssertTrue(buddhistValidator.errors.count > 0, @"Expired date should fail validation with Buddhist calendar");
    
    // Test future date beyond limit
    [buddhistValidator validate:@"1290" forPaymentRequest:nil];
    XCTAssertTrue(buddhistValidator.errors.count > 0, @"Date beyond limit should fail validation with Buddhist calendar");
    
    // Reset to original locale
    [[NSUserDefaults standardUserDefaults] setObject:originalLocale.localeIdentifier forKey:@"AppleLocale"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)testValidateWithIslamicCalendar
{
    // Create Islamic calendar
    NSCalendar *islamicCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierIslamic];
    NSLocale *arabicLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"ar_SA"];
    
    // Store original locale
    NSLocale *originalLocale = [NSLocale currentLocale];
    
    // Set system locale to Arabic
    [[NSUserDefaults standardUserDefaults] setObject:@"ar_SA" forKey:@"AppleLocale"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    // Create a new validator
    WCValidatorExpirationDate *islamicValidator = [[WCValidatorExpirationDate alloc] init];
    
    // Test valid expiration date (MMYY format)
    [islamicValidator validate:@"1226" forPaymentRequest:nil];
    XCTAssertTrue(islamicValidator.errors.count == 0, @"Valid expiration date should pass validation with Islamic calendar");
    
    // Test expired date
    [islamicValidator validate:@"0324" forPaymentRequest:nil];
    XCTAssertTrue(islamicValidator.errors.count > 0, @"Expired date should fail validation with Islamic calendar");
    
    // Test future date beyond limit
    [islamicValidator validate:@"1290" forPaymentRequest:nil];
    XCTAssertTrue(islamicValidator.errors.count > 0, @"Date beyond limit should fail validation with Islamic calendar");
    
    // Reset to original locale
    [[NSUserDefaults standardUserDefaults] setObject:originalLocale.localeIdentifier forKey:@"AppleLocale"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)testValidateWithJapaneseCalendar
{
    // Create Japanese calendar
    NSCalendar *japaneseCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierJapanese];
    NSLocale *japaneseLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"ja_JP"];
    
    // Store original locale
    NSLocale *originalLocale = [NSLocale currentLocale];
    
    // Set system locale to Japanese
    [[NSUserDefaults standardUserDefaults] setObject:@"ja_JP" forKey:@"AppleLocale"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    // Create a new validator
    WCValidatorExpirationDate *japaneseValidator = [[WCValidatorExpirationDate alloc] init];
    
    // Test valid expiration date (MMYY format)
    [japaneseValidator validate:@"1226" forPaymentRequest:nil];
    XCTAssertTrue(japaneseValidator.errors.count == 0, @"Valid expiration date should pass validation with Japanese calendar");
    
    // Test expired date
    [japaneseValidator validate:@"0324" forPaymentRequest:nil];
    XCTAssertTrue(japaneseValidator.errors.count > 0, @"Expired date should fail validation with Japanese calendar");
    
    // Test future date beyond limit
    [japaneseValidator validate:@"1290" forPaymentRequest:nil];
    XCTAssertTrue(japaneseValidator.errors.count > 0, @"Date beyond limit should fail validation with Japanese calendar");
    
    // Reset to original locale
    [[NSUserDefaults standardUserDefaults] setObject:originalLocale.localeIdentifier forKey:@"AppleLocale"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)testValidateWithHebrewCalendar
{
    // Create Hebrew calendar
    NSCalendar *hebrewCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierHebrew];
    NSLocale *hebrewLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"he_IL"];
    
    // Store original locale
    NSLocale *originalLocale = [NSLocale currentLocale];
    
    // Set system locale to Hebrew
    [[NSUserDefaults standardUserDefaults] setObject:@"he_IL" forKey:@"AppleLocale"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    // Create a new validator
    WCValidatorExpirationDate *hebrewValidator = [[WCValidatorExpirationDate alloc] init];
    
    // Test valid expiration date (MMYY format)
    [hebrewValidator validate:@"1226" forPaymentRequest:nil];
    XCTAssertTrue(hebrewValidator.errors.count == 0, @"Valid expiration date should pass validation with Hebrew calendar");
    
    // Test expired date
    [hebrewValidator validate:@"0324" forPaymentRequest:nil];
    XCTAssertTrue(hebrewValidator.errors.count > 0, @"Expired date should fail validation with Hebrew calendar");
    
    // Test future date beyond limit
    [hebrewValidator validate:@"1290" forPaymentRequest:nil];
    XCTAssertTrue(hebrewValidator.errors.count > 0, @"Date beyond limit should fail validation with Hebrew calendar");
    
    // Reset to original locale
    [[NSUserDefaults standardUserDefaults] setObject:originalLocale.localeIdentifier forKey:@"AppleLocale"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)testValidateWithPersianCalendar
{
    // Create Persian calendar
    NSCalendar *persianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierPersian];
    NSLocale *persianLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"fa_IR"];
    
    // Store original locale
    NSLocale *originalLocale = [NSLocale currentLocale];
    
    // Set system locale to Persian
    [[NSUserDefaults standardUserDefaults] setObject:@"fa_IR" forKey:@"AppleLocale"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    // Create a new validator
    WCValidatorExpirationDate *persianValidator = [[WCValidatorExpirationDate alloc] init];
    
    // Test valid expiration date (MMYY format)
    [persianValidator validate:@"1226" forPaymentRequest:nil];
    XCTAssertTrue(persianValidator.errors.count == 0, @"Valid expiration date should pass validation with Persian calendar");
    
    // Test expired date
    [persianValidator validate:@"0324" forPaymentRequest:nil];
    XCTAssertTrue(persianValidator.errors.count > 0, @"Expired date should fail validation with Persian calendar");
    
    // Test future date beyond limit
    [persianValidator validate:@"1290" forPaymentRequest:nil];
    XCTAssertTrue(persianValidator.errors.count > 0, @"Date beyond limit should fail validation with Persian calendar");
    
    // Reset to original locale
    [[NSUserDefaults standardUserDefaults] setObject:originalLocale.localeIdentifier forKey:@"AppleLocale"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)testValidateWithChineseCalendar
{
    // Create Chinese calendar
    NSCalendar *chineseCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierChinese];
    NSLocale *chineseLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    
    // Store original locale
    NSLocale *originalLocale = [NSLocale currentLocale];
    
    // Set system locale to Chinese
    [[NSUserDefaults standardUserDefaults] setObject:@"zh_CN" forKey:@"AppleLocale"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    // Create a new validator
    WCValidatorExpirationDate *chineseValidator = [[WCValidatorExpirationDate alloc] init];
    
    // Test valid expiration date (MMYY format)
    [chineseValidator validate:@"1226" forPaymentRequest:nil];
    XCTAssertTrue(chineseValidator.errors.count == 0, @"Valid expiration date should pass validation with Chinese calendar");
    
    // Test expired date
    [chineseValidator validate:@"0324" forPaymentRequest:nil];
    XCTAssertTrue(chineseValidator.errors.count > 0, @"Expired date should fail validation with Chinese calendar");
    
    // Test future date beyond limit
    [chineseValidator validate:@"1290" forPaymentRequest:nil];
    XCTAssertTrue(chineseValidator.errors.count > 0, @"Date beyond limit should fail validation with Chinese calendar");
    
    // Reset to original locale
    [[NSUserDefaults standardUserDefaults] setObject:originalLocale.localeIdentifier forKey:@"AppleLocale"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)testValidateWithVariousScenarios
{
    // 1. Test valid date (between current date and 25 years in the future)
    [self.validator validate:@"1226" forPaymentRequest:nil];
    XCTAssertTrue(self.validator.errors.count == 0, @"Valid future date should pass validation");
    
    // 2. Test invalid date format
    [self.validator validate:@"13" forPaymentRequest:nil];
    XCTAssertTrue(self.validator.errors.count > 0, @"Invalid date format should fail validation");
    
    // 3. Test invalid months
    [self.validator validate:@"0026" forPaymentRequest:nil];
    XCTAssertTrue(self.validator.errors.count > 0, @"Invalid month (00) should fail validation");
    
    [self.validator validate:@"1326" forPaymentRequest:nil];
    XCTAssertTrue(self.validator.errors.count > 0, @"Invalid month (13) should fail validation");
    
    // 4. Test expired date
    [self.validator validate:@"0324" forPaymentRequest:nil];
    XCTAssertTrue(self.validator.errors.count > 0, @"Expired date should fail validation");
    
    // 5. Test date beyond 25 years limit
    [self.validator validate:@"1250" forPaymentRequest:nil];
    XCTAssertTrue(self.validator.errors.count > 0, @"Date beyond 25 years should fail validation");
    
    // 6. Test non-numeric input
    [self.validator validate:@"12ab" forPaymentRequest:nil];
    XCTAssertTrue(self.validator.errors.count > 0, @"Non-numeric input should fail validation");
    
    // 7. Test empty input
    [self.validator validate:@"" forPaymentRequest:nil];
    XCTAssertTrue(self.validator.errors.count > 0, @"Empty input should fail validation");
    
    // 8. Test nil input
    [self.validator validate:nil forPaymentRequest:nil];
    XCTAssertTrue(self.validator.errors.count > 0, @"Nil input should fail validation");
    
    // 9. Test current month and year
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setCalendar:gregorianCalendar];
    [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"]];
    [formatter setDateFormat:@"MMyy"];
    
    // Use the now date set in setUp
    NSString *currentDate = [formatter stringFromDate:self.now];
    [self.validator validate:currentDate forPaymentRequest:nil];
    XCTAssertTrue(self.validator.errors.count == 0, @"Current month and year should pass validation");
    
    // 10. Test next month
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.month = 1;
    NSDate *nextMonth = [gregorianCalendar dateByAddingComponents:components toDate:self.now options:0];
    NSString *nextMonthStr = [formatter stringFromDate:nextMonth];
    [self.validator validate:nextMonthStr forPaymentRequest:nil];
    XCTAssertTrue(self.validator.errors.count == 0, @"Next month should pass validation");
}

- (void)testValidateWithCenturyTransition
{
    // 1. Test century transition (current year is 2025)
    [self.validator validate:@"1224" forPaymentRequest:nil];
    XCTAssertTrue(self.validator.errors.count > 0, @"Date in past century should fail validation");
    
    [self.validator validate:@"1225" forPaymentRequest:nil];
    XCTAssertTrue(self.validator.errors.count == 0, @"Date in current century should pass validation");
    
    [self.validator validate:@"1226" forPaymentRequest:nil];
    XCTAssertTrue(self.validator.errors.count == 0, @"Date in current century should pass validation");
    
    // 2. Test century boundaries
    [self.validator validate:@"1299" forPaymentRequest:nil];
    XCTAssertTrue(self.validator.errors.count > 0, @"Date beyond century should fail validation");
}

- (void)testValidateWithEdgeCases
{
    // 1. Test month boundaries
    [self.validator validate:@"0126" forPaymentRequest:nil];
    XCTAssertTrue(self.validator.errors.count == 0, @"First month should pass validation");
    
    [self.validator validate:@"1226" forPaymentRequest:nil];
    XCTAssertTrue(self.validator.errors.count == 0, @"Last month should pass validation");
    
    // 2. Test year boundaries
    [self.validator validate:@"1200" forPaymentRequest:nil];
    XCTAssertTrue(self.validator.errors.count > 0, @"Year 00 should fail validation");
    
    [self.validator validate:@"1299" forPaymentRequest:nil];
    XCTAssertTrue(self.validator.errors.count > 0, @"Year 99 should fail validation");
    
    // 3. Test special characters
    [self.validator validate:@"12-24" forPaymentRequest:nil];
    XCTAssertTrue(self.validator.errors.count > 0, @"Date with special characters should fail validation");
    
    // 4. Test whitespace
    [self.validator validate:@"12 24" forPaymentRequest:nil];
    XCTAssertTrue(self.validator.errors.count > 0, @"Date with spaces should fail validation");
}

@end
