//
//  WCBasicPaymentProductGroups.h
//  WorldlineConnectSDK
//
//  Created for Worldline Global Collect on 15/12/2016.
//  Copyright © 2017 Worldline Global Collect. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WCStringFormatter;
@class WCBasicPaymentProductGroup;

@interface WCBasicPaymentProductGroups : NSObject

@property (nonatomic, strong) NSMutableArray *paymentProductGroups;

- (BOOL)hasAccountsOnFile;
- (NSArray *)accountsOnFile;
- (WCBasicPaymentProductGroup *)paymentProductGroupWithIdentifier:(NSString *)paymentProductGroupIdentifier;
- (void)sort;
- (void)setStringFormatter:(WCStringFormatter *)stringFormatter;

@end
