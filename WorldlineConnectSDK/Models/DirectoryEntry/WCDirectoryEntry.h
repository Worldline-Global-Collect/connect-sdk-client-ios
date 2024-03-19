//
//  WCDirectoryEntry.h
//  WorldlineConnectSDK
//
//  Created for Worldline Global Collect on 15/12/2016.
//  Copyright © 2017 Worldline Global Collect. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WCDirectoryEntry : NSObject

@property (strong, nonatomic) NSMutableArray *countryNames;
@property (strong, nonatomic) NSString *issuerIdentifier;
@property (strong, nonatomic) NSString *issuerList;
@property (strong, nonatomic) NSString *issuerName;

@end
