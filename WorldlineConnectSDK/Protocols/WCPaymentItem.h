//
//  WCPaymentItem.h
//  WorldlineConnectSDK
//
//  Created for Worldline Global Collect on 15/12/2016.
//  Copyright © 2017 Worldline Global Collect. All rights reserved.
//

#import <Foundation/Foundation.h>
#import  "WCBasicPaymentItem.h"

@class WCPaymentItemDisplayHints;
@class WCAccountsOnFile;
@class WCPaymentProductFields;
@class WCPaymentProductField;

@protocol WCPaymentItem <NSObject, WCBasicPaymentItem>

@property (strong, nonatomic) WCPaymentProductFields *fields;

- (WCPaymentProductField *)paymentProductFieldWithId:(NSString *)paymentProductFieldId;

@end
