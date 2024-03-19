//
//  WCAccountsOnFile.h
//  WorldlineConnectSDK
//
//  Created for Worldline Global Collect on 15/12/2016.
//  Copyright © 2017 Worldline Global Collect. All rights reserved.
//

#import <Foundation/Foundation.h>

#import  "WCAccountOnFile.h"

@interface WCAccountsOnFile : NSObject

@property (strong, nonatomic) NSMutableArray *accountsOnFile;

- (WCAccountOnFile *)accountOnFileWithIdentifier:(NSString *)accountOnFileIdentifier;

@end
