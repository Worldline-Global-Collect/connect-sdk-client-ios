//
//  WCBasicPaymentItem.h
//  WorldlineConnectSDK
//
//  Created for Worldline Global Collect on 15/12/2016.
//  Copyright © 2017 Worldline Global Collect. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WCAccountsOnFile;
@class WCPaymentItemDisplayHints;

@protocol WCBasicPaymentItem <NSObject>

@property (nonatomic, strong) NSString *identifier;
@property (nonatomic, strong) WCPaymentItemDisplayHints *displayHints;
@property (strong, nonatomic) WCAccountsOnFile *accountsOnFile;
@property (strong, nonatomic) NSString *acquirerCountry;

@end
