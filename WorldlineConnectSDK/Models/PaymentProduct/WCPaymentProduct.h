//
//  WCPaymentProduct.h
//  WorldlineConnectSDK
//
//  Created for Worldline Global Collect on 15/12/2016.
//  Copyright © 2017 Worldline Global Collect. All rights reserved.
//

#import  "WCBasicPaymentProduct.h"
#import  "WCPaymentProductFields.h"
#import  "WCPaymentProductField.h"

@interface WCPaymentProduct : WCBasicPaymentProduct <WCPaymentItem>

@property (strong, nonatomic) WCPaymentProductFields *fields;
@property (nonatomic) NSString *fieldsWarning;

- (WCPaymentProductField *)paymentProductFieldWithId:(NSString *)paymentProductFieldId;

@end
