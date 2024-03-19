//
//  WCValidatorLength.m
//  WorldlineConnectSDK
//
//  Created for Worldline Global Collect on 15/12/2016.
//  Copyright © 2017 Worldline Global Collect. All rights reserved.
//

#import  "WCValidatorLength.h"
#import  "WCValidationErrorLength.h"

@implementation WCValidatorLength

- (void)validate:(NSString *)value forPaymentRequest:(WCPaymentRequest *)request
{
    [super validate:value forPaymentRequest:request];
    WCValidationErrorLength *error = [[WCValidationErrorLength alloc] init];
    error.minLength = self.minLength;
    error.maxLength = self.maxLength;
    if (value.length < self.minLength) {
        [self.errors addObject:error];
    }
    if (value.length > self.maxLength) {
        [self.errors addObject:error];
    }
}

@end
