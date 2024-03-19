//
//  WCPaymentProduct863SpecificData.m
//  WorldlineConnectSDK
//
//  Created for Worldline Global Collect on 18/09/2018.
//  Copyright © 2018 Worldline Global Collect. All rights reserved.
//

#import  "WCPaymentProduct863SpecificData.h"

@implementation WCPaymentProduct863SpecificData

- (instancetype)init
{
    self = [super init];
    if (self != nil) {
        self.integrationTypes = [[NSMutableArray alloc] init];
    }
    return self;
}

@end
