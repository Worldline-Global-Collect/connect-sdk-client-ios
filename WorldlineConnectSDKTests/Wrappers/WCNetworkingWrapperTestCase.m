//
//  WCNetworkingWrapperTestCase.m
//  WorldlineConnectSDK
//
//  Created for Worldline Global Collect on 15/12/2016.
//  Copyright © 2017 Worldline Global Collect. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import <HTTPStubs.h>

#import  "WCNetworkingWrapper.h"
#import  "WCC2SCommunicatorConfiguration.h"
#import  "WCUtil.h"

@interface WCNetworkingWrapperTestCase : XCTestCase

@property (strong, nonatomic) WCNetworkingWrapper *wrapper;
@property (strong, nonatomic) WCUtil *util;
@property (strong, nonatomic) WCC2SCommunicatorConfiguration *configuration;
@property (strong, nonatomic) NSString *baseURL;
@property (strong, nonatomic) NSString *merchantId;

@end

@implementation WCNetworkingWrapperTestCase

- (void)setUp
{
    [super setUp];
    
    self.util = [[WCUtil alloc] init];
    self.wrapper = [[WCNetworkingWrapper alloc] init];
    self.configuration = [[WCC2SCommunicatorConfiguration alloc] initWithClientSessionId:@"clientSessionId" customerId:@"customerId" baseURL:@"https://ams1.sandbox.api-worldline.com/client/v1" assetBaseURL:@"https://assets.pay1.sandbox.secured-by-worldline.com" appIdentifier:@"WCNetworkingWrapperTestCase" ipAddress:@"127.0.0.1" util: self.util loggingEnabled:YES];
    self.baseURL = [self.configuration baseURL];
    self.merchantId = @"1234";
    
    [HTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
      return [request.URL.path isEqualToString:@"/client/v1/1234/sessions"];
    } withStubResponse:^HTTPStubsResponse*(NSURLRequest *request) {
        // Stub the POST request with an error response
        NSDictionary* errorDictionary = @{
            @"errorId": @"1",
            @"errors": @[@{
                @"category": @"Test failure",
                @"code": @"9002",
                @"httpStatusCode": @403,
                @"id": @"1",
                @"message": @"MISSING_OR_INVALID_AUTHORIZATION",
            }]
        };
        return [HTTPStubsResponse responseWithJSONObject:errorDictionary statusCode:200 headers:nil];
    }];
    
    [HTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
      return [request.URL.path isEqualToString:@"/client/v1/1234/crypto/publickey"];
    } withStubResponse:^HTTPStubsResponse*(NSURLRequest *request) {
        // Stub the GET request with an error response
        NSDictionary* errorDictionary = @{
            @"errorId": @"1",
            @"errors": @[@{
                @"category": @"Test failure",
                @"code": @"9002",
                @"httpStatusCode": @403,
                @"id": @"1",
                @"message": @"MISSING_OR_INVALID_AUTHORIZATION",
            }]
        };
        return [HTTPStubsResponse responseWithJSONObject:errorDictionary statusCode:200 headers:nil];
    }];
}

- (void)testPost
{
    NSString *sessionsURL = [NSString stringWithFormat:@"%@/%@/sessions", self.baseURL, self.merchantId];
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"Response provided"];
    
    NSMutableIndexSet *additionalAcceptableStatusCodes = [[NSMutableIndexSet alloc] initWithIndex:401];
    [self.wrapper postResponseForURL:sessionsURL headers:nil withParameters:@{} additionalAcceptableStatusCodes:additionalAcceptableStatusCodes success:^(id responseObject) {
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

- (void)testGet
{
    NSString *publicKeyURL = [NSString stringWithFormat:@"%@/%@/crypto/publickey", self.baseURL, self.merchantId];
    
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
    XCTAssertTrue([[errorResponse objectForKey:@"errorId"] isEqualToString:@"1"]);
    
    NSArray *errors = (NSArray *)[errorResponse objectForKey:@"errors"];
    NSDictionary *firstError = [errors objectAtIndex:0];
    XCTAssertTrue([[firstError objectForKey:@"category"] isEqualToString:@"Test failure"]);
    XCTAssertTrue([[firstError objectForKey:@"code"] isEqualToString:@"9002"]);
    XCTAssertEqual([[firstError objectForKey:@"httpStatusCode"] integerValue], 403);
    XCTAssertTrue([[firstError objectForKey:@"id"] isEqualToString: @"1"]);
    XCTAssertTrue([[firstError objectForKey:@"message"] isEqualToString:@"MISSING_OR_INVALID_AUTHORIZATION"]);
    [expectation fulfill];
}

@end

