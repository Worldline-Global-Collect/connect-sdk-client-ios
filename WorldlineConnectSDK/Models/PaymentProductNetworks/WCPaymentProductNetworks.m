//
//  WCPaymentProductNetworks.m
//  WorldlineConnectSDK
//
//  Created for Worldline Global Collect on 15/12/2016.
//  Copyright © 2017 Worldline Global Collect. All rights reserved.
//

#import  "WCPaymentProductNetworks.h"

@implementation WCPaymentProductNetworks

- (instancetype)init
{
    self = [super init];
    if (self != nil) {
        self.paymentProductNetworks = [[NSMutableArray alloc] init];
    }
    return self;
}

@end
