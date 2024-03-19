//
//  WCBasicPaymentProductGroups.m
//  WorldlineConnectSDK
//
//  Created for Worldline Global Collect on 15/12/2016.
//  Copyright © 2017 Worldline Global Collect. All rights reserved.
//

#import  "WCBasicPaymentProductGroups.h"
#import  "WCStringFormatter.h"
#import  "WCAccountsOnFile.h"
#import  "WCPaymentItemDisplayHints.h"
#import  "WCBasicPaymentProductGroup.h"

@interface WCBasicPaymentProductGroups ()

@property (strong, nonatomic) WCStringFormatter *stringFormatter;

@end

@implementation WCBasicPaymentProductGroups

- (instancetype)init
{
    self = [super init];
    if (self != nil) {
        self.paymentProductGroups = [[NSMutableArray alloc] init];
    }
    return self;
}

- (BOOL)hasAccountsOnFile
{
    for (WCBasicPaymentProductGroup *productGroup in self.paymentProductGroups) {
        if (productGroup.accountsOnFile.accountsOnFile.count > 0) {
            return YES;
        }
    }
    return NO;
}

- (NSArray *)accountsOnFile
{
    NSMutableArray *accountsOnFile = [[NSMutableArray alloc] init];
    for (WCBasicPaymentProductGroup *productGroup in self.paymentProductGroups) {
        [accountsOnFile addObjectsFromArray:productGroup.accountsOnFile.accountsOnFile];
    }
    return accountsOnFile;
}

- (NSString *)logoPathForPaymentProductGroup:(NSString *)paymentProductGroupIdentifier
{
    WCBasicPaymentProductGroup *productGroup = [self paymentProductGroupWithIdentifier:paymentProductGroupIdentifier];
    return productGroup.displayHints.logoPath;
}

- (WCBasicPaymentProductGroup *)paymentProductGroupWithIdentifier:(NSString *)paymentProductGroupIdentifier
{
    for (WCBasicPaymentProductGroup *productGroup in self.paymentProductGroups) {
        if ([productGroup.identifier isEqualToString:paymentProductGroupIdentifier] == YES) {
            return productGroup;
        }
    }
    return nil;
}

- (void)setStringFormatter:(WCStringFormatter *)stringFormatter
{
    for (WCBasicPaymentProductGroup *productGroup in self.paymentProductGroups) {
        [productGroup setStringFormatter:stringFormatter];
    }
}

- (void)sort
{
    [self.paymentProductGroups sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        WCBasicPaymentProductGroup *productGroup1 = (WCBasicPaymentProductGroup *)obj1;
        WCBasicPaymentProductGroup *productGroup2 = (WCBasicPaymentProductGroup *)obj2;

        if (productGroup1.displayHints.displayOrder > productGroup2.displayHints.displayOrder) {
            return NSOrderedDescending;
        }
        if (productGroup1.displayHints.displayOrder < productGroup2.displayHints.displayOrder) {
            return NSOrderedAscending;
        }
        return NSOrderedSame;
    }];
}

@end
