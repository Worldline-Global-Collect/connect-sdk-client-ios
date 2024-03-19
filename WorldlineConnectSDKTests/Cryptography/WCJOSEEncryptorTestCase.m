//
//  WCJOSEEncryptorTestCase.m
//  WorldlineConnectSDK
//
//  Created for Worldline Global Collect on 15/12/2016.
//  Copyright © 2017 Worldline Global Collect. All rights reserved.
//

#import <XCTest/XCTest.h>
#import  "WCEncryptor.h"
#import  "WCJOSEEncryptor.h"

@interface WCJOSEEncryptorTestCase : XCTestCase

@property (strong, nonatomic) WCEncryptor *encryptor;
@property (strong, nonatomic) WCJOSEEncryptor *JOSEEncryptor;
@property (nonatomic) SecKeyRef publicKey;
@property (nonatomic) SecKeyRef privateKey;

@end

@implementation WCJOSEEncryptorTestCase

- (void)setUp
{
    [super setUp];
    self.encryptor = [[WCEncryptor alloc] init];
    self.JOSEEncryptor = [[WCJOSEEncryptor alloc] initWithEncryptor:self.encryptor];
    [self.encryptor generateRSAKeyPairWithPublicTag:@"test-public-key" privateTag:@"test-private-key"];
    self.publicKey = [self.encryptor RSAKeyWithTag:@"test-public-key"];
    self.privateKey = [self.encryptor RSAKeyWithTag:@"test-private-key"];
}

- (void)tearDown
{
    [super tearDown];
    [self.encryptor deleteRSAKeyWithTag:@"test-public-key"];
    [self.encryptor deleteRSAKeyWithTag:@"test-private-key"];
}

- (void)testRevertible
{
    NSString *input = @"Will this encrypt and decrypt properly?";
    NSString *keyId = @"doesn't matter now";
    NSString *encrypted = [self.JOSEEncryptor encryptToCompactSerialization:input withPublicKey:self.publicKey keyId:keyId];
    NSString *decrypted = [self.JOSEEncryptor decryptFromCompactSerialization:encrypted withPrivateKey:self.privateKey];
    NSArray *parts = [decrypted componentsSeparatedByString:@"\n"];
    NSString *output = parts[1];
    XCTAssertTrue([input isEqualToString:output], @"String is not equal to original version after encrypting and decrypting according to the JOSE standard");
}

@end
