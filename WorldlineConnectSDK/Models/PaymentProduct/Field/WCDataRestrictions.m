//
//  WCDataRestrictions.m
//  WorldlineConnectSDK
//
//  Created for Worldline Global Collect on 15/12/2016.
//  Copyright © 2017 Worldline Global Collect. All rights reserved.
//

#import  "WCDataRestrictions.h"

@implementation WCDataRestrictions

- (instancetype)init
{
    self = [super init];
    if (self != nil) {
        self.validators = [[WCValidators alloc] init];
    }
    return self;
}

@end
