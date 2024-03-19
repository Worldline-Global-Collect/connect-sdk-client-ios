//
//  WCBasicPaymentProductsConverter.h
//  WorldlineConnectSDK
//
//  Created for Worldline Global Collect on 15/12/2016.
//  Copyright © 2017 Worldline Global Collect. All rights reserved.
//

#import <Foundation/Foundation.h>

#import  "WCBasicPaymentProducts.h"
#import  "WCAssetManager.h"
#import  "WCStringFormatter.h"

@interface WCBasicPaymentProductsConverter : NSObject

- (WCBasicPaymentProducts *)paymentProductsFromJSON:(NSArray *)rawProducts;

@end
