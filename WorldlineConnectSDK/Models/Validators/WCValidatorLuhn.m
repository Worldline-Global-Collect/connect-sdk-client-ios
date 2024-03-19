//
//  WCValidatorLuhn.m
//  WorldlineConnectSDK
//
//  Created for Worldline Global Collect on 15/12/2016.
//  Copyright © 2017 Worldline Global Collect. All rights reserved.
//

#import  "WCValidatorLuhn.h"
#import  "WCValidationErrorLuhn.h"

@implementation WCValidatorLuhn

- (void)validate:(NSString *)value forPaymentRequest:(WCPaymentRequest *)request
{
    [super validate:value forPaymentRequest:request];
    NSInteger evenSum = 0;
    NSInteger oddSum = 0;
    NSInteger digit;
    for (int i = 1; i <= value.length; ++i) {
        unsigned long j = value.length - i;
        digit = [[NSString stringWithFormat:@"%C", [value characterAtIndex:j]] integerValue];
        if (i % 2 == 1) {
            evenSum += digit;
        } else {
            digit = digit * 2;
            digit = (digit % 10) + (digit / 10);
            oddSum += digit;
        }
    }
    NSInteger total = evenSum + oddSum;
    if (total % 10 != 0) {
        WCValidationErrorLuhn *error = [[WCValidationErrorLuhn alloc] init];
        [self.errors addObject:error];
    }
}

@end
