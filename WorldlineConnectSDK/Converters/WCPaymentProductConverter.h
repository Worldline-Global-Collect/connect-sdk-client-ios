//
//  WCPaymentProductConverter.h
//  WorldlineConnectSDK
//
//  Created for Worldline Global Collect on 15/12/2016.
//  Copyright © 2017 Worldline Global Collect. All rights reserved.
//

#import  "WCBasicPaymentProductConverter.h"
#import  "WCPaymentProduct.h"
#import  "WCPaymentItemConverter.h"

@interface WCPaymentProductConverter : WCBasicPaymentProductConverter

- (WCPaymentProduct *)paymentProductFromJSON:(NSDictionary *)rawProduct;

@end
