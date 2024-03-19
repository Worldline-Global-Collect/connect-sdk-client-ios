//
//  WCAccountOnFileAttributes.h
//  WorldlineConnectSDK
//
//  Created for Worldline Global Collect on 15/12/2016.
//  Copyright © 2017 Worldline Global Collect. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WCAccountOnFileAttributes : NSObject

@property (strong, nonatomic) NSMutableArray *attributes;

- (NSString *)valueForField:(NSString *)paymentProductFieldId;
- (BOOL)hasValueForField:(NSString *)paymentProductFieldId;
- (BOOL)fieldIsReadOnly:(NSString *)paymentProductFieldId;

@end
