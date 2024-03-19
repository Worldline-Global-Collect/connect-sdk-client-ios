//
//  WCAssetManager.h
//  WorldlineConnectSDK
//
//  Created for Worldline Global Collect on 15/12/2016.
//  Copyright © 2017 Worldline Global Collect. All rights reserved.
//

#import <Foundation/Foundation.h>

#import  "WCBasicPaymentProducts.h"
#import  "WCPaymentProduct.h"

@class WCPaymentItems;

@interface WCAssetManager : NSObject

- (void)initializeImagesForPaymentItems:(NSArray *)paymentItems;
- (void)initializeImagesForPaymentItem:(NSObject<WCPaymentItem> *)paymentItem;
- (void)updateImagesForPaymentItemsAsynchronously:(NSArray *)paymentItems baseURL:(NSString *)baseURL;
- (void)updateImagesForPaymentItemAsynchronously:(NSObject<WCPaymentItem> *)paymentItem baseURL:(NSString *)baseURL;
- (void)updateImagesForPaymentItemsAsynchronously:(NSArray *)paymentItems baseURL:(NSString *)baseURL callback:(void(^)())callback;
- (void)updateImagesForPaymentItemAsynchronously:(NSObject<WCPaymentItem> *)paymentItem baseURL:(NSString *)baseURL callback:(void(^)())callback;
- (UIImage *)logoImageForPaymentItem:(NSString *)paymentItemId;
- (UIImage *)tooltipImageForPaymentItem:(NSString *)paymentItemId field:(NSString *)paymentProductFieldId;

@end
