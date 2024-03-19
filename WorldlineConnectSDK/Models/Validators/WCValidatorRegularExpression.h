//
//  WCValidatorRegularExpression.h
//  WorldlineConnectSDK
//
//  Created for Worldline Global Collect on 15/12/2016.
//  Copyright © 2017 Worldline Global Collect. All rights reserved.
//

#import  "WCValidator.h"

@interface WCValidatorRegularExpression : WCValidator

@property (strong, nonatomic, readonly) NSRegularExpression *regularExpression;

- (instancetype)initWithRegularExpression:(NSRegularExpression *)regularExpression;

@end
