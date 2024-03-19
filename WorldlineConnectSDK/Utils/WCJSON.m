//
//  WCJSON.m
//  WorldlineConnectSDK
//
//  Created for Worldline Global Collect on 15/12/2016.
//  Copyright © 2017 Worldline Global Collect. All rights reserved.
//

#import  "WCJSON.h"
#import  "WCMacros.h"

@implementation WCJSON

- (NSString *)keyValueJSONFromDictionary:(NSDictionary *)dictionary
{
    NSArray *keyValuePairs = [self keyValuePairsFromDictionary:dictionary];
    NSError *error = nil;
    NSData *JSONAsData = [NSJSONSerialization dataWithJSONObject:keyValuePairs options:0 error:&error];
    
    NSString *JSON;
    if (error == nil) {
        JSON = [[NSString alloc] initWithData:JSONAsData encoding:NSUTF8StringEncoding];
    } else {
        DLog(@"Unable to create JSON data from dictionary.");
        JSON = @"";
    }
    return  JSON;
}

- (NSArray *)keyValuePairsFromDictionary:(NSDictionary *)dictionary
{
    NSMutableArray *keyValuePairs = [[NSMutableArray alloc] init];
    for (NSString *key in dictionary) {
        NSString *value = [dictionary objectForKey:key];
        NSDictionary *pair = @{@"key": key, @"value": value};
        [keyValuePairs addObject:pair];
    }
    return keyValuePairs;
}

@end
