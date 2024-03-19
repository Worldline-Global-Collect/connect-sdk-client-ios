//
//  WCPaymentProductGroupConverter.h
//  WorldlineConnectSDK
//
//  Created for Worldline Global Collect on 15/12/2016.
//  Copyright © 2017 Worldline Global Collect. All rights reserved.
//

#import <Foundation/Foundation.h>
#import  "WCPaymentItemConverter.h"

@class WCPaymentProductGroup;

@interface WCPaymentProductGroupConverter : WCPaymentItemConverter

- (WCPaymentProductGroup *)paymentProductGroupFromJSON:(NSDictionary *)rawProductGroup;

@end
