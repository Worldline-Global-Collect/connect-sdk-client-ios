//
//  WCAccountOnFileAttributes.m
//  WorldlineConnectSDK
//
//  Created for Worldline Global Collect on 15/12/2016.
//  Copyright © 2017 Worldline Global Collect. All rights reserved.
//

#import  "WCAccountOnFileAttributes.h"
#import  "WCAccountOnFileAttribute.h"

@implementation WCAccountOnFileAttributes

- (instancetype)init
{
    self = [super init];
    if (self != nil) {
        self.attributes = [[NSMutableArray alloc] init];
    }
    return self;
}

- (NSString *)valueForField:(NSString *)paymentProductFieldId
{
    for (WCAccountOnFileAttribute *attribute in self.attributes) {
        if ([attribute.key isEqualToString:paymentProductFieldId] == YES) {
            return attribute.value;
        }
    }
    return @"";
}

- (BOOL)hasValueForField:(NSString *)paymentProductFieldId
{
    for (WCAccountOnFileAttribute *attribute in self.attributes) {
        if ([attribute.key isEqualToString:paymentProductFieldId] == YES) {
            return YES;
        }
    }
    return NO;
}

- (BOOL)fieldIsReadOnly:(NSString *)paymentProductFieldId
{
    for (WCAccountOnFileAttribute *attribute in self.attributes) {
        if ([attribute.key isEqualToString:paymentProductFieldId] == YES) {
            return attribute.status == WCReadOnly;
        }
    }
    return NO;
}

@end
