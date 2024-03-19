//
//  WCBasicPaymentItemConverter.h
//  WorldlineConnectSDK
//
//  Created for Worldline Global Collect on 15/12/2016.
//  Copyright © 2017 Worldline Global Collect. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WCPaymentProductFields;
@protocol WCBasicPaymentItem;


@interface WCBasicPaymentItemConverter : NSObject

- (void)setBasicPaymentItem:(NSObject <WCBasicPaymentItem> *)paymentItem JSON:(NSDictionary *)rawPaymentItem;

@end
