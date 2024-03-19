//
//  WCBasicPaymentProductGroupConverter.m
//  WorldlineConnectSDK
//
//  Created for Worldline Global Collect on 15/12/2016.
//  Copyright © 2017 Worldline Global Collect. All rights reserved.
//

#import  "WCBasicPaymentProductGroupConverter.h"
#import  "WCBasicPaymentProductGroup.h"

@implementation WCBasicPaymentProductGroupConverter

- (WCBasicPaymentProductGroup *)paymentProductGroupFromJSON:(NSDictionary *)rawProductGroup {
    WCBasicPaymentProductGroup *paymentProductGroup = [WCBasicPaymentProductGroup new];
    [super setBasicPaymentItem:paymentProductGroup JSON:rawProductGroup];
    return paymentProductGroup;
}

@end
