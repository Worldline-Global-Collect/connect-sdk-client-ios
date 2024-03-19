//
//  WCPaymentProductConverterTestCase.m
//  WorldlineConnectSDK
//
//  Created for Worldline Global Collect on 15/12/2016.
//  Copyright © 2017 Worldline Global Collect. All rights reserved.
//

#import <XCTest/XCTest.h>
#import  "WCPaymentProductConverter.h"
#import  "WCValidator.h"
#import  "WCValidatorLength.h"
#import  "WCAccountOnFileAttribute.h"

@interface WCPaymentProductConverterTestCase : XCTestCase

@property (strong, nonatomic) WCPaymentProductConverter *converter;
@end

@implementation WCPaymentProductConverterTestCase

- (void)setUp
{
    [super setUp];
    self.converter = [[WCPaymentProductConverter alloc] init];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testPaymentProductFromJSON
{
    NSString *paymentProductPath = [[NSBundle bundleForClass:[self class]] pathForResource:@"paymentProduct" ofType:@"json"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSData *paymentProductData = [fileManager contentsAtPath:paymentProductPath];
    NSDictionary *paymentProductJSON = [NSJSONSerialization JSONObjectWithData:paymentProductData options:0 error:NULL];
    WCPaymentProduct *paymentProduct = [self.converter paymentProductFromJSON:paymentProductJSON];
    XCTAssertTrue(paymentProduct.fields.paymentProductFields.count == 3, @"Unexpected number of fields");
    WCPaymentProductField *field = paymentProduct.fields.paymentProductFields[0];
    XCTAssertTrue(field.dataRestrictions.isRequired == true, @"Unexpected value for 'isRequired'");
    XCTAssertTrue(field.displayHints.alwaysShow, @"Unexpected value for 'alwaysShow'");
    XCTAssertTrue(field.displayHints.displayOrder == 10, @"Unexpected value for 'displayOrder'");
    XCTAssertTrue(field.displayHints.obfuscate == false, @"Unexpected value for 'obfuscate'");
    XCTAssertTrue([field.identifier isEqualToString:@"cardNumber"] == YES, @"Unexpected identifier");
    XCTAssertTrue(field.dataRestrictions.validators.validators.count == 2, @"Unexpected number of validators");
    WCValidatorLength *validator = field.dataRestrictions.validators.validators[1];
    XCTAssertTrue(validator.maxLength == 19, @"Unexpected maximal length");
    WCAccountOnFile *accountOnFile = paymentProduct.accountsOnFile.accountsOnFile[0];
    XCTAssertTrue(accountOnFile.attributes.attributes.count == 4, @"Unexpected number of attributes of account on file");
    WCAccountOnFileAttribute *attribute = accountOnFile.attributes.attributes[0];
    XCTAssertTrue([attribute.key isEqualToString:@"cardholderName"], @"Unexpected key");
    XCTAssertTrue([attribute.value isEqualToString:@"Rob"], @"Unexpected value");
    XCTAssertTrue(attribute.status == WCMustWrite, @"Unexpected status");
    XCTAssertTrue([attribute.mustWriteReason isEqualToString:@"IN_THE_PAST"], @"Unexpected must-write reason");
    attribute = accountOnFile.attributes.attributes[1];
    XCTAssertTrue(attribute.mustWriteReason == nil, @"Must-write reason is not nil");
}

- (void)testPaymentProductWithMissingFieldsFromJSON
{
    NSString *paymentProductPath = [[NSBundle bundleForClass:[self class]] pathForResource:@"paymentProductMissingFields" ofType:@"json"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSData *paymentProductData = [fileManager contentsAtPath:paymentProductPath];
    NSDictionary *paymentProductJSON = [NSJSONSerialization JSONObjectWithData:paymentProductData options:0 error:NULL];
    WCPaymentProduct *paymentProduct = [self.converter paymentProductFromJSON:paymentProductJSON];
    XCTAssertTrue(paymentProduct.fields.paymentProductFields.count == 3, @"Unexpected number of fields");
    WCPaymentProductField *field = paymentProduct.fields.paymentProductFields[0];
    NSLog(@"Field: %@", field);
    XCTAssertTrue(field.dataRestrictions.isRequired == true, @"Unexpected value for 'isRequired'");
    XCTAssertTrue(field.displayHints.displayOrder == 10, @"Unexpected value for 'displayOrder'");
    XCTAssertTrue(field.displayHints.obfuscate == false, @"Unexpected value for 'obfuscate'");
    XCTAssertTrue([field.identifier isEqualToString:@"cardNumber"] == YES, @"Unexpected identifier");
    XCTAssertTrue(field.dataRestrictions.validators.validators.count == 2, @"Unexpected number of validators");
    WCValidatorLength *validator = field.dataRestrictions.validators.validators[1];
    XCTAssertTrue(validator.maxLength == 19, @"Unexpected maximal length");
}

@end
