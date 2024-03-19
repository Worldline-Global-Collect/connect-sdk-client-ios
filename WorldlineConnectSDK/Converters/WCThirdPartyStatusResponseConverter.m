//
//  WCThirdPartyStatusResponseConverter.m
//  Pods
//
//  Created for Worldline Global Collect on 13/07/2017.
//  Copyright © 2017 Worldline Global Collect. All rights reserved.
//
//

#import "WCThirdPartyStatusResponseConverter.h"
#import "WCThirdPartyStatusResponse.h"
@implementation WCThirdPartyStatusResponseConverter
- (WCThirdPartyStatusResponse *)thirdPartyResponseFromJSON:(NSDictionary *)rawThirdPartyResponse {
    WCThirdPartyStatusResponse *response = [[WCThirdPartyStatusResponse alloc]init];
    NSString *thirdPartyStatusString = rawThirdPartyResponse[@"thirdPartyStatus"];
    if ([thirdPartyStatusString isEqualToString:@"WAITING"]) {
        response.thirdPartyStatus = WCThirdPartyStatusWaiting;
    }
    else if ([thirdPartyStatusString isEqualToString:@"INITIALIZED"]) {
        response.thirdPartyStatus = WCThirdPartyStatusInitialized;
    }
    else if ([thirdPartyStatusString isEqualToString:@"AUTHRORIZED"]) {
        response.thirdPartyStatus = WCThirdPartyStatusAuthorized;
    }
    else {
        response.thirdPartyStatus = WCThirdPartyStatusCompleted;
    }
    return response;
}
@end
