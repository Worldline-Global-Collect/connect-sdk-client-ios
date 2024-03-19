//
//  WCPrivacyPolicyResponse.h
//  WorldlineConnectSDK
//
//  Created for Worldline Global Collect on 13/02/2024.
//  Copyright © 2024 Worldline Global Collect. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WCPrivacyPolicyResponse : NSObject

@property (strong, nonatomic, readonly) NSString *htmlContent;

- (instancetype)initWithHtmlContent:(NSString *)htmlContent;

@end
