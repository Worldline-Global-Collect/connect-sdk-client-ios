//
//  WCC2SCommunicatorConfigurationTestCase.m
//  WorldlineConnectSDK
//
//  Created for Worldline Global Collect on 15/12/2016.
//  Copyright © 2017 Worldline Global Collect. All rights reserved.
//

#import <XCTest/XCTest.h>
#import  "WCC2SCommunicatorConfiguration.h"
#import  "WCStubUtil.h"

@interface WCC2SCommunicatorConfigurationTestCase : XCTestCase

@property (strong, nonatomic)WCC2SCommunicatorConfiguration *configuration;
@property (strong, nonatomic)WCStubUtil *util;

@end

@implementation WCC2SCommunicatorConfigurationTestCase

- (void)setUp
{
    [super setUp];
    self.util = [[WCStubUtil alloc] init];
    self.configuration = [[WCC2SCommunicatorConfiguration alloc] initWithClientSessionId:@"" customerId:@"" baseURL:@"https://ams1.sandbox.api-worldline.com/client/v1" assetBaseURL:@"https://assets.pay1.sandbox.secured-by-worldline.com" appIdentifier:@"WCC2SCommunicatorConfigurationTestCase" ipAddress:@"" util:[self util] loggingEnabled:YES];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testBaseURL
{
    XCTAssertTrue([[self.configuration baseURL] isEqualToString:@"https://ams1.sandbox.api-worldline.com/client/v1"] == YES, @"Unexpected base URL");
}

- (void)testAssetsBaseURL
{
    XCTAssertTrue([[self.configuration assetsBaseURL] isEqualToString:@"https://assets.pay1.sandbox.secured-by-worldline.com"] == YES, @"Unexpected assets base URL");
}

- (void)testBase64EncodedClientMetaInfo
{
    XCTAssertTrue([[self.configuration base64EncodedClientMetaInfo] isEqualToString:@"base64encodedclientmetainfo"] == YES, @"Unexpected encoded client meta info");
}

@end
