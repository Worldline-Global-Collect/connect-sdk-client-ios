//
//  WCBasicPaymentProductGroup.m
//  WorldlineConnectSDK
//
//  Created for Worldline Global Collect on 15/12/2016.
//  Copyright © 2017 Worldline Global Collect. All rights reserved.
//

#import  "WCBasicPaymentProductGroup.h"
#import  "WCPaymentItemDisplayHints.h"
#import  "WCAccountsOnFile.h"

@implementation WCBasicPaymentProductGroup {

}

- (instancetype)init
{
    self = [super init];
    if (self != nil) {
        self.displayHints = [[WCPaymentItemDisplayHints alloc] init];
        self.accountsOnFile = [[WCAccountsOnFile alloc] init];
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

@end
