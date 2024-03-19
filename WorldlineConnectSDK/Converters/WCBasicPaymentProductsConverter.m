//
//  WCBasicPaymentProductsConverter.m
//  WorldlineConnectSDK
//
//  Created for Worldline Global Collect on 15/12/2016.
//  Copyright © 2017 Worldline Global Collect. All rights reserved.
//

#import  "WCBasicPaymentProductsConverter.h"
#import  "WCBasicPaymentProductConverter.h"

@implementation WCBasicPaymentProductsConverter

- (WCBasicPaymentProducts *)paymentProductsFromJSON:(NSArray *)rawProducts
{
    WCBasicPaymentProducts *products = [[WCBasicPaymentProducts alloc] init];
    WCBasicPaymentProductConverter *converter = [[WCBasicPaymentProductConverter alloc] init];
    for (NSDictionary *rawProduct in rawProducts) {
        WCBasicPaymentProduct *product = [converter basicPaymentProductFromJSON:rawProduct];
        [products.paymentProducts addObject:product];
    }
    [products sort];
    return products;
}

@end
