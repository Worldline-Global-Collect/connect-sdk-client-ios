//
//  WCValidator.h
//  WorldlineConnectSDK
//
//  Created for Worldline Global Collect on 15/12/2016.
//  Copyright © 2017 Worldline Global Collect. All rights reserved.
//

#import <Foundation/Foundation.h>
@class WCPaymentRequest;

@interface WCValidator : NSObject

@property (strong, nonatomic) NSMutableArray *errors;

- (void)validate:(NSString *)value forPaymentRequest:(WCPaymentRequest *)request;

@end
