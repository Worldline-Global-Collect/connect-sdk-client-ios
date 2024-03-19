//
//  DisplayElementsConverter.m
//  Pods
//
//  Created for Worldline Global Collect on 19/07/2017.
//
//

#import "WCDisplayElementsConverter.h"
#import "WCDisplayElement.h"
@implementation WCDisplayElementsConverter
// TODO type
-(NSArray<WCDisplayElement *> *)displayElementsFromJSON:(NSArray *)json
{
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    for (NSDictionary *dict in json)
    {
        [arr addObject:[self displayElementFromJSON:dict]];
    }
    return arr;
}
-(WCDisplayElement *)displayElementFromJSON:(NSDictionary *)dict
{
    WCDisplayElement *element = [[WCDisplayElement alloc]init];
    element.identifier = dict[@"id"];
    element.value = dict[@"value"];
    NSString *elementType = dict[@"type"];
    if ([elementType isEqualToString:@"STRING"]) {
        element.type = WCDisplayElementTypeString;
    }
    else if ([elementType isEqualToString:@"CURRENCY"])
    {
        element.type = WCDisplayElementTypeCurrency;

    }
    else if ([elementType isEqualToString:@"PERCENTAGE"])
    {
        element.type = WCDisplayElementTypePercentage;

    }
    else if ([elementType isEqualToString:@"URI"])
    {
        element.type = WCDisplayElementTypeURI;

    }
    else if ([elementType isEqualToString:@"INTEGER"])
    {
        element.type = WCDisplayElementTypeInteger;

    }

    return element;
    
}
@end
