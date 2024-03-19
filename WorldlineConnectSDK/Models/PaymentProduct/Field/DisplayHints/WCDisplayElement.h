//
//  WCDisplayElement.h
//  Pods
//
//  Created for Worldline Global Collect on 19/07/2017.
//
//

#import <Foundation/Foundation.h>
#import "WCDisplayElementType.h"
@interface WCDisplayElement : NSObject
@property (nonatomic, retain) NSString *identifier;
@property (nonatomic, assign) WCDisplayElementType type;
@property (nonatomic, retain) NSString *value;
@end
