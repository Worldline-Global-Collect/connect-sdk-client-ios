//
//  WCIINDetailsResponse.m
//  WorldlineConnectSDK
//
//  Created for Worldline Global Collect on 15/12/2016.
//  Copyright © 2017 Worldline Global Collect. All rights reserved.
//

#import  "WCIINDetailsResponse.h"

@implementation WCIINDetailsResponse

- (instancetype)initWithStatus:(WCIINStatus)status {
    self = [super init];
    if (self) {
        _status = status;
    }

    return self;
}

- (instancetype)initWithPaymentProductId:(NSString *)paymentProductId status:(WCIINStatus)status coBrands:(NSArray *)coBrands countryCode:(NSString *)countryCode allowedInContext:(BOOL)allowedInContext {
    self = [super init];
    if (self) {
        _paymentProductId = paymentProductId;
        _status = status;
        _coBrands = coBrands;
        _countryCode = countryCode;
        _allowedInContext = allowedInContext;
    }

    return self;
}


@end
