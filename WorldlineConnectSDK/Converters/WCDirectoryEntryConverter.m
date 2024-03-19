//
//  WCDirectoryEntryConverter.m
//  WorldlineConnectSDK
//
//  Created for Worldline Global Collect on 15/12/2016.
//  Copyright © 2017 Worldline Global Collect. All rights reserved.
//

#import  "WCDirectoryEntryConverter.h"

@implementation WCDirectoryEntryConverter

- (WCDirectoryEntry *)directoryEntryFromJSON:(NSDictionary *)rawDirectoryEntry
{
    WCDirectoryEntry *entry = [[WCDirectoryEntry alloc] init];
    [entry.countryNames addObjectsFromArray:[rawDirectoryEntry objectForKey:@"countryNames"]];
    entry.issuerIdentifier = [rawDirectoryEntry objectForKey:@"issuerId"];
    entry.issuerList = [rawDirectoryEntry objectForKey:@"issuerList"];
    entry.issuerName = [rawDirectoryEntry objectForKey:@"issuerName"];
    return entry;
}

@end
