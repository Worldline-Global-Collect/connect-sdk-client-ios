//
//  WCDirectoryEntries.m
//  WorldlineConnectSDK
//
//  Created for Worldline Global Collect on 15/12/2016.
//  Copyright © 2017 Worldline Global Collect. All rights reserved.
//

#import  "WCDirectoryEntries.h"

@implementation WCDirectoryEntries

- (instancetype)init
{
    self = [super init];
    if (self != nil) {
        self.directoryEntries = [[NSMutableArray alloc] init];
    }
    return self;
}

@end
