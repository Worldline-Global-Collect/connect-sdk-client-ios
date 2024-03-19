//
//  WCIINDetailsResponseConverter.m
//  WorldlineConnectSDK
//
//  Created for Worldline Global Collect on 15/12/2016.
//  Copyright © 2017 Worldline Global Collect. All rights reserved.
//

#import  "WCIINDetailsResponseConverter.h"
#import  "WCIINDetail.h"

@implementation WCIINDetailsResponseConverter {

}

- (WCIINDetailsResponse *)IINDetailsResponseFromJSON:(NSDictionary *)rawIINDetailsResponse {
    NSNumber *paymentProductIdNumber = rawIINDetailsResponse[@"paymentProductId"];
    NSString *paymentProductId = [NSString stringWithFormat:@"%@", paymentProductIdNumber];
    NSString *countryCode = rawIINDetailsResponse[@"countryCode"];
    BOOL allowedInContext = NO;
    if (rawIINDetailsResponse[@"isAllowedInContext"] != nil) {
        allowedInContext = [rawIINDetailsResponse[@"isAllowedInContext"] boolValue];
    }
    NSArray *coBrands = [self IINDetailsFromJSON:rawIINDetailsResponse[@"coBrands"]];

    if (paymentProductIdNumber == nil) {
        return [[WCIINDetailsResponse  alloc] initWithStatus:WCUnknown];
    }
    else if (allowedInContext == NO) {
        return [[WCIINDetailsResponse  alloc] initWithStatus:WCExistingButNotAllowed];
    }
    else {
        WCIINDetailsResponse *response = [[WCIINDetailsResponse alloc] initWithPaymentProductId:paymentProductId
                                                                                         status:WCSupported
                                                                                       coBrands:coBrands
                                                                                    countryCode:countryCode
                                                                               allowedInContext:allowedInContext];
        return response;
    }
}

- (NSArray *)IINDetailsFromJSON:(NSArray *)IINDetailsArray {
    NSMutableArray *IINDetails = [[NSMutableArray alloc] init];
    for (NSDictionary *rawIINDetail in IINDetailsArray) {
        [IINDetails addObject:[self IINDetailFromJSON:rawIINDetail]];
    }
    return [NSArray arrayWithArray:IINDetails];
}

- (WCIINDetail *)IINDetailFromJSON:(NSDictionary *)rawIINDetail {
    NSString *paymentProductId = [NSString stringWithFormat:@"%@", rawIINDetail[@"paymentProductId"]];
    BOOL allowedInContext = NO;
    if (rawIINDetail[@"isAllowedInContext"] != nil) {
        allowedInContext = [rawIINDetail[@"isAllowedInContext"] boolValue];
    }
    WCIINDetail *detail = [[WCIINDetail alloc] initWithPaymentProductId:paymentProductId allowedInContext:allowedInContext];
    return detail;
}

@end
