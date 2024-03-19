//
//  WCIINDetail.m
//  WorldlineConnectSDK
//
//  Created for Worldline Global Collect on 15/12/2016.
//  Copyright © 2017 Worldline Global Collect. All rights reserved.
//

#import  "WCIINDetail.h"

@implementation WCIINDetail {

}
- (instancetype)initWithPaymentProductId:(NSString *)paymentProductId allowedInContext:(BOOL)allowedInContext {
    self = [super init];
    if (self) {
        _paymentProductId = paymentProductId;
        _allowedInContext = allowedInContext;
    }

    return self;
}

@end
