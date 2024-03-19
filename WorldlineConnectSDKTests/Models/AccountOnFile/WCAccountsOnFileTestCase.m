//
//  WCAccountsOnFileTestCase.m
//  WorldlineConnectSDK
//
//  Created for Worldline Global Collect on 15/12/2016.
//  Copyright © 2017 Worldline Global Collect. All rights reserved.
//

#import <XCTest/XCTest.h>
#import  "WCAccountsOnFile.h"
#import  "WCAccountOnFile.h"

@interface WCAccountsOnFileTestCase : XCTestCase

@property (strong, nonatomic) WCAccountsOnFile *accountsOnFile;
@property (strong, nonatomic) WCAccountOnFile *account1;
@property (strong, nonatomic) WCAccountOnFile *account2;

@end

@implementation WCAccountsOnFileTestCase

- (void)setUp
{
    [super setUp];
    self.accountsOnFile = [[WCAccountsOnFile alloc] init];
    self.account1 = [[WCAccountOnFile alloc] init];
    self.account1.identifier = @"1";
    self.account2 = [[WCAccountOnFile alloc] init];
    self.account2.identifier = @"2";
    [self.accountsOnFile.accountsOnFile addObject:self.account1];
    [self.accountsOnFile.accountsOnFile addObject:self.account2];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testAccountOnFileWithIdentifier
{
    XCTAssertEqual([self.accountsOnFile accountOnFileWithIdentifier:@"1"], self.account1, @"Incorrect account on file retrieved");
}

@end
