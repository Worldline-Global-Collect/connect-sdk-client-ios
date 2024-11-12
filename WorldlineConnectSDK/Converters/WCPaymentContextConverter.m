//
//  WCPaymentContextConverter.m
//  WorldlineConnectSDK
//
//  Created for Worldline Global Collect on 15/12/2016.
//  Copyright © 2017 Worldline Global Collect. All rights reserved.
//

#import  "WCPaymentContextConverter.h"
#import  "WCPaymentContext.h"
#import  "WCPaymentAmountOfMoney.h"

@implementation WCPaymentContextConverter {

}

- (NSDictionary *)JSONFromPartialCreditCardNumber:(NSString *)partialCreditCardNumber {
    NSMutableDictionary *json = [[NSMutableDictionary alloc] init];
    json[@"bin"] = partialCreditCardNumber;
    return [NSDictionary dictionaryWithDictionary:json];
}

- (NSDictionary *)JSONFromPaymentProductContext:(WCPaymentContext *)paymentProductContext partialCreditCardNumber:(NSString *)partialCreditCardNumber {
    NSDictionary *partialCreditNumberJson = [self JSONFromPartialCreditCardNumber:partialCreditCardNumber];
    NSMutableDictionary *json= [NSMutableDictionary dictionaryWithDictionary:partialCreditNumberJson];
    json[@"paymentContext"] = [self JSONFromPaymentProductContext:paymentProductContext];
    return [NSDictionary dictionaryWithDictionary:json];
}


- (NSDictionary *)JSONFromPaymentProductContext:(WCPaymentContext *)paymentProductContext {
    NSMutableDictionary *rawPaymentProductContext = [[NSMutableDictionary alloc] init];
    NSString *isRecurring = paymentProductContext.isRecurring == YES ? @"true" : @"false";
    rawPaymentProductContext[@"isRecurring"] = isRecurring;
    rawPaymentProductContext[@"countryCode"] = paymentProductContext.countryCode;
    rawPaymentProductContext[@"amountOfMoney"] = [self JSONFromAmountOfMoney:paymentProductContext.amountOfMoney];
    NSString *isInstallments = paymentProductContext.isInstallments == YES ? @"true" : @"false";
    rawPaymentProductContext[@"isInstallments"] = isInstallments;
    return [NSDictionary dictionaryWithDictionary:rawPaymentProductContext];
}

-(NSDictionary *)JSONFromAmountOfMoney:(WCPaymentAmountOfMoney *)amountOfMoney {
    NSMutableDictionary *rawAmount = [[NSMutableDictionary alloc] init];
    rawAmount[@"amount"] = [NSString stringWithFormat:@"%lu", (unsigned long)amountOfMoney.totalAmount];
    rawAmount[@"currencyCode"] = amountOfMoney.currencyCode;
    return [NSDictionary dictionaryWithDictionary:rawAmount];
}

@end
