//
//  WCPaymentItemConverter.h
//  WorldlineConnectSDK
//
//  Created for Worldline Global Collect on 15/12/2016.
//  Copyright © 2017 Worldline Global Collect. All rights reserved.
//

#import <Foundation/Foundation.h>
#import  "WCBasicPaymentItemConverter.h"

@protocol WCPaymentItem;

@interface WCPaymentItemConverter : WCBasicPaymentItemConverter

- (void)setPaymentItem:(NSObject <WCPaymentItem> *)paymentItem JSON:(NSDictionary *)rawPaymentItem;

- (void)setPaymentProductFields:(WCPaymentProductFields *)fields JSON:(NSArray *)rawFields;

@end
