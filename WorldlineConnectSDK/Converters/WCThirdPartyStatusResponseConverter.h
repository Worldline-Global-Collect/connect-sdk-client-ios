//
//  WCThirdPartyStatusResponseConverter.h
//  Pods
//
//  Created for Worldline Global Collect on 13/07/2017.
//  Copyright © 2017 Worldline Global Collect. All rights reserved.
//
//

#import <Foundation/Foundation.h>
@class WCThirdPartyStatusResponse;
@interface WCThirdPartyStatusResponseConverter : NSObject
- (WCThirdPartyStatusResponse *)thirdPartyResponseFromJSON:(NSDictionary *)rawThirdPartyResponse;
@end
