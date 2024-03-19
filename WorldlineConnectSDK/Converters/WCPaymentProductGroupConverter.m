//
//  WCPaymentProductGroupConverter.m
//  WorldlineConnectSDK
//
//  Created for Worldline Global Collect on 15/12/2016.
//  Copyright © 2017 Worldline Global Collect. All rights reserved.
//

#import  "WCPaymentProductGroupConverter.h"
#import  "WCPaymentProductGroup.h"

@implementation WCPaymentProductGroupConverter {

}

- (WCPaymentProductGroup *)paymentProductGroupFromJSON:(NSDictionary *)rawProductGroup {
    WCPaymentProductGroup *paymentProductGroup = [WCPaymentProductGroup new];
    [super setPaymentItem:paymentProductGroup JSON:rawProductGroup];
    return paymentProductGroup;
}

@end
