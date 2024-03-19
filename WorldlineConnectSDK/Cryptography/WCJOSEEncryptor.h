//
//  WCJOSEEncryptor.h
//  WorldlineConnectSDK
//
//  Created for Worldline Global Collect on 15/12/2016.
//  Copyright © 2017 Worldline Global Collect. All rights reserved.
//

#import <Foundation/Foundation.h>
#import  "WCEncryptor.h"

@interface WCJOSEEncryptor : NSObject

- (instancetype)initWithEncryptor:(WCEncryptor *)encryptor;
- (NSString *)encryptToCompactSerialization:(NSString *)JSON withPublicKey:(SecKeyRef)publicKey keyId:(NSString *)keyId;
- (NSString *)decryptFromCompactSerialization:(NSString *)JOSE withPrivateKey:(SecKeyRef)privateKey;

@end
