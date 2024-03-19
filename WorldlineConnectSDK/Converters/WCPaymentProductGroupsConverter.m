//
//  WCPaymentProductGroupsConverter.m
//  WorldlineConnectSDK
//
//  Created for Worldline Global Collect on 15/12/2016.
//  Copyright © 2017 Worldline Global Collect. All rights reserved.
//

#import  "WCPaymentProductGroupsConverter.h"
#import  "WCBasicPaymentProductGroups.h"
#import  "WCBasicPaymentProductGroupConverter.h"

@implementation WCPaymentProductGroupsConverter

- (WCBasicPaymentProductGroups *)paymentProductGroupsFromJSON:(NSArray *)rawProductGroups {
    WCBasicPaymentProductGroups *groups = [WCBasicPaymentProductGroups new];
    WCBasicPaymentProductGroupConverter *converter = [WCBasicPaymentProductGroupConverter new];
    for (NSDictionary *rawProductGroup in rawProductGroups) {
        WCBasicPaymentProductGroup *group = [converter paymentProductGroupFromJSON:rawProductGroup];
        [groups.paymentProductGroups addObject:group];
    }
    [groups sort];
    return groups;
}

@end
