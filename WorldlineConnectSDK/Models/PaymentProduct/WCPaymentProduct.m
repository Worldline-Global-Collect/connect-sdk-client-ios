//
//  WCPaymentProduct.m
//  WorldlineConnectSDK
//
//  Created for Worldline Global Collect on 15/12/2016.
//  Copyright © 2017 Worldline Global Collect. All rights reserved.
//

#import  "WCPaymentProduct.h"

@implementation WCPaymentProduct

- (instancetype)init
{
    self = [super init];
    if (self != nil) {
        self.fields = [[WCPaymentProductFields alloc] init];
    }
    return self;
}

- (WCPaymentProductField *)paymentProductFieldWithId:(NSString *)paymentProductFieldId
{
    for (WCPaymentProductField *field in self.fields.paymentProductFields) {
        if ([field.identifier isEqualToString:paymentProductFieldId] == YES) {
            return field;
        }
    }
    return nil;
}

@end
