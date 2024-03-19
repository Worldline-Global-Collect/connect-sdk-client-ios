//
//  WCPaymentItems.m
//  WorldlineConnectSDK
//
//  Created for Worldline Global Collect on 15/12/2016.
//  Copyright © 2017 Worldline Global Collect. All rights reserved.
//

#import  "WCPaymentItems.h"
#import  "WCBasicPaymentItem.h"
#import  "WCStringFormatter.h"
#import  "WCPaymentItemDisplayHints.h"
#import  "WCAccountsOnFile.h"
#import  "WCBasicPaymentProductGroups.h"
#import  "WCBasicPaymentProducts.h"
#import  "WCPaymentProductGroup.h"

@interface WCPaymentItems ()

@property (strong, nonatomic) WCStringFormatter *stringFormatter;
@property (nonatomic, strong) NSArray *allPaymentItems;

@end

@implementation WCPaymentItems

- (instancetype)init
{
    self = [super init];
    if (self != nil) {
        self.paymentItems = [[NSMutableArray alloc] init];
        self.allPaymentItems = [[NSMutableArray alloc] init];
    }
    return self;
}

-(instancetype)initWithPaymentProducts:(WCBasicPaymentProducts *)products groups:(WCBasicPaymentProductGroups *)groups {
    self = [self init];
    if (self != nil) {
        self.paymentItems = [NSMutableArray arrayWithArray:[self createPaymentItemsFromProducts:products groups:groups]];
        if (groups != nil) {
            self.allPaymentItems = [products.paymentProducts arrayByAddingObjectsFromArray:groups.paymentProductGroups];
        } else {
            self.allPaymentItems = products.paymentProducts;
        }

    }
    return self;
}

-(NSArray *)createPaymentItemsFromProducts:(WCBasicPaymentProducts *)products groups:(WCBasicPaymentProductGroups *)groups {
    NSMutableArray *paymentItems = [NSMutableArray new];

    for (WCBasicPaymentProduct *product in products.paymentProducts) {
        BOOL groupMatch = NO;

        //Check if the product belongs to a group
        if (product.paymentProductGroup != nil) {
            for (WCPaymentProductGroup *group in groups.paymentProductGroups) {
                if ([product.paymentProductGroup isEqualToString:group.identifier] && ![paymentItems containsObject:group]) {
                    group.displayHints.displayOrder = product.displayHints.displayOrder;
                    [paymentItems addObject:group];
                }

                groupMatch = YES;
                break;
            }
        }
        if (!groupMatch) {
            [paymentItems addObject:product];
        }
    }

    return [NSArray arrayWithArray:paymentItems];
}

- (BOOL)hasAccountsOnFile
{
    for (NSObject<WCBasicPaymentItem> *paymentItem in self.paymentItems) {
        if (paymentItem.accountsOnFile.accountsOnFile.count > 0) {
            return YES;
        }
    }
    return NO;
}

- (NSArray *)accountsOnFile
{
    NSMutableArray *accountsOnFile = [[NSMutableArray alloc] init];
    for (NSObject<WCBasicPaymentItem> *paymentItem in self.paymentItems) {
        [accountsOnFile addObjectsFromArray:paymentItem.accountsOnFile.accountsOnFile];
    }
    return accountsOnFile;
}

- (NSString *)logoPathForPaymentItem:(NSString *)paymentItemIdentifier
{
    NSObject<WCBasicPaymentItem> *paymentItem = [self paymentItemWithIdentifier:paymentItemIdentifier];
    return paymentItem.displayHints.logoPath;
}

- (NSObject<WCBasicPaymentItem> *)paymentItemWithIdentifier:(NSString *)paymentItemIdentifier
{
    for (NSObject<WCBasicPaymentItem> *paymentItem in self.allPaymentItems) {
        if ([paymentItem.identifier isEqualToString:paymentItemIdentifier] == YES) {
            return paymentItem;
        }
    }
    return nil;
}

- (void)sort
{
    [self.paymentItems sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        NSObject<WCBasicPaymentItem> *paymentItem1 = (NSObject<WCBasicPaymentItem> *)obj1;
        NSObject<WCBasicPaymentItem> *paymentItem2 = (NSObject<WCBasicPaymentItem> *)obj2;

        if (paymentItem1.displayHints.displayOrder > paymentItem2.displayHints.displayOrder) {
            return NSOrderedDescending;
        }
        if (paymentItem1.displayHints.displayOrder < paymentItem2.displayHints.displayOrder) {
            return NSOrderedAscending;
        }
        return NSOrderedSame;
    }];
}

@end
