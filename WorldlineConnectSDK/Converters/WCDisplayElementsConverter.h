//
//  DisplayElementsConverter.h
//  Pods
//
//  Created for Worldline Global Collect on 19/07/2017.
//
//

#import <Foundation/Foundation.h>
@class WCDisplayElement;
@interface WCDisplayElementsConverter : NSObject
-(WCDisplayElement *)displayElementFromJSON:(NSDictionary *)json;
-(NSArray<WCDisplayElement *> *)displayElementsFromJSON:(NSArray *)json;
@end
