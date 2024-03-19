//
//  WCPaymentGroupsConverterTestCase.m
//  WorldlineConnectSDK
//
//  Created for Worldline Global Collect on 15/12/2016.
//  Copyright © 2017 Worldline Global Collect. All rights reserved.
//

#import <XCTest/XCTest.h>
#import  "WCPaymentItemDisplayHints.h"
#import  "WCBasicPaymentProductGroup.h"
#import  "WCPaymentProductGroupsConverter.h"
#import  "WCBasicPaymentProductGroups.h"

@interface WCPaymentGroupsConverterTestCase : XCTestCase

@property (nonatomic, strong) WCPaymentProductGroupsConverter *converter;

@end

@implementation WCPaymentGroupsConverterTestCase

- (void)setUp {
    [super setUp];
    self.converter = [WCPaymentProductGroupsConverter new];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testPaymentProductGroupsFromJSON {
    NSString *paymentProductGroupsPath = [[NSBundle bundleForClass:[self class]] pathForResource:@"paymentProductGroups" ofType:@"json"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSData *paymentProductGroupsData = [fileManager contentsAtPath:paymentProductGroupsPath];
    NSDictionary *paymentProductGroupsJSON = [NSJSONSerialization JSONObjectWithData:paymentProductGroupsData options:0 error:NULL];
    WCBasicPaymentProductGroups *paymentProductGroups = [self.converter paymentProductGroupsFromJSON:paymentProductGroupsJSON[@"paymentProductGroups"]];
    if (paymentProductGroups.paymentProductGroups.count != 1) {
        XCTFail(@"Wrong number of payment products.");
    }
    for (WCBasicPaymentProductGroup *product in paymentProductGroups.paymentProductGroups) {
        XCTAssertNotNil(product.identifier, @"Payment product has no identifier");
        XCTAssertNotNil(product.displayHints, @"Payment product has no displayHints");
        XCTAssertNotNil(product.displayHints.logoPath, @"Payment product has no logo path in displayHints");
    }

}

@end
