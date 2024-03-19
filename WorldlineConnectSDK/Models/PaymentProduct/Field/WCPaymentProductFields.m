//
//  WCPaymentProductFields.m
//  WorldlineConnectSDK
//
//  Created for Worldline Global Collect on 15/12/2016.
//  Copyright © 2017 Worldline Global Collect. All rights reserved.
//

#import  "WCPaymentProductFields.h"
#import  "WCPaymentProductField.h"

@implementation WCPaymentProductFields

- (instancetype)init
{
    self = [super init];
    if (self != nil) {
        self.paymentProductFields = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)sort
{
    [self.paymentProductFields sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        WCPaymentProductField *field1 = (WCPaymentProductField *)obj1;
        WCPaymentProductField *field2 = (WCPaymentProductField *)obj2;
        if (field1.displayHints.displayOrder > field2.displayHints.displayOrder) {
            return NSOrderedDescending;
        }
        if (field1.displayHints.displayOrder < field2.displayHints.displayOrder) {
            return NSOrderedAscending;
        }
        return NSOrderedSame;
    }];
}

@end
