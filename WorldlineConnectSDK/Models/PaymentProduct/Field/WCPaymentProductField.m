//
//  WCPaymentProductField.m
//  WorldlineConnectSDK
//
//  Created for Worldline Global Collect on 15/12/2016.
//  Copyright © 2017 Worldline Global Collect. All rights reserved.
//

#import  "WCPaymentProductField.h"
#import  "WCValidator.h"
#import  "WCValidationErrorIsRequired.h"
#import  "WCValidationErrorInteger.h"
#import  "WCValidationErrorNumericString.h"

@interface WCPaymentProductField ()

@property (strong, nonatomic) NSNumberFormatter *numberFormatter;
@property (strong, nonatomic) NSRegularExpression *numericStringCheck;

@end

@implementation WCPaymentProductField

- (instancetype)init
{
    self = [super init];
    if (self != nil) {
        self.dataRestrictions = [[WCDataRestrictions alloc] init];
        self.displayHints = [[WCPaymentProductFieldDisplayHints alloc] init];
        self.errors = [[NSMutableArray alloc] init];
        self.numericStringCheck = [[NSRegularExpression alloc] initWithPattern:@"^\\d+$" options:0 error:nil];
        self.numberFormatter = [[NSNumberFormatter alloc] init];
        self.numberFormatter.numberStyle = NSNumberFormatterDecimalStyle;
    }
    return self;
}

- (void)validateValue:(NSString *)value forPaymentRequest:(WCPaymentRequest *)request
{
    [self.errors removeAllObjects];
    if (self.dataRestrictions.isRequired == YES && [value isEqualToString:@""] == YES) {
        WCValidationErrorIsRequired *error = [[WCValidationErrorIsRequired alloc] init];
        [self.errors addObject:error];
    } else if (self.dataRestrictions.isRequired == YES || [value isEqualToString:@""] == NO || self.dataRestrictions.validators.containsSomeTimesRequiredValidator) {
        for (WCValidator *rule in self.dataRestrictions.validators.validators) {
            [rule validate:value forPaymentRequest:request];
            [self.errors addObjectsFromArray:rule.errors];
        }
        switch (self.type) {
            case WCExpirationDate:
                break;
            case WCInteger: {
                NSNumber *number = [self.numberFormatter numberFromString:value];
                if (number == nil) {
                    WCValidationErrorInteger *error = [[WCValidationErrorInteger alloc] init];
                    [self.errors addObject:error];
                }
                break;
            }
            case WCNumericString: {
                if ([self.numericStringCheck numberOfMatchesInString:value options:0 range:NSMakeRange(0, value.length)] != 1) {
                    WCValidationErrorNumericString *error = [[WCValidationErrorNumericString alloc] init];
                    [self.errors addObject:error];
                }
                break;
            }
            case WCString:
                break;
            case WCBooleanString:
                break;
            case WCDateString:
                break;
            default:
                [NSException raise:@"Invalid type" format:@"Type %u is invalid", self.type];
                break;
        }
    }
}

@end
