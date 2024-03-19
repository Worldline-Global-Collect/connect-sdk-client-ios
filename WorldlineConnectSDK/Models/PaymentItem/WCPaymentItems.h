//
//  WCPaymentItems.h
//  WorldlineConnectSDK
//
//  Created for Worldline Global Collect on 15/12/2016.
//  Copyright © 2017 Worldline Global Collect. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WCStringFormatter;
@protocol WCBasicPaymentItem;
@class WCBasicPaymentProducts;
@class WCBasicPaymentProductGroups;


@interface WCPaymentItems : NSObject

@property (nonatomic, strong) NSMutableArray *paymentItems;

- (instancetype)initWithPaymentProducts:(WCBasicPaymentProducts *)products groups:(WCBasicPaymentProductGroups *)groups;

- (BOOL)hasAccountsOnFile;
- (NSArray *)accountsOnFile;
- (NSObject<WCBasicPaymentItem> *)paymentItemWithIdentifier:(NSString *)paymentItemIdentifier;
- (void)sort;

@end
