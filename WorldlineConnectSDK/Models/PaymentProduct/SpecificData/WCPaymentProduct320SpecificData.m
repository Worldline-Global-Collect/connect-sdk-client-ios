//
//  WCPaymentProduct320SpecificData.m
//  WorldlineConnectSDK
//
//  Created for Worldline Global Collect on 18/09/2018.
//  Copyright © 2018 Worldline Global Collect. All rights reserved.
//

#import  "WCPaymentProduct320SpecificData.h"

@implementation WCPaymentProduct320SpecificData

- (instancetype)init
{
    self = [super init];
    if (self != nil) {
        self.networks = [[NSMutableArray alloc] init];
        self.gateway = [[NSString alloc] init];
    }
    return self;
}

@end
