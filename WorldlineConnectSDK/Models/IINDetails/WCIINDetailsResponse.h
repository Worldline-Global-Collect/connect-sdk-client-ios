//
//  WCIINDetailsResponse.h
//  WorldlineConnectSDK
//
//  Created for Worldline Global Collect on 15/12/2016.
//  Copyright © 2017 Worldline Global Collect. All rights reserved.
//

#import <Foundation/Foundation.h>

#import  "WCIINStatus.h"

@interface WCIINDetailsResponse : NSObject

@property (strong, nonatomic, readonly) NSString* paymentProductId;
@property (nonatomic, readonly) WCIINStatus status;

@property (strong, nonatomic, readonly) NSArray *coBrands;
@property (strong, nonatomic, readonly) NSString *countryCode;
@property (assign, nonatomic, readonly, getter=isAllowedInContext) BOOL allowedInContext;

- (instancetype)initWithStatus:(WCIINStatus)status;
- (instancetype)initWithPaymentProductId:(NSString *)paymentProductId status:(WCIINStatus)status coBrands:(NSArray *)coBrands countryCode:(NSString *)countryCode allowedInContext:(BOOL)allowedInContext;

@end
