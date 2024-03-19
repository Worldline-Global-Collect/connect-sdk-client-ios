//
//  WCPaymentProductGroup.h
//  WorldlineConnectSDK
//
//  Created for Worldline Global Collect on 15/12/2016.
//  Copyright © 2017 Worldline Global Collect. All rights reserved.
//

#import <Foundation/Foundation.h>
#import  "WCPaymentItem.h"

@class WCStringFormatter;
@class WCAccountOnFile;
@class WCPaymentProductField;

@interface WCPaymentProductGroup : NSObject <WCPaymentItem>

@property (nonatomic, strong) NSString *identifier;
@property (nonatomic, strong) WCPaymentItemDisplayHints *displayHints;
@property (strong, nonatomic) WCAccountsOnFile *accountsOnFile;
@property (nonatomic, strong) NSString *acquirerCountry;
@property (nonatomic) BOOL allowsTokenization;
@property (nonatomic) BOOL allowsRecurring;
@property (nonatomic) BOOL autoTokenized;
@property (strong, nonatomic) WCPaymentProductFields *fields;

- (WCAccountOnFile *)accountOnFileWithIdentifier:(NSString *)accountOnFileIdentifier;
- (void)setStringFormatter:(WCStringFormatter *)stringFormatter;
- (WCPaymentProductField *)paymentProductFieldWithId:(NSString *)paymentProductFieldId;

@end
