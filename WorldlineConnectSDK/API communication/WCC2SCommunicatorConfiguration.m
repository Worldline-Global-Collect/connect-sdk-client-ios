//
//  WCC2SCommunicatorConfiguration.m
//  WorldlineConnectSDK
//
//  Created for Worldline Global Collect on 15/12/2016.
//  Copyright © 2017 Worldline Global Collect. All rights reserved.
//

#import  "WCC2SCommunicatorConfiguration.h"
#import "WCSDKConstants.h"
@interface WCC2SCommunicatorConfiguration ()

@property (strong, nonatomic) WCUtil *util;

@end

@implementation WCC2SCommunicatorConfiguration

- (instancetype)initWithClientSessionId:(NSString *)clientSessionId customerId:(NSString *)customerId baseURL:(NSString *)baseURL assetBaseURL:(NSString *)assetBaseURL appIdentifier:(NSString *)appIdentifier util:(WCUtil *)util {
    self = [super init];
    if (self != nil) {
        self.clientSessionId = clientSessionId;
        self.customerId = customerId;
        self.baseURL = baseURL;
        self.assetsBaseURL = assetBaseURL;
        self.util = util;
        self.appIdentifier = appIdentifier;
        self.loggingEnabled = NO;
    }
    return self;
}
- (instancetype)initWithClientSessionId:(NSString *)clientSessionId customerId:(NSString *)customerId baseURL:(NSString *)baseURL assetBaseURL:(NSString *)assetBaseURL appIdentifier:(NSString *)appIdentifier util:(WCUtil *)util loggingEnabled:(BOOL)loggingEnabled {
    self = [super init];
    if (self != nil) {
        self.clientSessionId = clientSessionId;
        self.customerId = customerId;
        self.baseURL = baseURL;
        self.assetsBaseURL = assetBaseURL;
        self.util = util;
        self.appIdentifier = appIdentifier;
        self.loggingEnabled = loggingEnabled;
    }
    return self;
}
- (instancetype)initWithClientSessionId:(NSString *)clientSessionId customerId:(NSString *)customerId baseURL:(NSString *)baseURL assetBaseURL:(NSString *)assetBaseURL appIdentifier:(NSString *)appIdentifier ipAddress:(NSString *)ipAddress util:(WCUtil *)util {
    self = [super init];
    if (self != nil) {
        self.clientSessionId = clientSessionId;
        self.customerId = customerId;
        self.baseURL = baseURL;
        self.assetsBaseURL = assetBaseURL;
        self.util = util;
        self.appIdentifier = appIdentifier;
        self.ipAddress = ipAddress;
        self.loggingEnabled = NO;
    }
    return self;
}

- (instancetype)initWithClientSessionId:(NSString *)clientSessionId customerId:(NSString *)customerId baseURL:(NSString *)baseURL assetBaseURL:(NSString *)assetBaseURL appIdentifier:(NSString *)appIdentifier ipAddress:(NSString *)ipAddress util:(WCUtil *)util loggingEnabled:(BOOL)loggingEnabled {
    self = [super init];
    if (self != nil) {
        self.clientSessionId = clientSessionId;
        self.customerId = customerId;
        self.baseURL = baseURL;
        self.assetsBaseURL = assetBaseURL;
        self.util = util;
        self.appIdentifier = appIdentifier;
        self.ipAddress = ipAddress;
        self.loggingEnabled = loggingEnabled;
    }
    return self;
}

- (NSString *)fixURL:(NSString *)url
{
    NSMutableArray<NSString *> *components;
    if (@available(iOS 7.0, *)) {
        NSURLComponents *finalComponents = [NSURLComponents componentsWithString:url];
        components = [[finalComponents.path componentsSeparatedByString:@"/"] filteredArrayUsingPredicate:
                      [NSPredicate predicateWithFormat:@"length > 0"]].mutableCopy;
    }
    else {
        components = [[[NSURL URLWithString:url].path componentsSeparatedByString:@"/"] filteredArrayUsingPredicate:
                      [NSPredicate predicateWithFormat:@"length > 0"]].mutableCopy;
    }
    
    
    NSArray<NSString *> *versionComponents = [kWCAPIVersion componentsSeparatedByString:@"/"];
    NSString *exceptionReason = [NSString stringWithFormat: @"This version of the connectSDK is only compatible with %@ , you supplied: '%@'",
                                 [versionComponents componentsJoinedByString: @"/"],
                                 [components componentsJoinedByString: @"/"]];
    NSException *invalidURLException = [NSException exceptionWithName:@"WCInvalidURLException"
                                                               reason:exceptionReason
                                                             userInfo:nil];
    NSURL *nsurl = [NSURL URLWithString:url];
    switch (components.count) {
        case 0: {
            components = versionComponents.mutableCopy;
            break;
        }
        case 1: {
            if (![components[0] isEqualToString:versionComponents[0]]) {
                @throw invalidURLException;
            }
            [components addObject:versionComponents[1]];
            break;
        }
        case 2: {
            if (![components[0] isEqualToString:versionComponents[0]]) {
                @throw invalidURLException;
            }
            if (![components[1] isEqualToString:versionComponents[1]]) {
                @throw invalidURLException;
            }
            break;
        }
        default: {
            @throw invalidURLException;
            break;
        }
    }
    if (@available(iOS 7.0, *)) {
        NSURLComponents *finalComponents = [NSURLComponents componentsWithString:url];
        finalComponents.path = [@"/" stringByAppendingString:[components componentsJoinedByString:@"/"]];
        return finalComponents.URL.absoluteString;
    }
    while ([nsurl.path stringByReplacingOccurrencesOfString:@"/" withString:@""].length) {
        nsurl = [nsurl URLByDeletingLastPathComponent];
    }
    for (NSString *component in components) {
        nsurl = [nsurl URLByAppendingPathComponent:component];
    }
    return nsurl.absoluteString;
}
- (void)setBaseURL:(NSString *)baseURL {
    self->_baseURL = [self fixURL:baseURL];
}
- (NSString *)baseURL
{
    if (self->_baseURL != nil) {
        return self->_baseURL;
    } else {
        NSString *exceptionReason = [NSString stringWithFormat: @"baseURL is nil, please make sure to provide this in the initialisation."];
        NSException *invalidURLException = [NSException exceptionWithName:@"WCMissingURLException"
                                                                   reason:exceptionReason
                                                                 userInfo:nil];
        @throw invalidURLException;
    }
}
- (NSString *)assetsBaseURL
{
    if (self->_assetsBaseURL != nil) {
        return self->_assetsBaseURL;
    } else {
        NSString *exceptionReason = [NSString stringWithFormat: @"baseURL is nil, please make sure to provide this in the initialisation."];
        NSException *invalidURLException = [NSException exceptionWithName:@"WCMissingURLException"
                                                                   reason:exceptionReason
                                                                 userInfo:nil];
        @throw invalidURLException;
    }
}

- (NSString *)base64EncodedClientMetaInfo
{
    return [self.util base64EncodedClientMetaInfoWithAppIdentifier:self.appIdentifier ipAddress:self.ipAddress];
}

-(void)setLoggingEnabled:(BOOL)loggingEnabled {
    self->_loggingEnabled = loggingEnabled;
}

@end
