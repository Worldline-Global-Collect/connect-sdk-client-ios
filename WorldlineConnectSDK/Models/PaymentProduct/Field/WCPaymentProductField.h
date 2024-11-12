//
//  WCPaymentProductField.h
//  WorldlineConnectSDK
//
//  Created for Worldline Global Collect on 15/12/2016.
//  Copyright © 2017 Worldline Global Collect. All rights reserved.
//

#import <Foundation/Foundation.h>

#import  "WCPaymentProductFieldDisplayHints.h"
#import  "WCDataRestrictions.h"
#import  "WCFieldType.h"

@class WCPaymentRequest;

@interface WCPaymentProductField : NSObject

@property (strong, nonatomic) WCDataRestrictions *dataRestrictions;
@property (strong, nonatomic) WCPaymentProductFieldDisplayHints *displayHints;
@property (strong, nonatomic) NSString *identifier;
@property (assign, nonatomic) BOOL usedForLookup;
@property (nonatomic) WCFieldType type;
@property (strong, nonatomic) NSMutableArray *errors;

- (void)validateValue:(NSString *)value forPaymentRequest:(WCPaymentRequest *)request;

@end
