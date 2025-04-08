//
//  WCValidatorExpirationDate.m
//  WorldlineConnectSDK
//
//  Created for Worldline Global Collect on 15/12/2016.
//  Copyright © 2017 Worldline Global Collect. All rights reserved.
//

#import  "WCValidatorExpirationDate.h"
#import  "WCValidationErrorExpirationDate.h"

@interface WCValidatorExpirationDate ()

@property (strong, nonatomic) NSDateFormatter *dateFormatter;
@property (strong, nonatomic) NSDateFormatter *dateFormatterWithFullYear;
@property (strong, nonatomic) NSCalendar *gregorianCalendar;
@property (strong, nonatomic) NSLocale *posixLocale;

@end

@implementation WCValidatorExpirationDate

- (instancetype)init
{
    self = [super init];
    if (self) {
        // Create Gregorian calendar
        self.gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        [self.gregorianCalendar setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"]];
        
        // Create fixed locale
        self.posixLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
        
        // Setup date formatters
        self.dateFormatter = [[NSDateFormatter alloc] init];
        [self.dateFormatter setLocale:self.posixLocale];
        [self.dateFormatter setCalendar:self.gregorianCalendar];
        [self.dateFormatter setDateFormat:@"MMyy"];
        
        self.dateFormatterWithFullYear = [[NSDateFormatter alloc] init];
        [self.dateFormatterWithFullYear setLocale:self.posixLocale];
        [self.dateFormatterWithFullYear setCalendar:self.gregorianCalendar];
        [self.dateFormatterWithFullYear setDateFormat:@"MMyyyy"];
    }
    return self;
}

- (void)validate:(NSString *)value forPaymentRequest:(WCPaymentRequest *)request
{
    [super validate:value forPaymentRequest:request];
    
    // 验证输入格式
    if (value == nil || value.length != 4) {
        [self.errors addObject:[[WCValidationErrorExpirationDate alloc] init]];
        return;
    }
    
    // 验证输入是否为纯数字
    NSCharacterSet *nonDigits = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    if ([value rangeOfCharacterFromSet:nonDigits].location != NSNotFound) {
        [self.errors addObject:[[WCValidationErrorExpirationDate alloc] init]];
        return;
    }
    
    // 验证月份
    NSString *monthString = [value substringWithRange:NSMakeRange(0, 2)];
    NSInteger month = [monthString integerValue];
    if (month < 1 || month > 12) {
        [self.errors addObject:[[WCValidationErrorExpirationDate alloc] init]];
        return;
    }
    
    NSDate *enteredDate = [self obtainEnteredDateFromValue:value];
    if (enteredDate == nil) {
        [self.errors addObject:[[WCValidationErrorExpirationDate alloc] init]];
        return;
    }
    
    // 使用传入的now参数
    NSDate *now = [self.gregorianCalendar dateFromComponents:[self.gregorianCalendar components:NSCalendarUnitYear | NSCalendarUnitMonth fromDate:[NSDate date]]];
    NSDate *futureDate = [self.gregorianCalendar dateByAddingUnit:NSCalendarUnitYear value:25 toDate:now options:0];
    
    BOOL valid = [self validateDateIsBetween:now andFutureDate:futureDate withDateToValidate:enteredDate];
    if (!valid) {
        [self.errors addObject:[[WCValidationErrorExpirationDate alloc] init]];
    }
}

- (NSDate *)obtainEnteredDateFromValue:(NSString *)value
{
    // Extract month and year from input value
    NSString *monthString = [value substringWithRange:NSMakeRange(0, 2)];
    NSString *yearString = [value substringWithRange:NSMakeRange(2, 2)];
    
    // Get current date components
    NSDateComponents *nowComponents = [self.gregorianCalendar components:NSCalendarUnitYear fromDate:[NSDate date]];
    NSInteger currentYear = nowComponents.year;
    
    // Create target date components
    NSDateComponents *targetComponents = [[NSDateComponents alloc] init];
    targetComponents.month = [monthString integerValue];
    
    // Process year
    NSInteger targetYear = [yearString integerValue];
    NSInteger century = (currentYear / 100) * 100;
    
    // If target year is less than current year's last two digits, it means next century
    if (targetYear < currentYear % 100) {
        targetYear += century + 100;
    } else {
        targetYear += century;
    }
    
    targetComponents.year = targetYear;
    
    // Create date from components using Gregorian calendar
    return [self.gregorianCalendar dateFromComponents:targetComponents];
}

- (BOOL)validateDateIsBetween:(NSDate *)now andFutureDate:(NSDate *)futureDate withDateToValidate:(NSDate *)dateToValidate
{
    // Ensure all dates are in Gregorian calendar
    NSDateComponents *nowComponents = [self.gregorianCalendar components:NSCalendarUnitYear | NSCalendarUnitMonth fromDate:now];
    NSDateComponents *futureComponents = [self.gregorianCalendar components:NSCalendarUnitYear | NSCalendarUnitMonth fromDate:futureDate];
    NSDateComponents *validateComponents = [self.gregorianCalendar components:NSCalendarUnitYear | NSCalendarUnitMonth fromDate:dateToValidate];
    
    NSInteger nowYear = nowComponents.year;
    NSInteger nowMonth = nowComponents.month;
    NSInteger futureYear = futureComponents.year;
    NSInteger futureMonth = futureComponents.month;
    NSInteger validateYear = validateComponents.year;
    NSInteger validateMonth = validateComponents.month;
    
    // First check year
    if (validateYear < nowYear) {
        return NO;
    }
    if (validateYear > futureYear) {
        return NO;
    }
    
    // Then check month if year is the same
    if (validateYear == nowYear && validateMonth < nowMonth) {
        return NO;
    }
    if (validateYear == futureYear && validateMonth > futureMonth) {
        return NO;
    }
    
    return YES;
}

@end
