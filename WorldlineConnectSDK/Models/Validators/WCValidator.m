//
//  WCValidator.m
//  WorldlineConnectSDK
//
//  Created for Worldline Global Collect on 15/12/2016.
//  Copyright © 2017 Worldline Global Collect. All rights reserved.
//

#import  "WCValidator.h"
#import  "WCPaymentRequest.h"

@implementation WCValidator

- (instancetype)init
{
    self = [super init];
    if (self != nil) {
        self.errors = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)validate:(NSString *)value forPaymentRequest:(WCPaymentRequest *)request
{
    [self.errors removeAllObjects];
}

@end
