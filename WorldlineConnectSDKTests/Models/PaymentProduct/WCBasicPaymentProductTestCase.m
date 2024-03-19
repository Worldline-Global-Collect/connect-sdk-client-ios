//
//  WCBasicPaymentProductTestCase.m
//  WorldlineConnectSDK
//
//  Created for Worldline Global Collect on 15/12/2016.
//  Copyright © 2017 Worldline Global Collect. All rights reserved.
//

#import <XCTest/XCTest.h>
#import  "WCBasicPaymentProduct.h"

@interface WCBasicPaymentProductTestCase : XCTestCase

@property (strong, nonatomic) WCBasicPaymentProduct *product;
@property (strong, nonatomic) WCAccountsOnFile *accountsOnFile;
@property (strong, nonatomic) WCAccountOnFile *account1;
@property (strong, nonatomic) WCAccountOnFile *account2;

@end

@implementation WCBasicPaymentProductTestCase

- (void)setUp
{
    [super setUp];
    self.product = [[WCBasicPaymentProduct alloc] init];
    self.accountsOnFile = [[WCAccountsOnFile alloc] init];
    self.account1 = [[WCAccountOnFile alloc] init];
    self.account1.identifier = @"1";
    self.account2 = [[WCAccountOnFile alloc] init];
    self.account2.identifier = @"2";
    [self.accountsOnFile.accountsOnFile addObject:self.account1];
    [self.accountsOnFile.accountsOnFile addObject:self.account2];
    self.product.accountsOnFile = self.accountsOnFile;
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testAccountOnFileWithIdentifier
{
    XCTAssertEqual([self.product accountOnFileWithIdentifier:@"1"], self.account1, @"Unexpected account on file retrieved");
}

@end
