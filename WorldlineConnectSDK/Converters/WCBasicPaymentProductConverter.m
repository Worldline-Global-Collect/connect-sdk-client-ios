//
//  WCPaymentProductConverter.m
//  WorldlineConnectSDK
//
//  Created for Worldline Global Collect on 15/12/2016.
//  Copyright © 2017 Worldline Global Collect. All rights reserved.
//

#import  "WCBasicPaymentProductConverter.h"

@implementation WCBasicPaymentProductConverter

- (WCBasicPaymentProduct *)basicPaymentProductFromJSON:(NSDictionary *)rawBasicProduct
{
    WCBasicPaymentProduct *basicProduct = [[WCBasicPaymentProduct alloc] init];
    [self setBasicPaymentProduct:basicProduct JSON:rawBasicProduct];
    return basicProduct;
}

- (void)setBasicPaymentProduct:(WCBasicPaymentProduct *)basicProduct JSON:(NSDictionary *)rawBasicProduct
{
    [super setBasicPaymentItem:basicProduct JSON:rawBasicProduct];
    basicProduct.allowsRecurring = [[rawBasicProduct objectForKey:@"allowsRecurring"] boolValue];
    basicProduct.allowsTokenization = [[rawBasicProduct objectForKey:@"allowsTokenization"] boolValue];
    basicProduct.autoTokenized = [[rawBasicProduct objectForKey:@"autoTokenized"] boolValue];
    basicProduct.allowsInstallments = [[rawBasicProduct objectForKey:@"allowsInstallments"] boolValue];
    basicProduct.paymentMethod = [rawBasicProduct objectForKey:@"paymentMethod"];
    basicProduct.paymentProductGroup = [rawBasicProduct objectForKey:@"paymentProductGroup"];

    if (rawBasicProduct[@"paymentProduct302SpecificData"] != nil) {
        WCPaymentProduct302SpecificData *paymentProduct302SpecificData = [[WCPaymentProduct302SpecificData alloc] init];
        [self setPaymentProduct302SpecificData:paymentProduct302SpecificData JSON:[rawBasicProduct objectForKey:@"paymentProduct302SpecificData"]];
        basicProduct.paymentProduct302SpecificData = paymentProduct302SpecificData;
    }
    if (rawBasicProduct[@"paymentProduct320SpecificData"] != nil) {
        WCPaymentProduct320SpecificData *paymentProduct320SpecificData = [[WCPaymentProduct320SpecificData alloc] init];
        [self setPaymentProduct320SpecificData:paymentProduct320SpecificData JSON:[rawBasicProduct objectForKey:@"paymentProduct320SpecificData"]];
        basicProduct.paymentProduct320SpecificData = paymentProduct320SpecificData;
    }
    if (rawBasicProduct[@"paymentProduct863SpecificData"] != nil) {
        WCPaymentProduct863SpecificData *paymentProduct863SpecificData = [[WCPaymentProduct863SpecificData alloc] init];
        [self setPaymentProduct863SpecificData:paymentProduct863SpecificData JSON:[rawBasicProduct objectForKey:@"paymentProduct863SpecificData"]];
        basicProduct.paymentProduct863SpecificData = paymentProduct863SpecificData;
    }
}

- (void)setPaymentProduct302SpecificData:(WCPaymentProduct302SpecificData *)paymentProduct302SpecificData JSON:(NSDictionary *)rawPaymentProduct302SpecificData
{
    NSArray *rawNetworks = [rawPaymentProduct302SpecificData objectForKey:@"networks"];
    for (NSString *network in rawNetworks) {
        [paymentProduct302SpecificData.networks addObject:network];
    }
}

- (void)setPaymentProduct320SpecificData:(WCPaymentProduct320SpecificData *)paymentProduct320SpecificData JSON:(NSDictionary *)rawPaymentProduct320SpecificData
{
    paymentProduct320SpecificData.gateway = [[rawPaymentProduct320SpecificData objectForKey:@"gateway"] stringValue];
    NSArray *rawNetworks = [rawPaymentProduct320SpecificData objectForKey:@"networks"];
    for (NSString *network in rawNetworks) {
        [paymentProduct320SpecificData.networks addObject:network];
    }
}

- (void)setPaymentProduct863SpecificData:(WCPaymentProduct863SpecificData *)paymentProduct863SpecificData JSON:(NSDictionary *)rawPaymentProduct863SpecificData
{
    NSArray *rawIntegrationTypes = [rawPaymentProduct863SpecificData objectForKey:@"integrationTypes"];
    for (NSString *integrationType in rawIntegrationTypes) {
        [paymentProduct863SpecificData.integrationTypes addObject:integrationType];
    }
}



@end
