//
//  WCValidators.m
//  WorldlineConnectSDK
//
//  Created for Worldline Global Collect on 15/12/2016.
//  Copyright © 2017 Worldline Global Collect. All rights reserved.
//

#import  "WCValidators.h"

@implementation WCValidators

- (instancetype)init
{
    self = [super init];
    if (self != nil) {
        self.validators = [[NSMutableArray alloc] init];
        self.containsSomeTimesRequiredValidator = NO;
    }
    return self;
}

@end
