//
//  WCValidatorFixedList.m
//  WorldlineConnectSDK
//
//  Created for Worldline Global Collect on 15/12/2016.
//  Copyright © 2017 Worldline Global Collect. All rights reserved.
//

#import  "WCValidatorFixedList.h"
#import  "WCValidationErrorFixedList.h"

@implementation WCValidatorFixedList

- (instancetype) initWithAllowedValues:(NSArray *)allowedValues
{
    self = [super init];
    if (self != nil) {
        _allowedValues = allowedValues;
    }
    return self;
}

- (void)validate:(NSString *)value forPaymentRequest:(WCPaymentRequest *)request
{
    [super validate:value forPaymentRequest:request];
    for (NSString *allowedValue in self.allowedValues) {
        if ([allowedValue isEqualToString:value] == YES) {
            return;
        }
    }
    WCValidationErrorFixedList *error = [[WCValidationErrorFixedList alloc] init];
    [self.errors addObject:error];
}

@end
