//
//  WCValidatorRegularExpression.m
//  WorldlineConnectSDK
//
//  Created for Worldline Global Collect on 15/12/2016.
//  Copyright © 2017 Worldline Global Collect. All rights reserved.
//

#import  "WCValidatorRegularExpression.h"
#import  "WCValidationErrorRegularExpression.h"

@implementation WCValidatorRegularExpression

- (instancetype)initWithRegularExpression:(NSRegularExpression *)regularExpression
{
    self = [super init];
    if (self != nil) {
        _regularExpression = regularExpression;
    }
    return self;
}

- (void)validate:(NSString *)value forPaymentRequest:(WCPaymentRequest *)request
{
    [super validate:value forPaymentRequest:request];
    NSInteger numberOfMatches = [self.regularExpression numberOfMatchesInString:value options:0 range:NSMakeRange(0, value.length)];
    if (numberOfMatches != 1) {
        WCValidationErrorRegularExpression *error = [[WCValidationErrorRegularExpression alloc] init];
        [self.errors addObject:error];
    }
}

@end
