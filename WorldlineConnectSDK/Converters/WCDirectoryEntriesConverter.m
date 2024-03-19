//
//  WCDirectoryEntriesConverter.m
//  WorldlineConnectSDK
//
//  Created for Worldline Global Collect on 15/12/2016.
//  Copyright © 2017 Worldline Global Collect. All rights reserved.
//

#import  "WCDirectoryEntriesConverter.h"
#import  "WCDirectoryEntryConverter.h"

@implementation WCDirectoryEntriesConverter

- (WCDirectoryEntries *)directoryEntriesFromJSON:(NSArray *)rawDirectoryEntries {
    WCDirectoryEntries *entries = [[WCDirectoryEntries alloc] init];
    WCDirectoryEntryConverter *converter = [[WCDirectoryEntryConverter alloc] init];
    for (NSDictionary *rawEntry in rawDirectoryEntries) {
        WCDirectoryEntry *entry = [converter directoryEntryFromJSON:rawEntry];
        [entries.directoryEntries addObject:entry];
    }
    return entries;
}

@end
