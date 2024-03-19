//
//  WCPublicKeyResponse.h
//  WorldlineConnectSDK
//
//  Created for Worldline Global Collect on 15/12/2016.
//  Copyright © 2017 Worldline Global Collect. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WCPublicKeyResponse : NSObject

@property (strong, nonatomic, readonly) NSString *keyId;
@property (strong, nonatomic, readonly) NSString *encodedPublicKey;

- (instancetype)initWithKeyId:(NSString *)keyId encodedPublicKey:(NSString *)encodedPublicKey;

@end
