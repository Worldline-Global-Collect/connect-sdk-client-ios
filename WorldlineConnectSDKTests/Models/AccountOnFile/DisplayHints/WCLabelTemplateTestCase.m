//
//  WCLabelTemplateTestCase.m
//  WorldlineConnectSDK
//
//  Created for Worldline Global Collect on 15/12/2016.
//  Copyright © 2017 Worldline Global Collect. All rights reserved.
//

#import <XCTest/XCTest.h>
#import  "WCLabelTemplate.h"
#import  "WCLabelTemplateItem.h"

@interface WCLabelTemplateTestCase : XCTestCase

@property (strong, nonatomic) WCLabelTemplate *template;

@end

@implementation WCLabelTemplateTestCase

- (void)setUp
{
    [super setUp];
    self.template = [[WCLabelTemplate alloc] init];
    WCLabelTemplateItem *item1 = [[WCLabelTemplateItem alloc] init];
    item1.attributeKey = @"key1";
    item1.mask = @"mask1";
    WCLabelTemplateItem *item2 = [[WCLabelTemplateItem alloc] init];
    item2.attributeKey = @"key2";
    item2.mask = @"mask2";
    [self.template.labelTemplateItems addObject:item1];
    [self.template.labelTemplateItems addObject:item2];
    
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testMaskForAttributeKey
{
    NSString *mask = [self.template maskForAttributeKey:@"key1"];
    XCTAssertTrue([mask isEqualToString:@"mask1"] == YES, @"Unexpected mask encountered");
}

@end
