//
//  WCPaymentProductTestCase.m
//  WorldlineConnectSDK
//
//  Created for Worldline Global Collect on 15/12/2016.
//  Copyright © 2017 Worldline Global Collect. All rights reserved.
//

#import <XCTest/XCTest.h>
#import  "WCPaymentProduct.h"

@interface WCPaymentProductTestCase : XCTestCase

@property (strong, nonatomic) WCPaymentProduct *paymentProduct;
@property (strong, nonatomic) WCPaymentProductField *field;

@end

@implementation WCPaymentProductTestCase

- (void)setUp
{
    [super setUp];
    self.paymentProduct = [[WCPaymentProduct alloc] init];
    self.field = [[WCPaymentProductField alloc] init];
    self.field.identifier = @"1";
    [self.paymentProduct.fields.paymentProductFields addObject:self.field];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testPaymentProductFieldWithIdExists
{
    WCPaymentProductField *field = [self.paymentProduct paymentProductFieldWithId:@"1"];
    XCTAssertEqual(field, self.field, @"Retrieved field is unequal to added field");
}

- (void)testPaymentProductFieldWithIdNil
{
    WCPaymentProductField *field = [self.paymentProduct paymentProductFieldWithId:@"X"];
    XCTAssertTrue(field == nil, @"Retrieved a field while no field should be returned");
}

@end
