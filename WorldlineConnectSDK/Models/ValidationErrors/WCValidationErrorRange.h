//
//  WCValidationErrorRange.h
//  WorldlineConnectSDK
//
//  Created for Worldline Global Collect on 15/12/2016.
//  Copyright © 2017 Worldline Global Collect. All rights reserved.
//

#import  "WCValidationError.h"

@interface WCValidationErrorRange : WCValidationError

@property (nonatomic) NSInteger minValue;
@property (nonatomic) NSInteger maxValue;

@end
