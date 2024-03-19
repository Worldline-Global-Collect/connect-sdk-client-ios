//
//  WCPaymentProductConverter.m
//  WorldlineConnectSDK
//
//  Created for Worldline Global Collect on 15/12/2016.
//  Copyright © 2017 Worldline Global Collect. All rights reserved.
//

#import  "WCPaymentProductConverter.h"

@implementation WCPaymentProductConverter

- (WCPaymentProduct *)paymentProductFromJSON:(NSDictionary *)rawProduct
{
    WCPaymentProduct *product = [[WCPaymentProduct alloc] init];
    [super setBasicPaymentProduct:product JSON:rawProduct];

    WCPaymentItemConverter *itemConverter = [WCPaymentItemConverter new];
    [itemConverter setPaymentProductFields:product.fields JSON:[rawProduct objectForKey:@"fields"]];
    return product;
}

@end
