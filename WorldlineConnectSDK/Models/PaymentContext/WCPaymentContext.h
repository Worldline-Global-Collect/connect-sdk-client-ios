//
//  WCPaymentContext.h
//  WorldlineConnectSDK
//
//  Created for Worldline Global Collect on 15/12/2016.
//  Copyright © 2017 Worldline Global Collect. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WCPaymentAmountOfMoney;

@interface WCPaymentContext : NSObject

@property (strong, nonatomic) WCPaymentAmountOfMoney *amountOfMoney;
@property (nonatomic, readonly) BOOL isRecurring;
@property (strong, nonatomic, readonly) NSString *countryCode;
@property (strong, nonatomic) NSString *locale;
@property (assign, nonatomic) BOOL forceBasicFlow;
@property (assign, nonatomic) BOOL isInstallments;

- (instancetype)initWithAmountOfMoney:(WCPaymentAmountOfMoney *)amountOfMoney isRecurring:(BOOL)isRecurring countryCode:(NSString *)countryCode;

- (instancetype)initWithAmountOfMoney:(WCPaymentAmountOfMoney *)amountOfMoney isRecurring:(BOOL)isRecurring countryCode:(NSString *)countryCode isInstallments:(BOOL)isInstallments;

@end
