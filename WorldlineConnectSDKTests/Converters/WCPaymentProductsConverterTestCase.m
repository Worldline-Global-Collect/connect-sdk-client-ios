//
//  WCPaymentProductsConverterTestCase.m
//  WorldlineConnectSDK
//
//  Created for Worldline Global Collect on 15/12/2016.
//  Copyright © 2017 Worldline Global Collect. All rights reserved.
//

#import <XCTest/XCTest.h>
#import  "WCBasicPaymentProductsConverter.h"

@interface WCPaymentProductsConverterTestCase : XCTestCase

@property (strong, nonatomic) WCBasicPaymentProductsConverter *converter;

@end

@implementation WCPaymentProductsConverterTestCase

- (void)setUp
{
    [super setUp];
    self.converter = [[WCBasicPaymentProductsConverter alloc] init];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testPaymentProductsFromJSON
{
    NSString *paymentProductsPath = [[NSBundle bundleForClass:[self class]] pathForResource:@"paymentProducts" ofType:@"json"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSData *paymentProductsData = [fileManager contentsAtPath:paymentProductsPath];
    NSDictionary *paymentProductsJSON = [NSJSONSerialization JSONObjectWithData:paymentProductsData options:0 error:NULL];
    WCBasicPaymentProducts *paymentProducts = [self.converter paymentProductsFromJSON:[paymentProductsJSON objectForKey:@"paymentProducts"]];
    if (paymentProducts.paymentProducts.count != 24) {
        XCTFail(@"Wrong number of payment products.");
    }
    for (WCBasicPaymentProduct *product in paymentProducts.paymentProducts) {
        XCTAssertNotNil(product.identifier, @"Payment product has no identifier");
        XCTAssertFalse(product.autoTokenized, @"Product's autoTokenized property is not false");
        XCTAssertNotNil(product.displayHints, @"Payment product has no displayHints");
        XCTAssertNotNil(product.displayHints.logoPath, @"Payment product has no logo path in displayHints");
        if (product.accountsOnFile != nil) {
            for (WCAccountOnFile *accountOnFile in product.accountsOnFile.accountsOnFile) {
                XCTAssertNotNil(accountOnFile.attributes, @"Account on file has no attributes");
                XCTAssertNotNil(accountOnFile.displayHints, @"Account on file has no displayHints");
            }
        }
    }
}

@end
