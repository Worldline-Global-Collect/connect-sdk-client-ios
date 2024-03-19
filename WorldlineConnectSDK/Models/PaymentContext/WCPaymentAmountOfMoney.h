//
//  WCPaymentAmountOfMoney.h
//  WorldlineConnectSDK
//
//  Created for Worldline Global Collect on 15/12/2016.
//  Copyright © 2017 Worldline Global Collect. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WCPaymentAmountOfMoney : NSObject

@property (nonatomic, readonly) long totalAmount;
@property (strong, nonatomic, readonly) NSString *currencyCode;

- (instancetype)initWithTotalAmount:(long)totalAmount currencyCode:(NSString *)currencyCode;

- (NSString *)description;

@end
