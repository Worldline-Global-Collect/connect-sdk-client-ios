//
//  WCUtilTestCase.m
//  WorldlineConnectSDK
//
//  Created for Worldline Global Collect on 15/12/2016.
//  Copyright © 2017 Worldline Global Collect. All rights reserved.
//

#import <XCTest/XCTest.h>
#import  "WCUtil.h"
#import  "WCBase64.h"

@interface WCUtilTestCase : XCTestCase

@property (strong, nonatomic) WCUtil *util;
@property (strong, nonatomic) WCBase64 *base64;
@property (strong, atomic) NSString *appIdentifier;

@end

@implementation WCUtilTestCase

- (void)setUp
{
    [super setUp];
    self.util = [[WCUtil alloc] init];
    self.base64 = [[WCBase64 alloc] init];
    self.appIdentifier = @"WCUtilTestCase";
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testBase64EncodedClientMetaInfo;
{
    NSString *info = [self.util base64EncodedClientMetaInfoWithAppIdentifier: _appIdentifier];
    NSData *decodedInfo = [self.base64 decode:info];
    NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:decodedInfo options:0 error:NULL];
    XCTAssertTrue([[JSON objectForKey:@"deviceBrand"] isEqualToString:@"Apple"] == YES, @"Incorrect device brand in meta info");
}

- (void)testBase64EncodedClientMetaInfoWithAddedData;
{
    NSString *info = [self.util base64EncodedClientMetaInfoWithAppIdentifier:_appIdentifier ipAddress:@"" addedData:@{@"test": @"value"}];
    NSData *decodedInfo = [self.base64 decode:info];
    NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:decodedInfo options:0 error:NULL];
    XCTAssertTrue([[JSON objectForKey:@"test"] isEqualToString:@"value"] == YES, @"Incorrect value for added key in meta info");
}

@end
