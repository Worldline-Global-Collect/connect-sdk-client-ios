//
//  WCBasicPaymentProductGroupConverter.h
//  WorldlineConnectSDK
//
//  Created for Worldline Global Collect on 15/12/2016.
//  Copyright © 2017 Worldline Global Collect. All rights reserved.
//

#import <Foundation/Foundation.h>
#import  "WCBasicPaymentItemConverter.h"
#import  "WCPaymentItemConverter.h"

@class WCPaymentProductGroup;
@class WCBasicPaymentProductGroup;

@interface WCBasicPaymentProductGroupConverter : WCBasicPaymentItemConverter

- (WCBasicPaymentProductGroup *)paymentProductGroupFromJSON:(NSDictionary *)rawProductGroup;

@end
