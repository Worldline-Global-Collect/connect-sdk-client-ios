//
//  WCBasicPaymentProduct.m
//  WorldlineConnectSDK
//
//  Created for Worldline Global Collect on 15/12/2016.
//  Copyright © 2017 Worldline Global Collect. All rights reserved.
//

#import  "WCBasicPaymentProduct.h"

@interface WCBasicPaymentProduct ()

@property (strong, nonatomic) WCStringFormatter *stringFormatter;

@end

@implementation WCBasicPaymentProduct

- (instancetype)init
{
    self = [super init];
    if (self != nil) {
        self.displayHints = [[WCPaymentItemDisplayHints alloc] init];
        self.accountsOnFile = [[WCAccountsOnFile alloc] init];
        self.authenticationIndicator = [[WCAuthenticationIndicator alloc] init];
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
