//
//  WCValidatorTermsAndConditions.m
//  WorldlineConnectSDK
//
//  Created for Worldline Global Collect on 09/01/2018.
//  Copyright © 2018 Worldline Global Collect. All rights reserved.
//

#import "WCValidatorTermsAndConditions.h"
#import "WCValidatorRegularExpression.h"
#import "WCValidationErrorTermsAndConditions.h"
@implementation WCValidatorTermsAndConditions
- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}
- (void)validate:(NSString *)value forPaymentRequest:(WCPaymentRequest *)request
{
    [super validate:value forPaymentRequest:request];
    if (![@"true" isEqualToString:value]) {
        [self.errors addObject:[[WCValidationErrorTermsAndConditions alloc]init]];
    }
}
@end
