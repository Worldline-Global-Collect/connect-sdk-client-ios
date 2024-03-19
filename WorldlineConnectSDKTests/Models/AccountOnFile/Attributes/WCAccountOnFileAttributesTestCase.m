//
//  WCAccountOnFileAttributesTestCase.m
//  WorldlineConnectSDK
//
//  Created for Worldline Global Collect on 15/12/2016.
//  Copyright © 2017 Worldline Global Collect. All rights reserved.
//

#import <XCTest/XCTest.h>
#import  "WCAccountOnFileAttributes.h"
#import  "WCAccountOnFileAttribute.h"

@interface WCAccountOnFileAttributesTestCase : XCTestCase

@property (strong, nonatomic) WCAccountOnFileAttributes *attributes;

@end

@implementation WCAccountOnFileAttributesTestCase

- (void)setUp
{
    [super setUp];
    self.attributes = [[WCAccountOnFileAttributes alloc] init];
    WCAccountOnFileAttribute *attribute1 = [[WCAccountOnFileAttribute alloc] init];
    attribute1.key = @"key1";
    attribute1.value = @"value1";
    WCAccountOnFileAttribute *attribute2 = [[WCAccountOnFileAttribute alloc] init];
    attribute2.key = @"key2";
    attribute2.value = @"value2";
    [self.attributes.attributes addObject:attribute1];
    [self.attributes.attributes addObject:attribute2];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testValueForField
{
    XCTAssertTrue([[self.attributes valueForField:@"key1"] isEqualToString:@"value1"] == YES, @"Incorrect value for key");
}

- (void)testHasValueForFieldYes
{
    XCTAssertTrue([self.attributes hasValueForField:@"key1"] == YES, @"Attributes should have a value for this key");
}

- (void)testHasValueForFieldNo
{
    XCTAssertTrue([self.attributes hasValueForField:@"key3"] == NO, @"Attributes should not have a value for this key");
}

@end
