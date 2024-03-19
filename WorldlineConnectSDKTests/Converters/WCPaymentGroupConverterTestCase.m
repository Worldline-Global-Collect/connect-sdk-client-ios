//
//  WCPaymentGroupConverterTestCase.m
//  WorldlineConnectSDK
//
//  Created for Worldline Global Collect on 15/12/2016.
//  Copyright © 2017 Worldline Global Collect. All rights reserved.
//

#import <XCTest/XCTest.h>
#import  "WCPaymentProductGroup.h"
#import  "WCPaymentProductGroupConverter.h"
#import  "WCPaymentProductFields.h"
#import  "WCPaymentProductField.h"

@interface WCPaymentGroupConverterTestCase : XCTestCase

@property (strong, nonatomic) WCPaymentProductGroupConverter *converter;

@end

@implementation WCPaymentGroupConverterTestCase

- (void)setUp {
    [super setUp];
    self.converter = [WCPaymentProductGroupConverter new];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testPaymentProductGroupFromJSON
{
    NSString *paymentProductGroupPath = [[NSBundle bundleForClass:[self class]] pathForResource:@"paymentProductGroup" ofType:@"json"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSData *paymentProductGroupData = [fileManager contentsAtPath:paymentProductGroupPath];
    NSDictionary *paymentProductGroupJSON = [NSJSONSerialization JSONObjectWithData:paymentProductGroupData options:0 error:NULL];
    WCPaymentProductGroup *paymentProductGroup = [self.converter paymentProductGroupFromJSON:paymentProductGroupJSON];
    XCTAssertTrue(paymentProductGroup.fields.paymentProductFields.count == 3, @"Unexpected number of fields");
    WCPaymentProductField *field = paymentProductGroup.fields.paymentProductFields[0];
    XCTAssertTrue(field.dataRestrictions.isRequired == true, @"Unexpected value for 'isRequired'");
    XCTAssertFalse(field.displayHints.alwaysShow, @"Unexpected value for 'alwaysShow'");
    XCTAssertTrue(field.displayHints.displayOrder == 0, @"Unexpected value for 'displayOrder'");
    XCTAssertTrue(field.displayHints.obfuscate == false, @"Unexpected value for 'obfuscate'");
    XCTAssertTrue([field.identifier isEqualToString:@"cardNumber"] == YES, @"Unexpected identifier");
    XCTAssertTrue(field.dataRestrictions.validators.validators.count == 0, @"Unexpected number of validators");
}

@end
