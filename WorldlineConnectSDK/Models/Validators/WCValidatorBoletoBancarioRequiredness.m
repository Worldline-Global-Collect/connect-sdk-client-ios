//
//  WCValidatorBoletoBancarioRequiredness.m
//  WorldlineConnectSDK
//
//  Created for Worldline Global Collect on 02/03/2017.
//  Copyright © 2017 Worldline Global Collect. All rights reserved.
//

#import  "WCValidatorBoletoBancarioRequiredness.h"
#import  "WCPaymentRequest.h"
#import  "WCValidationErrorIsRequired.h"

@implementation WCValidatorBoletoBancarioRequiredness

- (void)validate:(NSString *)value forPaymentRequest:(WCPaymentRequest *)request {
    [super validate:value forPaymentRequest:request];
    if (request != nil) {
        NSString *fiscalNumber = [request unmaskedValueForField:@"fiscalNumber"];
        if (fiscalNumber != nil) {
            if (fiscalNumber.length == self.fiscalNumberLength && [value isEqualToString:@""]) {
                WCValidationErrorIsRequired *error = [[WCValidationErrorIsRequired alloc] init];
                [self.errors addObject:error];
            }
        }
    }
}

@end
