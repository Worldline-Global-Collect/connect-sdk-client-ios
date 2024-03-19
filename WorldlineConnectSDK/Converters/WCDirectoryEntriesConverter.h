//
//  WCDirectoryEntriesConverter.h
//  WorldlineConnectSDK
//
//  Created for Worldline Global Collect on 15/12/2016.
//  Copyright © 2017 Worldline Global Collect. All rights reserved.
//

#import <Foundation/Foundation.h>

#import  "WCDirectoryEntries.h"

@interface WCDirectoryEntriesConverter : NSObject

- (WCDirectoryEntries *)directoryEntriesFromJSON:(NSArray *)rawDirectoryEntries;

@end
