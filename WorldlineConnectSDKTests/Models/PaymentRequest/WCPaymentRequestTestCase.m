//
//  WCPaymentRequestTestCase.m
//  WorldlineConnectSDK
//
//  Created for Worldline Global Collect on 15/12/2016.
//  Copyright © 2017 Worldline Global Collect. All rights reserved.
//

#import <XCTest/XCTest.h>
#import  "WCPaymentRequest.h"
#import  "WCPaymentProductConverter.h"

@interface WCPaymentRequestTestCase : XCTestCase

@property (strong, nonatomic) WCPaymentRequest *request;
@property (strong, nonatomic) WCPaymentProductConverter *converter;
@end

@implementation WCPaymentRequestTestCase

- (void)setUp
{
    [super setUp];
    self.request = [[WCPaymentRequest alloc] init];
    self.converter = [[WCPaymentProductConverter alloc] init];
    NSString *paymentProductPath = [[NSBundle bundleForClass:[self class]] pathForResource:@"paymentProduct" ofType:@"json"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSData *paymentProductData = [fileManager contentsAtPath:paymentProductPath];
    NSDictionary *paymentProductJSON = [NSJSONSerialization JSONObjectWithData:paymentProductData options:0 error:NULL];
    WCPaymentProduct *paymentProduct = [self.converter paymentProductFromJSON:paymentProductJSON];
    self.request.paymentProduct = paymentProduct;
    self.request.accountOnFile = paymentProduct.accountsOnFile.accountsOnFile[0];
    
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testValidate
{
    [self.request setValue:@"1" forField:@"cvv"];
    [self.request validate];
    XCTAssertTrue(self.request.errors.count == 2, @"Unexpected number of errors while validating payment request");
}

- (void)testUnmaskedFieldValues
{
    [self.request setValue:@"123" forField:@"cvv"];
    NSDictionary *values = [self.request unmaskedFieldValues];
    NSString *cvv = [values valueForKey:@"cvv"];
    XCTAssertTrue([cvv isEqualToString:@"123"] == YES, @"CVV code is incorrect");
}

@end
