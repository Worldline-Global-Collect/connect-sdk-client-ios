//
//  WCPublicKeyResponse.m
//  WorldlineConnectSDK
//
//  Created for Worldline Global Collect on 15/12/2016.
//  Copyright © 2017 Worldline Global Collect. All rights reserved.
//

#import  "WCPublicKeyResponse.h"

@implementation WCPublicKeyResponse

- (instancetype)initWithKeyId:(NSString *)keyId encodedPublicKey:(NSString *)encodedPublicKey
{
    self = [super init];
    if (self != nil) {
        _keyId = keyId;
        _encodedPublicKey = encodedPublicKey;
    }
    return self;
}

@end
