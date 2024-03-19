//
//  WCAccountsOnFile.m
//  WorldlineConnectSDK
//
//  Created for Worldline Global Collect on 15/12/2016.
//  Copyright © 2017 Worldline Global Collect. All rights reserved.
//

#import  "WCAccountsOnFile.h"

@implementation WCAccountsOnFile

- (instancetype)init
{
    self = [super init];
    if (self != nil) {
        self.accountsOnFile = [[NSMutableArray alloc] init];
    }
    return self;
}

- (WCAccountOnFile *)accountOnFileWithIdentifier:(NSString *)accountOnFileIdentifier
{
    for (WCAccountOnFile *accountOnFile in self.accountsOnFile) {
        if ([accountOnFile.identifier isEqualToString:accountOnFileIdentifier] == YES) {
            return accountOnFile;
        }
    }
    return nil;
}

@end
