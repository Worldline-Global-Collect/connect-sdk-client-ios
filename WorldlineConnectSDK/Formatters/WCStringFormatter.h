//
//  WCStringFormatter.h
//  WorldlineConnectSDK
//
//  Created for Worldline Global Collect on 15/12/2016.
//  Copyright © 2017 Worldline Global Collect. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WCStringFormatter : NSObject

- (NSString *)formatString:(NSString *)string withMask:(NSString *)mask cursorPosition:(NSInteger *)cursorPosition;
- (NSString *)formatString:(NSString *)string withMask:(NSString *)mask;
- (NSString *)unformatString:(NSString *)string withMask:(NSString *)mask;
- (NSString *)relaxMask:(NSString *)mask;

@end
