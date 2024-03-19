//
//  WCValidatorEmailAddress.m
//  WorldlineConnectSDK
//
//  Created for Worldline Global Collect on 15/12/2016.
//  Copyright © 2017 Worldline Global Collect. All rights reserved.
//

#import  "WCValidatorEmailAddress.h"
#import  "WCValidationErrorEmailAddress.h"

@interface WCValidatorEmailAddress ()

@property (strong, nonatomic) NSRegularExpression *expression;

@end

@implementation WCValidatorEmailAddress

- (instancetype)init
{
    self = [super init];
    if (self != nil) {
        NSError *error = nil;
        NSString *regex = @"^[^@\\.]+(\\.[^@\\.]+)*@([^@\\.]+\\.)*[^@\\.]+\\.[^@\\.][^@\\.]+$";
        self.expression = [[NSRegularExpression alloc] initWithPattern:regex options:0 error:&error];
    }
    return self;
}

- (void)validate:(NSString *)value forPaymentRequest:(WCPaymentRequest *)request
{
    [super validate:value forPaymentRequest:request];
    NSInteger numberOfMatches = [self.expression numberOfMatchesInString:value options:0 range:NSMakeRange(0, value.length)];
    if (numberOfMatches != 1) {
        WCValidationErrorEmailAddress *error = [[WCValidationErrorEmailAddress alloc] init];
        [self.errors addObject:error];
    }
}

@end
