//
//  WCLabelTemplate.m
//  WorldlineConnectSDK
//
//  Created for Worldline Global Collect on 15/12/2016.
//  Copyright © 2017 Worldline Global Collect. All rights reserved.
//

#import  "WCLabelTemplate.h"
#import  "WCLabelTemplateItem.h"

@implementation WCLabelTemplate

- (instancetype)init
{
    self = [super init];
    if (self != nil) {
        self.labelTemplateItems = [[NSMutableArray alloc] init];
    }
    return self;
}

- (NSString *)maskForAttributeKey:(NSString *)key
{
    for (WCLabelTemplateItem *labelTemplateItem in self.labelTemplateItems) {
        if ([labelTemplateItem.attributeKey isEqualToString:key] == YES) {
            return labelTemplateItem.mask;
        }
    }
    return nil;
}

@end
