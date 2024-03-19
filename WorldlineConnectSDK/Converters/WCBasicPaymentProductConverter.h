//
//  WCBasicPaymentProductConverter.h
//  WorldlineConnectSDK
//
//  Created for Worldline Global Collect on 15/12/2016.
//  Copyright © 2017 Worldline Global Collect. All rights reserved.
//

#import <Foundation/Foundation.h>

#import  "WCBasicPaymentProduct.h"
#import  "WCAssetManager.h"
#import  "WCStringFormatter.h"
#import  "WCBasicPaymentItemConverter.h"

@interface WCBasicPaymentProductConverter : WCBasicPaymentItemConverter

- (WCBasicPaymentProduct *)basicPaymentProductFromJSON:(NSDictionary *)rawBasicProduct;
- (void)setBasicPaymentProduct:(WCBasicPaymentProduct *)basicProduct JSON:(NSDictionary *)rawBasicProduct;

@end
