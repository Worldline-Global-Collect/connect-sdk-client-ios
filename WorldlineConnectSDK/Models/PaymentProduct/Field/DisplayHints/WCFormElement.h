//
//  WCFormElement.h
//  WorldlineConnectSDK
//
//  Created for Worldline Global Collect on 15/12/2016.
//  Copyright © 2017 Worldline Global Collect. All rights reserved.
//

#import <Foundation/Foundation.h>

#import  "WCFormElementType.h"

@interface WCFormElement : NSObject

@property (nonatomic) WCFormElementType type;
@property (strong, nonatomic) NSMutableArray *valueMapping;

@end
