//
//  WCBase64TestCase.m
//  WorldlineConnectSDK
//
//  Created for Worldline Global Collect on 15/12/2016.
//  Copyright © 2017 Worldline Global Collect. All rights reserved.
//

#import <XCTest/XCTest.h>
#import  "WCBase64.h"

@interface WCBase64TestCase : XCTestCase

@property (strong, nonatomic) WCBase64 *base64;

@end

@implementation WCBase64TestCase

- (void)setUp
{
    [super setUp];
    self.base64 = [[WCBase64 alloc] init];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testEncodeRevertable
{
    unsigned char buffer[4];
    buffer[0] = 0;
    buffer[1] = 255;
    buffer[2] = 43;
    buffer[3] = 1;
    NSData *input = [NSData dataWithBytes:buffer length:4];
    NSString *string = [self.base64 encode:input];
    NSData *output = [self.base64 decode:string];
    XCTAssertTrue([output isEqualToData:input], @"encoded and decoded data differs from the untransformed data");
}

- (void)testURLEncodeRevertable
{
    unsigned char buffer[4];
    buffer[0] = 0;
    buffer[1] = 255;
    buffer[2] = 43;
    buffer[3] = 1;
    NSData *input = [NSData dataWithBytes:buffer length:4];
    NSString *string = [self.base64 URLEncode:input];
    NSData *output = [self.base64 URLDecode:string];
    XCTAssertTrue([output isEqualToData:input], @"URL encoded and URL decoded data differs from the untransformed data");
}

- (void)testEncode
{
    NSData *data = [@"1234" dataUsingEncoding:NSUTF8StringEncoding];
    NSString *output = [self.base64 encode:data];
    XCTAssertTrue([output isEqualToString:@"MTIzNA=="], @"Encoded data does not match expected output");
}

- (void)testURLEncode
{
    NSData *data = [@"1234" dataUsingEncoding:NSUTF8StringEncoding];
    NSString *output = [self.base64 URLEncode:data];
    XCTAssertTrue([output isEqualToString:@"MTIzNA"], @"Encoded data does not match expected output");
}

@end
