//
//  WCPrivacyPolicyResponse.m
//  WorldlineConnectSDK
//
//  Created for Worldline Global Collect on 13/02/2024.
//  Copyright © 2024 Worldline Global Collect. All rights reserved.
//

#import "WCPrivacyPolicyResponse.h"

@implementation WCPrivacyPolicyResponse

- (instancetype)initWithHtmlContent:(NSString *)htmlContent {
    self = [super init];
    if (self) {
        _htmlContent = htmlContent;
    }
    
    return self;
}

@end
