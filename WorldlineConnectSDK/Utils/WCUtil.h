//
//  WCUtil.h
//  WorldlineConnectSDK
//
//  Created for Worldline Global Collect on 15/12/2016.
//  Copyright © 2017 Worldline Global Collect. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WCUtil : NSObject

- (NSString *)base64EncodedClientMetaInfoWithAppIdentifier:(NSString *)appIdentifier;
- (NSString *)base64EncodedClientMetaInfoWithAppIdentifier:(NSString *)appIdentifier ipAddress:(NSString *)ipAddress;
- (NSString *)base64EncodedClientMetaInfoWithAppIdentifier:(NSString *)appIdentifier ipAddress:(NSString *)ipAddress addedData:(NSDictionary *)addedData;

@end
