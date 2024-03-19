//
//  WCBasicPaymentProductGroup.h
//  WorldlineConnectSDK
//
//  Created for Worldline Global Collect on 15/12/2016.
//  Copyright © 2017 Worldline Global Collect. All rights reserved.
//

#import <Foundation/Foundation.h>
#import  "WCBasicPaymentItem.h"
#import  "WCAccountOnFile.h"
@class WCStringFormatter;

@interface WCBasicPaymentProductGroup : NSObject <WCBasicPaymentItem>

@property (nonatomic, strong) NSString *identifier;
@property (nonatomic, strong) WCPaymentItemDisplayHints *displayHints;
@property (nonatomic, strong) WCAccountsOnFile *accountsOnFile;
@property (nonatomic, strong) NSString *acquirerCountry;


- (void)setStringFormatter:(WCStringFormatter *)stringFormatter;
- (WCAccountOnFile *)accountOnFileWithIdentifier:(NSString *)accountOnFileIdentifier;

@end
