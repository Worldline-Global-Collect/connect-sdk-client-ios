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
@property (strong, nonatomic) NSDateFormatter *fullYearDateFormatter;
@property (strong, nonatomic) NSDateFormatter *monthAndFullYearDateFormatter;

@end

@implementation WCValidatorExpirationDate

- (instancetype)init
{
    self = [super init];
    if (self != nil) {
        self.dateFormatter = [[NSDateFormatter alloc] init];
        [self.dateFormatter setDateFormat:@"MMyy"];

        self.fullYearDateFormatter = [[NSDateFormatter alloc] init];
        [self.fullYearDateFormatter setDateFormat:@"yyyy"];

        self.monthAndFullYearDateFormatter = [[NSDateFormatter alloc] init];
        [self.monthAndFullYearDateFormatter setDateFormat:@"MMyyyy"];
    }
    return self;
}

- (void)validate:(NSString *)value forPaymentRequest:(WCPaymentRequest *)request
{
    [super validate:value forPaymentRequest:request];
    NSDate *submittedDate = [self.dateFormatter dateFromString:value];
    if (submittedDate == nil) {
        WCValidationErrorExpirationDate *error = [[WCValidationErrorExpirationDate alloc] init];
        [self.errors addObject:error];
    } else {

        NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        NSDate *now = [NSDate date];

        NSDate *enteredDate = [self obtainEnteredDateFromValue:value];

        // If the entered date is before the year 2000, add a century.
        NSDateComponents *componentsForFutureDate = [[NSDateComponents alloc] init];
        componentsForFutureDate.year = [gregorianCalendar component:NSCalendarUnitYear fromDate:now] + 25;
        NSDate *futureDate = [gregorianCalendar dateFromComponents:componentsForFutureDate];

        if (![self validateDateIsBetween:now andFutureDate:futureDate withDateToValidate:enteredDate]) {
            WCValidationErrorExpirationDate *error = [[WCValidationErrorExpirationDate alloc] init];
            [self.errors addObject:error];
        }
    }
}

- (NSDate *)obtainEnteredDateFromValue:(NSString *) value
{
    NSString *year = [self.fullYearDateFormatter stringFromDate:[NSDate date]];
    NSString *valueWithCentury = [[[value substringToIndex:2] stringByAppendingString:[year substringToIndex:2]] stringByAppendingString:[value substringFromIndex:2]];

    return [self.monthAndFullYearDateFormatter dateFromString:valueWithCentury];
}

- (BOOL)validateDateIsBetween:(NSDate *)now andFutureDate:(NSDate *)futureDate withDateToValidate:(NSDate *)dateToValidate
{
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];

    NSComparisonResult lowerBoundComparison = [gregorianCalendar compareDate:now toDate:dateToValidate toUnitGranularity:NSCalendarUnitMonth];
    if (lowerBoundComparison == NSOrderedDescending) {
        return NO;
    }

    NSComparisonResult upperBoundComparison = [gregorianCalendar compareDate:futureDate toDate:dateToValidate toUnitGranularity:NSCalendarUnitYear];
    if (upperBoundComparison == NSOrderedAscending) {
        return NO;
    }

    return YES;
}

@end
