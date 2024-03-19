//
//  WCIINDetail.h
//  WorldlineConnectSDK
//
//  Created for Worldline Global Collect on 15/12/2016.
//  Copyright © 2017 Worldline Global Collect. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WCIINDetail : NSObject

@property (strong, nonatomic, readonly) NSString *paymentProductId;
@property (assign, nonatomic, readonly, getter=isAllowedInContext) BOOL allowedInContext;

- (instancetype)initWithPaymentProductId:(NSString *)paymentProductId allowedInContext:(BOOL)allowedInContext;

@end
