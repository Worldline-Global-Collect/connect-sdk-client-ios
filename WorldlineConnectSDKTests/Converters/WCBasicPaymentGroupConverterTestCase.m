//
//  WCBasicPaymentGroupConverterTestCase.m
//  WorldlineConnectSDK
//
//  Created for Worldline Global Collect on 15/12/2016.
//  Copyright © 2017 Worldline Global Collect. All rights reserved.
//

#import  "WCAccountsOnFile.h"
#import  "WCPaymentItemDisplayHints.h"
#import  "WCBasicPaymentProductGroup.h"
#import <XCTest/XCTest.h>
#import  "WCBasicPaymentProductGroupConverter.h"

@interface WCBasicPaymentGroupConverterTestCase : XCTestCase

@property (strong, nonatomic) WCBasicPaymentProductGroupConverter *converter;

@end

@implementation WCBasicPaymentGroupConverterTestCase

- (void)setUp {
    [super setUp];
    self.converter = [WCBasicPaymentProductGroupConverter new];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testBasicPaymentProductGroupFromJSON {
    NSString *paymentProductGroupPath = [[NSBundle bundleForClass:[self class]] pathForResource:@"paymentProductGroup" ofType:@"json"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSData *paymentProductGroupData = [fileManager contentsAtPath:paymentProductGroupPath];
    NSDictionary *paymentProductGroupJSON = [NSJSONSerialization JSONObjectWithData:paymentProductGroupData options:0 error:NULL];
    WCBasicPaymentProductGroup *paymentProductGroup = [self.converter paymentProductGroupFromJSON:paymentProductGroupJSON];
    XCTAssertTrue([paymentProductGroup.identifier isEqualToString:@"card"] == YES, @"Payment product has an unexpected identifier");
    XCTAssertNotNil(paymentProductGroup.displayHints.logoPath, @"Display hints of payment product has no logo path");
    XCTAssertTrue(paymentProductGroup.accountsOnFile.accountsOnFile.count == 0, @"Unexpected number of accounts on file");
}

@end
