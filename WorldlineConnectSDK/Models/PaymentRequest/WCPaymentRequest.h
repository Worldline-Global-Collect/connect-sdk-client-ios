//
//  WCPaymentRequest.h
//  WorldlineConnectSDK
//
//  Created for Worldline Global Collect on 15/12/2016.
//  Copyright © 2017 Worldline Global Collect. All rights reserved.
//

#import <Foundation/Foundation.h>

#import  "WCPaymentProduct.h"
#import  "WCPaymentRequest.h"

@interface WCPaymentRequest : NSObject

@property (strong, nonatomic) WCPaymentProduct *paymentProduct;
@property (strong, nonatomic) WCAccountOnFile *accountOnFile;
@property (strong, nonatomic) NSMutableArray *errors;
@property (nonatomic) BOOL tokenize;

- (void)setValue:(NSString *)value forField:(NSString *)paymentProductFieldId;
- (void)validate;
- (BOOL)fieldIsPartOfAccountOnFile:(NSString *)paymentProductFieldId;
- (BOOL)fieldIsReadOnly:(NSString *)paymentProductFieldId;
- (NSString *)maskedValueForField:(NSString *)paymentProductFieldId;
- (NSString *)maskedValueForField:(NSString *)paymentProductFieldId cursorPosition:(NSInteger *)cursorPosition;
- (NSString *)unmaskedValueForField:(NSString *)paymentProductFieldId;
- (NSDictionary *)unmaskedFieldValues;

@end
