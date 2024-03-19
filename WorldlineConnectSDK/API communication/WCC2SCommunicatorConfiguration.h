//
//  WCC2SCommunicatorConfiguration.h
//  WorldlineConnectSDK
//
//  Created for Worldline Global Collect on 15/12/2016.
//  Copyright © 2017 Worldline Global Collect. All rights reserved.
//

#import <Foundation/Foundation.h>

#import  "WCUtil.h"

@interface WCC2SCommunicatorConfiguration : NSObject {
    NSString *_baseURL;
}

@property (strong, nonatomic) NSString *clientSessionId;
@property (strong, nonatomic) NSString *customerId;

@property (nonatomic, strong) NSString *appIdentifier;
@property (nonatomic, strong) NSString *ipAddress;

@property (nonatomic, strong) NSString *baseURL;
@property (nonatomic, strong) NSString *assetsBaseURL;

@property (nonatomic) BOOL loggingEnabled;


- (instancetype)initWithClientSessionId:(NSString *)clientSessionId customerId:(NSString *)customerId baseURL:(NSString *)baseURL assetBaseURL:(NSString *)assetBaseURL appIdentifier:(NSString *)appIdentifier util:(WCUtil *)util loggingEnabled:(BOOL)loggingEnabled;
- (instancetype)initWithClientSessionId:(NSString *)clientSessionId customerId:(NSString *)customerId baseURL:(NSString *)baseURL assetBaseURL:(NSString *)assetBaseURL appIdentifier:(NSString *)appIdentifier ipAddress:(NSString *)ipAddress util:(WCUtil *)util loggingEnabled:(BOOL)loggingEnabled;
- (NSString *)base64EncodedClientMetaInfo;

@end
