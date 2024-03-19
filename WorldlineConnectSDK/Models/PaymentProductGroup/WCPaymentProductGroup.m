//
//  WCPaymentProductGroup.m
//  WorldlineConnectSDK
//
//  Created for Worldline Global Collect on 15/12/2016.
//  Copyright © 2017 Worldline Global Collect. All rights reserved.
//

#import  "WCPaymentProductGroup.h"
#import  "WCPaymentItemDisplayHints.h"
#import  "WCAccountsOnFile.h"
#import  "WCPaymentProductField.h"
#import  "WCPaymentProductFields.h"

@implementation WCPaymentProductGroup {

}

- (instancetype)init
{
    self = [super init];
    if (self != nil) {
        self.displayHints = [[WCPaymentItemDisplayHints alloc] init];
        self.accountsOnFile = [[WCAccountsOnFile alloc] init];
        self.fields = [WCPaymentProductFields new];
    }
    return self;
}

- (WCAccountOnFile *)accountOnFileWithIdentifier:(NSString *)accountOnFileIdentifier
{
    return [self.accountsOnFile accountOnFileWithIdentifier:accountOnFileIdentifier];
}

- (void)setStringFormatter:(WCStringFormatter *)stringFormatter
{
    for (WCAccountOnFile *accountOnFile in self.accountsOnFile.accountsOnFile) {
        accountOnFile.stringFormatter = stringFormatter;
    }
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
