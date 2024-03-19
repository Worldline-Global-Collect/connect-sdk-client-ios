//
//  WCNetworkingWrapperTestCase.m
//  WorldlineConnectSDK
//
//  Created for Worldline Global Collect on 15/12/2016.
//  Copyright © 2017 Worldline Global Collect. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import  "WCNetworkingWrapper.h"
#import  "WCC2SCommunicatorConfiguration.h"
#import  "WCUtil.h"

@interface WCNetworkingWrapperTestCase : XCTestCase

@property (strong, nonatomic) WCNetworkingWrapper *wrapper;
@property (strong, nonatomic) WCUtil *util;
@property (strong, nonatomic) WCC2SCommunicatorConfiguration *configuration;

@end

@implementation WCNetworkingWrapperTestCase

- (void)setUp
{
    [super setUp];
    
    self.util = [[WCUtil alloc] init];
    self.wrapper = [[WCNetworkingWrapper alloc] init];
    self.configuration = [[WCC2SCommunicatorConfiguration alloc] initWithClientSessionId:@"clientSessionId" customerId:@"customerId" baseURL:@"https://ams1.sandbox.api-worldline.com/client/v1" assetBaseURL:@"https://assets.pay1.sandbox.secured-by-worldline.com" appIdentifier:@"WCNetworkingWrapperTestCase" ipAddress:@"127.0.0.1" util: self.util loggingEnabled:YES];
    
}

- (void)ignore_testPost
{
    NSString *baseURL = [self.configuration baseURL];
    NSString *merchantId = @"1234";
    NSString *sessionsURL = [NSString stringWithFormat:@"%@/%@/sessions", baseURL, merchantId];
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"Response provided"];
    
    NSMutableIndexSet *additionalAcceptableStatusCodes = [[NSMutableIndexSet alloc] initWithIndex:401];
    [self.wrapper postResponseForURL:sessionsURL headers:nil withParameters:nil additionalAcceptableStatusCodes:additionalAcceptableStatusCodes success:^(id responseObject) {
        [self assertErrorResponse:(NSDictionary *)responseObject expectation:expectation];
    } failure:^(NSError *error) {
        XCTFail(@"Unexpected failure while testing POST request: %@", [error localizedDescription]);
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError *error) {
        if (error) {
            NSLog(@"Timeout error: %@", [error localizedDescription]);
        }
    }];
}

- (void)ignore_testGet
{
    NSString *baseURL = [self.configuration baseURL];
    NSString *customerId = @"1234";
    NSString *publicKeyURL = [NSString stringWithFormat:@"%@/%@/crypto/publickey", baseURL, customerId];
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"Response provided"];
    
    NSMutableIndexSet *additionalAcceptableStatusCodes = [[NSMutableIndexSet alloc] initWithIndex:401];
    [self.wrapper getResponseForURL:publicKeyURL headers:nil additionalAcceptableStatusCodes:additionalAcceptableStatusCodes success:^(id responseObject) {
        [self assertErrorResponse:(NSDictionary *)responseObject expectation:expectation];
    } failure:^(NSError *error) {
        XCTFail(@"Unexpected failure while testing GET request: %@", [error localizedDescription]);
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError *error) {
        if (error) {
            NSLog(@"Timeout error: %@", [error localizedDescription]);
        }
    }];
}

- (void)assertErrorResponse:(NSDictionary *)errorResponse expectation:(XCTestExpectation *)expectation
{
    NSArray *errors = (NSArray *)[errorResponse objectForKey:@"errors"];
    NSDictionary *firstError = [errors objectAtIndex:0];
    XCTAssertEqual([[firstError objectForKey:@"code"] integerValue], 9002);
    XCTAssertTrue([[firstError objectForKey:@"message"] isEqualToString:@"MISSING_OR_INVALID_AUTHORIZATION"]);
    [expectation fulfill];
}

@end

