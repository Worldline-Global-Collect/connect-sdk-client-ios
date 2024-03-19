//
//  WCPaymentContextConverter.h
//  WorldlineConnectSDK
//
//  Created for Worldline Global Collect on 15/12/2016.
//  Copyright © 2017 Worldline Global Collect. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WCPaymentContext;


@interface WCPaymentContextConverter : NSObject

- (NSDictionary *)JSONFromPaymentProductContext:(WCPaymentContext *)paymentProductContext partialCreditCardNumber:(NSString *)partialCreditCardNumber;
- (NSDictionary *)JSONFromPartialCreditCardNumber:(NSString *)partialCreditCardNumber;

@end
