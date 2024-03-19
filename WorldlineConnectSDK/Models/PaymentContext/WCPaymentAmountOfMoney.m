//
//  WCPaymentAmountOfMoney.m
//  WorldlineConnectSDK
//
//  Created for Worldline Global Collect on 15/12/2016.
//  Copyright © 2017 Worldline Global Collect. All rights reserved.
//

#import  "WCPaymentAmountOfMoney.h"
#import  "WCSDKConstants.h"

@implementation WCPaymentAmountOfMoney {

}

- (instancetype)initWithTotalAmount:(long)totalAmount currencyCode:(NSString *)currencyCode {
    self = [super init];
    if (self) {
        _totalAmount = totalAmount;
        _currencyCode = currencyCode;
    }

    return self;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%ld-%@", (long) self.totalAmount, self.currencyCode];
}

@end
