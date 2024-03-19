//
//  WCValueMappingItem.h
//  WorldlineConnectSDK
//
//  Created for Worldline Global Collect on 15/12/2016.
//  Copyright © 2017 Worldline Global Collect. All rights reserved.
//

#import <Foundation/Foundation.h>
@class WCDisplayElement;
@interface WCValueMappingItem : NSObject

@property (strong, nonatomic) NSString *displayName;
@property (strong, nonatomic) NSArray<WCDisplayElement *>* displayElements;
@property (strong, nonatomic) NSString *value;

@end
