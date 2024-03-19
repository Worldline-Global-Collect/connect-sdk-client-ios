//
//  WCAccountOnFileAttribute.h
//  WorldlineConnectSDK
//
//  Created for Worldline Global Collect on 15/12/2016.
//  Copyright © 2017 Worldline Global Collect. All rights reserved.
//

#import <Foundation/Foundation.h>
#import  "WCAccountOnFileAttributeStatus.h"

@interface WCAccountOnFileAttribute : NSObject

@property (strong, nonatomic) NSString *key;
@property (strong, nonatomic) NSString *value;
@property (strong, nonatomic) NSString *formattedValue;
@property (nonatomic) WCAccountOnFileAttributeStatus status;
@property (nonatomic) NSString *mustWriteReason;

@end
