//
//  WCPreparedPaymentRequest.h
//  WorldlineConnectSDK
//
//  Created for Worldline Global Collect on 15/12/2016.
//  Copyright © 2017 Worldline Global Collect. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WCPreparedPaymentRequest : NSObject

@property (strong, nonatomic) NSString *encryptedFields;
@property (strong, nonatomic) NSString *encodedClientMetaInfo;
           
@end
