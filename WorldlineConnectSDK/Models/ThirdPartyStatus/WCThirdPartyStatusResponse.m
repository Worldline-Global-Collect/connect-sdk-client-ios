//
//  WCThirdPartyStatusResponse.m
//  Pods
//
//  Created for Worldline Global Collect on 13/07/2017.
//  Copyright © 2017 Worldline Global Collect. All rights reserved.
//
//

#import "WCThirdPartyStatusResponse.h"

@implementation WCThirdPartyStatusResponse
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.thirdPartyStatus = WCThirdPartyStatusWaiting;
    }
    return self;
}
@end
