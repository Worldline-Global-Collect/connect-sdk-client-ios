//
//  WCJSONTestCase.m
//  WorldlineConnectSDK
//
//  Created for Worldline Global Collect on 15/12/2016.
//  Copyright © 2017 Worldline Global Collect. All rights reserved.
//

#import <XCTest/XCTest.h>
#import  "WCJSON.h"

@interface WCJSONTestCase : XCTestCase

@property (strong, nonatomic) WCJSON *JSON;

@end

@implementation WCJSONTestCase

- (void)setUp
{
    [super setUp];
    self.JSON = [[WCJSON alloc] init];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testDictionary
{
    NSDictionary *input = @{@"firstName": @"John", @"lastName": @"Doe"};
    NSDictionary *firstPair = @{@"key": @"firstName", @"value": @"John"};
    NSDictionary *secondPair = @{@"key": @"lastName", @"value": @"Doe"};
    NSArray *firstOutput = @[firstPair, secondPair];
    NSArray *secondOutput = @[secondPair, firstPair];
    NSData *firstData = [NSJSONSerialization dataWithJSONObject:firstOutput options:0 error:NULL];
    NSData *secondData = [NSJSONSerialization dataWithJSONObject:secondOutput options:0 error:NULL];
    NSString *firstExpectedOutput = [[NSString alloc] initWithData:firstData encoding:NSUTF8StringEncoding];
    NSString *secondExpectedOutput = [[NSString alloc] initWithData:secondData encoding:NSUTF8StringEncoding];
    NSString *actualOutput = [self.JSON keyValueJSONFromDictionary:input];
    XCTAssertTrue([firstExpectedOutput isEqualToString:actualOutput] || [secondExpectedOutput isEqualToString:actualOutput], @"Generated JSON differs from manually constructed JSON");
}

@end
