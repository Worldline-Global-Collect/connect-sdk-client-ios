//
//  WCAccountOnFileTestCase.m
//  WorldlineConnectSDK
//
//  Created for Worldline Global Collect on 15/12/2016.
//  Copyright © 2017 Worldline Global Collect. All rights reserved.
//

#import <XCTest/XCTest.h>
#import  "WCAccountOnFile.h"
#import  "WCPaymentProductConverter.h"

@interface WCAccountOnFileTestCase : XCTestCase

@property (strong, nonatomic) WCAccountOnFile *accountOnFile;
@property (strong, nonatomic) WCPaymentProductConverter *converter;
@property (strong, nonatomic) WCStringFormatter *stringFormatter;

@end

@implementation WCAccountOnFileTestCase

- (void)setUp
{
    [super setUp];
    self.accountOnFile = [[WCAccountOnFile alloc] init];
    self.converter = [[WCPaymentProductConverter alloc] init];
    NSString *paymentProductPath = [[NSBundle bundleForClass:[self class]] pathForResource:@"paymentProduct" ofType:@"json"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSData *paymentProductData = [fileManager contentsAtPath:paymentProductPath];
    NSDictionary *paymentProductJSON = [NSJSONSerialization JSONObjectWithData:paymentProductData options:0 error:NULL];
    WCPaymentProduct *paymentProduct = [self.converter paymentProductFromJSON:paymentProductJSON];
    self.accountOnFile = paymentProduct.accountsOnFile.accountsOnFile[0];
    self.stringFormatter = [[WCStringFormatter alloc] init];
    self.accountOnFile.stringFormatter = self.stringFormatter;
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testMaskedValueForField
{
    NSString *value = [self.accountOnFile maskedValueForField:@"cardNumber"];
    XCTAssertTrue([value isEqualToString:@"**** **** **** 7988 "] == YES, @"Card number of account on file is incorrect");
}

- (void)testMaskedValueForFieldWithMask
{
    NSString *value = [self.accountOnFile maskedValueForField:@"expiryDate" mask:@"{{99}}   {{99}}"];
    XCTAssertTrue([value isEqualToString:@"08   20"] == YES, @"Expiry date of account on file is incorrect");
}

- (void)testHasValueForFieldYes
{
    XCTAssertTrue([self.accountOnFile hasValueForField:@"expiryDate"] == YES, @"Account on file has no value for expiry date");
}

- (void)testHasValueForFieldNo
{
    XCTAssertTrue([self.accountOnFile hasValueForField:@"cvv"] == NO, @"Account on file has a value for cvv");
}

- (void)testLabel
{
    NSString *actualLabel = [self.accountOnFile label];
    NSString *expectedLabel = @"**** **** **** 7988 Rob";
    XCTAssertTrue([actualLabel isEqualToString:expectedLabel] == YES);
}

@end
