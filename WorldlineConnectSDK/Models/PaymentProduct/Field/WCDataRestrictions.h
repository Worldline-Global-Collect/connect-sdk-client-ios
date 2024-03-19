//
//  WCDataRestrictions.h
//  WorldlineConnectSDK
//
//  Created for Worldline Global Collect on 15/12/2016.
//  Copyright © 2017 Worldline Global Collect. All rights reserved.
//

#import <Foundation/Foundation.h>

#import  "WCValidators.h"

@interface WCDataRestrictions : NSObject

@property (nonatomic) BOOL isRequired;
@property (strong, nonatomic) WCValidators *validators;

@end
