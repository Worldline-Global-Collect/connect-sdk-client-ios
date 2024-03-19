//
//  WCValidatorRange.m
//  WorldlineConnectSDK
//
//  Created for Worldline Global Collect on 15/12/2016.
//  Copyright © 2017 Worldline Global Collect. All rights reserved.
//

#import  "WCValidatorRange.h"
#import  "WCValidationErrorRange.h"

@interface WCValidatorRange ()

@property (strong, nonatomic) NSNumberFormatter *formatter;

@end

@implementation WCValidatorRange

- (instancetype)init
{
    self = [super init];
    if (self != nil) {
        self.formatter = [[NSNumberFormatter alloc] init];
        self.formatter.numberStyle = NSNumberFormatterDecimalStyle;
    }
    return self;
}

- (void)validate:(NSString *)value forPaymentRequest:(WCPaymentRequest *)request
{
    [super validate:value forPaymentRequest:request];
    NSNumber *number = [self.formatter numberFromString:value];
    NSInteger valueAsInteger = [number integerValue];
    WCValidationErrorRange *error = [[WCValidationErrorRange alloc] init];
    error.minValue = self.minValue;
    error.maxValue = self.maxValue;
    if (number == nil) {
        [self.errors addObject:error];
    } else if (valueAsInteger < self.minValue) {
        [self.errors addObject:error];
    } else if (valueAsInteger > self.maxValue) {
        [self.errors addObject:error];
    }
}

@end
