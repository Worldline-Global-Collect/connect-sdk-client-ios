//
//  WCPaymentProductFieldDisplayHints.m
//  WorldlineConnectSDK
//
//  Created for Worldline Global Collect on 15/12/2016.
//  Copyright © 2017 Worldline Global Collect. All rights reserved.
//

#import  "WCPaymentProductFieldDisplayHints.h"

@implementation WCPaymentProductFieldDisplayHints

- (instancetype)init
{
    self = [super init];
    if (self != nil) {
        self.formElement = [[WCFormElement alloc] init];
        self.tooltip = [[WCTooltip alloc] init];
    }
    return self;
}

@end
