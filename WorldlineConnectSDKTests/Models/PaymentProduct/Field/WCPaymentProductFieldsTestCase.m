//
//  WCPaymentProductFieldsTestCase.m
//  WorldlineConnectSDK
//
//  Created for Worldline Global Collect on 15/12/2016.
//  Copyright © 2017 Worldline Global Collect. All rights reserved.
//

#import <XCTest/XCTest.h>
#import  "WCPaymentPRoductFields.h"
#import  "WCPaymentProductField.h"

@interface WCPaymentProductFieldsTestCase : XCTestCase

@property (strong, nonatomic) WCPaymentProductFields *fields;

@end

@implementation WCPaymentProductFieldsTestCase

- (void)setUp
{
    [super setUp];
    self.fields = [[WCPaymentProductFields alloc] init];
    WCPaymentProductField *field1 = [[WCPaymentProductField alloc] init];
    field1.displayHints.displayOrder = 1;
    WCPaymentProductField *field2 = [[WCPaymentProductField alloc] init];
    field2.displayHints.displayOrder = 100;
    WCPaymentProductField *field3 = [[WCPaymentProductField alloc] init];
    field3.displayHints.displayOrder = 4;
    WCPaymentProductField *field4 = [[WCPaymentProductField alloc] init];
    field4.displayHints.displayOrder = 50;
    WCPaymentProductField *field5 = [[WCPaymentProductField alloc] init];
    field5.displayHints.displayOrder = 3;
    [self.fields.paymentProductFields addObject:field1];
    [self.fields.paymentProductFields addObject:field2];
    [self.fields.paymentProductFields addObject:field3];
    [self.fields.paymentProductFields addObject:field4];
    [self.fields.paymentProductFields addObject:field5];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testSort
{
    [self.fields sort];
    NSInteger displayOrder = -1;
    for (WCPaymentProductField *field in self.fields.paymentProductFields) {
        if (displayOrder > field.displayHints.displayOrder) {
            XCTFail(@"Fields not sorted according to display order");
        }
        displayOrder = field.displayHints.displayOrder;
    }
}

@end
