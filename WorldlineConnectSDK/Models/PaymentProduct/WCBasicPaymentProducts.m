//
//  WCBasicPaymentProducts.m
//  WorldlineConnectSDK
//
//  Created for Worldline Global Collect on 15/12/2016.
//  Copyright © 2017 Worldline Global Collect. All rights reserved.
//

#import  "WCBasicPaymentProducts.h"

@interface WCBasicPaymentProducts ()

@property (strong, nonatomic) WCStringFormatter *stringFormatter;

@end

@implementation WCBasicPaymentProducts

- (instancetype)init
{
    self = [super init];
    if (self != nil) {
        self.paymentProducts = [[NSMutableArray alloc] init];
    }
    return self;
}

- (BOOL)hasAccountsOnFile
{
    for (WCBasicPaymentProduct *product in self.paymentProducts) {
        if (product.accountsOnFile.accountsOnFile.count > 0) {
            return YES;
        }
    }
    return NO;
}

- (NSArray *)accountsOnFile
{
    NSMutableArray *accountsOnFile = [[NSMutableArray alloc] init];
    for (WCBasicPaymentProduct *product in self.paymentProducts) {
        [accountsOnFile addObjectsFromArray:product.accountsOnFile.accountsOnFile];
    }
    return accountsOnFile;
}

- (NSString *)logoPathForPaymentProduct:(NSString *)paymentProductIdentifier
{
    WCBasicPaymentProduct *product = [self paymentProductWithIdentifier:paymentProductIdentifier];
    return product.displayHints.logoPath;
}

- (WCBasicPaymentProduct *)paymentProductWithIdentifier:(NSString *)paymentProductIdentifier
{
    for (WCBasicPaymentProduct *product in self.paymentProducts) {
        if ([product.identifier isEqualToString:paymentProductIdentifier] == YES) {
            return product;
        }
    }
    return nil;
}

- (void)setStringFormatter:(WCStringFormatter *)stringFormatter
{
    for (WCBasicPaymentProduct *basicProduct in self.paymentProducts) {
        [basicProduct setStringFormatter:stringFormatter];
    }
}

- (void)sort
{
    [self.paymentProducts sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        WCBasicPaymentProduct *product1 = (WCBasicPaymentProduct *)obj1;
        WCBasicPaymentProduct *product2 = (WCBasicPaymentProduct *)obj2;
        
        if (product1.displayHints.displayOrder > product2.displayHints.displayOrder) {
            return NSOrderedDescending;
        }
        if (product1.displayHints.displayOrder < product2.displayHints.displayOrder) {
            return NSOrderedAscending;
        }
        return NSOrderedSame;
    }];
}

@end
