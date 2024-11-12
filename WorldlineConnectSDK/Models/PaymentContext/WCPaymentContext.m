//
//  WCPaymentContext.m
//  WorldlineConnectSDK
//
//  Created for Worldline Global Collect on 15/12/2016.
//  Copyright © 2017 Worldline Global Collect. All rights reserved.
//

#import  "WCPaymentContext.h"
#import  "WCSDKConstants.h"
#import  "WCPaymentAmountOfMoney.h"

@implementation WCPaymentContext

- (instancetype)initWithAmountOfMoney:(WCPaymentAmountOfMoney *)amountOfMoney isRecurring:(BOOL)isRecurring countryCode:(NSString *)countryCode {
    return [self initWithAmountOfMoney:amountOfMoney isRecurring:isRecurring countryCode:countryCode isInstallments:NO];
}

- (instancetype)initWithAmountOfMoney:(WCPaymentAmountOfMoney *)amountOfMoney isRecurring:(BOOL)isRecurring countryCode:(NSString *)countryCode isInstallments:(BOOL)isInstallments {
    self = [super init];
    if (self) {
        self.amountOfMoney = amountOfMoney;
        _isRecurring = isRecurring;
        _countryCode = countryCode;
    }
    self.forceBasicFlow = YES;
    self.isInstallments = isInstallments;
    self.locale = [[[[NSLocale currentLocale] objectForKey: NSLocaleLanguageCode] stringByAppendingString:@"_"] stringByAppendingString:[[NSLocale currentLocale] objectForKey: NSLocaleCountryCode]];

    return self;
}


- (NSString *)description
{
    return [NSString stringWithFormat:@"%@-%@-%@", self.amountOfMoney.description, self.countryCode, self.isRecurring ? @"YES" : @"NO"];
}

@end
