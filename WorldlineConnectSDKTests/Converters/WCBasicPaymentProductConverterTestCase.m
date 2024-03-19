//
//  WCBasicPaymentProductConverterTestCase.m
//  WorldlineConnectSDK
//
//  Created for Worldline Global Collect on 15/12/2016.
//  Copyright © 2017 Worldline Global Collect. All rights reserved.
//

#import <XCTest/XCTest.h>
#import  "WCBasicPaymentProductConverter.h"

@interface WCBasicPaymentProductConverterTestCase : XCTestCase

@property (strong, nonatomic) WCBasicPaymentProductConverter *converter;

@end

@implementation WCBasicPaymentProductConverterTestCase

- (void)setUp
{
    [super setUp];
    self.converter = [[WCBasicPaymentProductConverter alloc] init];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testBasicPaymentProductFromJSON
{
    NSString *paymentProductPath = [[NSBundle bundleForClass:[self class]] pathForResource:@"paymentProduct" ofType:@"json"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSData *paymentProductData = [fileManager contentsAtPath:paymentProductPath];
    NSDictionary *paymentProductJSON = [NSJSONSerialization JSONObjectWithData:paymentProductData options:0 error:NULL];
    WCBasicPaymentProduct *paymentProduct = [self.converter basicPaymentProductFromJSON:paymentProductJSON];
    XCTAssertTrue([paymentProduct.identifier isEqualToString:@"1"] == YES, @"Payment product has an unexpected identifier");
    XCTAssertTrue(paymentProduct.allowsRecurring, @"Unexpected value for 'allowsRecurring'");
    XCTAssertTrue(paymentProduct.allowsTokenization, @"Unexpected value for 'allowsTokenization'");
    XCTAssertNotNil(paymentProduct.displayHints.logoPath, @"Display hints of payment product has no logo path");
    XCTAssertTrue(paymentProduct.accountsOnFile.accountsOnFile.count == 1, @"Unexpected number of accounts on file");
    WCAccountOnFile *accountOnFile = paymentProduct.accountsOnFile.accountsOnFile[0];
    XCTAssertTrue(accountOnFile.attributes.attributes.count == 4, @"Unexpected number of attributes in account on file");
}

@end
