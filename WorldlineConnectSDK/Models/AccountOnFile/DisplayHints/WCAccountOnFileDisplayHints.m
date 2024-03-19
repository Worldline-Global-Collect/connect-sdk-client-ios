//
//  WCAccountOnFileDisplayHints.m
//  WorldlineConnectSDK
//
//  Created for Worldline Global Collect on 15/12/2016.
//  Copyright © 2017 Worldline Global Collect. All rights reserved.
//

#import  "WCAccountOnFileDisplayHints.h"

@implementation WCAccountOnFileDisplayHints

- (instancetype)init
{
    self = [super init];
    if (self != nil) {
        self.labelTemplate = [[WCLabelTemplate alloc] init];
    }
    return self;
}

@end
