//
//  WCBasicPaymentProducts.h
//  WorldlineConnectSDK
//
//  Created for Worldline Global Collect on 15/12/2016.
//  Copyright © 2017 Worldline Global Collect. All rights reserved.
//

#import <Foundation/Foundation.h>

#import  "WCBasicPaymentProduct.h"

@interface WCBasicPaymentProducts : NSObject

@property (strong, nonatomic) NSMutableArray *paymentProducts;

- (BOOL)hasAccountsOnFile;
- (NSArray *)accountsOnFile;
- (WCBasicPaymentProduct *)paymentProductWithIdentifier:(NSString *)paymentProductIdentifier;
- (void)sort;
- (void)setStringFormatter:(WCStringFormatter *)stringFormatter;

@end
