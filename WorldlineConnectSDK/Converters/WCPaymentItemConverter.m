//
//  WCPaymentItemConverter.m
//  WorldlineConnectSDK
//
//  Created for Worldline Global Collect on 15/12/2016.
//  Copyright © 2017 Worldline Global Collect. All rights reserved.
//

#import  "WCPaymentItemConverter.h"
#import  "WCPaymentItem.h"
#import  "WCPaymentProductFields.h"
#import  "WCPaymentProductField.h"
#import  "WCMacros.h"
#import  "WCValueMappingItem.h"
#import  "WCValidator.h"
#import  "WCValidatorLuhn.h"
#import  "WCValidatorExpirationDate.h"
#import  "WCValidatorEmailAddress.h"
#import  "WCValidatorRegularExpression.h"
#import  "WCValidatorRange.h"
#import  "WCValidatorLength.h"
#import  "WCValidatorFixedList.h"
#import  "WCValidatorBoletoBancarioRequiredness.h"
#import  "WCDisplayElementsConverter.h"
#import  "WCDisplayElement.h"
#import  "WCValidatorTermsAndConditions.h"
#import  "WCValidatorIBAN.h"
#import  "WCValidatorResidentIdNumber.h"
@implementation WCPaymentItemConverter {

}

- (void)setPaymentItem:(NSObject <WCPaymentItem> *)paymentItem JSON:(NSDictionary *)rawPaymentItem {
    [self setBasicPaymentItem:paymentItem JSON:rawPaymentItem];
    [self setPaymentProductFields:paymentItem.fields JSON:rawPaymentItem[@"fields"]];
}

//Product Fields converter
- (void)setPaymentProductFields:(WCPaymentProductFields *)fields JSON:(NSArray *)rawFields
{
    for (NSDictionary *rawField in rawFields) {
        WCPaymentProductField *field = [self paymentProductFieldFromJSON:rawField];
        [fields.paymentProductFields addObject:field];
    }
    [fields sort];
}

- (WCPaymentProductField *)paymentProductFieldFromJSON:(NSDictionary *)rawField
{
    WCPaymentProductField *field = [[WCPaymentProductField alloc] init];
    [self setDataRestrictions:field.dataRestrictions JSON:[rawField objectForKey:@"dataRestrictions"]];
    field.identifier = [rawField objectForKey:@"id"];
    field.usedForLookup = ((NSNumber *)[rawField objectForKey:@"usedForLookup"]).boolValue;
    [self setDisplayHints:field.displayHints JSON:[rawField objectForKey:@"displayHints"]];
    [self setType:field rawField:rawField];

    return field;
}

- (void)setType:(WCPaymentProductField *)field rawField:(NSDictionary *)rawField
{
    NSString *rawType = [rawField objectForKey:@"type"];
    if ([rawType isEqualToString:@"string"]) {
        field.type = WCString;
    } else if ([rawType isEqualToString:@"integer"]) {
        field.type = WCInteger;
    } else if ([rawType isEqualToString:@"expirydate"]) {
        field.type = WCExpirationDate;
    } else if ([rawType isEqualToString:@"numericstring"]) {
        field.type = WCNumericString;
    } else if ([rawType isEqualToString:@"boolean"]){
        field.type = WCBooleanString;
    } else if ([rawType isEqualToString:@"date"]){
        field.type = WCDateString;
    } else {
        DLog(@"Type %@ in JSON fragment %@ is invalid", rawType, rawField);
    }
}

- (void)setDisplayHints:(WCPaymentProductFieldDisplayHints *)hints JSON:(NSDictionary *)rawHints
{
    hints.alwaysShow = [[rawHints objectForKey:@"alwaysShow"] boolValue];
    hints.displayOrder = [[rawHints objectForKey:@"displayOrder"] integerValue];
    [self setFormElement:hints.formElement JSON:[rawHints objectForKey:@"formElement"]];
    hints.mask = [rawHints objectForKey:@"mask"];
    hints.obfuscate = [[rawHints objectForKey:@"obfuscate"] boolValue];
    hints.label = [rawHints objectForKey:@"label"];
    hints.placeholderLabel = [rawHints objectForKey:@"placeholderLabel"];
    hints.link = [NSURL URLWithString:[rawHints objectForKey:@"link"]];
    [self setPreferredInputType:hints JSON:[rawHints objectForKey:@"preferredInputType"]];
    [self setTooltip:hints.tooltip JSON:[rawHints objectForKey:@"tooltip"]];
}

- (void)setPreferredInputType:(WCPaymentProductFieldDisplayHints *)hints JSON:(NSString *)rawPreferredInputType
{
    if ([rawPreferredInputType isEqualToString:@"StringKeyboard"] == YES) {
        hints.preferredInputType = WCStringKeyboard;
    } else if ([rawPreferredInputType isEqualToString:@"IntegerKeyboard"] == YES) {
        hints.preferredInputType = WCIntegerKeyboard;
    } else if ([rawPreferredInputType isEqualToString:@"EmailAddressKeyboard"]) {
        hints.preferredInputType = WCEmailAddressKeyboard;
    } else if ([rawPreferredInputType isEqualToString:@"PhoneNumberKeyboard"]) {
        hints.preferredInputType = WCPhoneNumberKeyboard;
    } else if ([rawPreferredInputType isEqualToString:@"DateKeyboard"]) {
        hints.preferredInputType = WCDateKeyboard;
    } else if (rawPreferredInputType == nil) {
        hints.preferredInputType = WCNoKeyboard;
    } else {
        DLog(@"Preferred input type %@ is invalid", rawPreferredInputType);
    }
}

- (void)setTooltip:(WCTooltip *)tooltip JSON:(NSDictionary *)rawTooltip
{
    tooltip.imagePath = [rawTooltip objectForKey:@"image"];
    tooltip.label = [rawTooltip objectForKey:@"label"];
}

- (void)setFormElement:(WCFormElement *)formElement JSON:(NSDictionary *)rawFormElement
{
    [self setFormElementType:formElement JSON:rawFormElement];
}

- (void)setFormElementType:(WCFormElement *)formElement JSON:(NSDictionary *)rawFormElement
{
    NSString *rawType = [rawFormElement objectForKey:@"type"];
    if ([rawType isEqualToString:@"text"] == YES) {
        formElement.type = WCTextType;
    } else if ([rawType isEqualToString:@"currency"] == YES) {
        formElement.type = WCCurrencyType;
    } else if ([rawType isEqualToString:@"list"] == YES) {
        formElement.type = WCListType;
        [self setValueMapping:formElement JSON:[rawFormElement objectForKey:@"valueMapping"]];
    } else if ([rawType isEqualToString:@"date"] == YES) {
        formElement.type = WCDateType;
    } else if ([rawType isEqualToString:@"boolean"] == YES) {
        formElement.type = WCBoolType;
    } else {
        DLog(@"Form element %@ is invalid", rawFormElement);
    }
}

- (void)setValueMapping:(WCFormElement *)formElement JSON:(NSArray *)rawValueMapping
{
    for (NSDictionary *rawValueMappingItem in rawValueMapping) {
        WCValueMappingItem *item = [[WCValueMappingItem alloc] init];
        NSArray *displayElements = [rawValueMappingItem objectForKey:@"displayElements"];
        BOOL foundDisplayElement = NO;
        if (displayElements != nil) {
            WCDisplayElementsConverter *converter = [[WCDisplayElementsConverter alloc]init];
            item.displayElements = [converter displayElementsFromJSON:displayElements];
            for (WCDisplayElement *el in [item displayElements]) {
                if ([el.identifier isEqualToString:@"displayName"]) {
                    item.displayName = el.value;
                    foundDisplayElement = YES;
                }
            }
            if (!foundDisplayElement && item.displayName != nil) {
                WCDisplayElement *el = [[WCDisplayElement alloc]init];
                el.identifier = @"displayName";
                el.value = item.displayName;
                el.type = WCDisplayElementTypeString;
                [item setDisplayElements:[item.displayElements arrayByAddingObject:el]];
            }
        }
        else {
            item.displayName = [rawValueMappingItem objectForKey:@"displayName"];
            WCDisplayElement *el = [[WCDisplayElement alloc]init];
            el.identifier = @"displayName";
            el.value = item.displayName;
            el.type = WCDisplayElementTypeString;
            item.displayElements = [NSArray arrayWithObject:el];
        }
        item.displayName = [rawValueMappingItem objectForKey:@"displayName"];
        item.value = [rawValueMappingItem objectForKey:@"value"];
        [formElement.valueMapping addObject:item];
    }
}

- (void)setDataRestrictions:(WCDataRestrictions *)restrictions JSON:(NSDictionary *)rawRestrictions
{
    restrictions.isRequired = [[rawRestrictions objectForKey:@"isRequired"] boolValue];
    [self setValidators:restrictions.validators JSON:[rawRestrictions objectForKey:@"validators"]];
}

- (void)setValidators:(WCValidators *)validators JSON:(NSDictionary *)rawValidators
{
    WCValidator *validator;
    if ([rawValidators objectForKey:@"luhn"] != nil) {
        validator = [[WCValidatorLuhn alloc] init];
        [validators.validators addObject:validator];
    }
    if ([rawValidators objectForKey:@"expirationDate"] != nil) {
        validator = [[WCValidatorExpirationDate alloc] init];
        [validators.validators addObject:validator];
    }
    if ([rawValidators objectForKey:@"range"] != nil) {
        validator = [self validatorRangeFromJSON:[rawValidators objectForKey:@"range"]];
        [validators.validators addObject:validator];
    }
    if ([rawValidators objectForKey:@"length"] != nil) {
        validator = [self validatorLengthFromJSON:[rawValidators objectForKey:@"length"]];
        [validators.validators addObject:validator];
    }
    if ([rawValidators objectForKey:@"fixedList"] != nil) {
        validator = [self validatorFixedListFromJSON:[rawValidators objectForKey:@"fixedList"]];
        [validators.validators addObject:validator];
    }
    if ([rawValidators objectForKey:@"emailAddress"] != nil) {
        validator = [[WCValidatorEmailAddress alloc] init];
        [validators.validators addObject:validator];
    }
    if ([rawValidators objectForKey:@"regularExpression"] != nil) {
        validator = [self validatorRegularExpressionFromJSON:[rawValidators objectForKey:@"regularExpression"]];
        [validators.validators addObject:validator];
    }
    if ([rawValidators objectForKey:@"termsAndConditions"] != nil) {
        validator = [[WCValidatorTermsAndConditions alloc] init];
        [validators.validators addObject:validator];
    }
    if ([rawValidators objectForKey:@"iban"] != nil) {
        validator = [[WCValidatorIBAN alloc] init];
        [validators.validators addObject:validator];
    }
    if ([rawValidators objectForKey:@"boletoBancarioRequiredness"] != nil) {
        validator = [self validatorBoletoBancarioRequirednessFromJSON:[rawValidators objectForKey:@"boletoBancarioRequiredness"]];
        [validators.validators addObject:validator];
        validators.containsSomeTimesRequiredValidator = YES;
    }
    if ([rawValidators objectForKey:@"residentIdNumber"] != nil) {
        validator = [[WCValidatorResidentIdNumber alloc] init];
        [validators.validators addObject:validator];
    }
}

- (WCValidatorRegularExpression *)validatorRegularExpressionFromJSON:(NSDictionary *)rawValidator
{
    NSString *rawRegularExpression = [rawValidator objectForKey:@"regularExpression"];
    NSRegularExpression *regularExpression = [NSRegularExpression regularExpressionWithPattern:rawRegularExpression options:0 error:NULL];
    WCValidatorRegularExpression *validator = [[WCValidatorRegularExpression alloc] initWithRegularExpression:regularExpression];
    return validator;
}

- (WCValidatorRange *)validatorRangeFromJSON:(NSDictionary *)rawValidator
{
    WCValidatorRange *validator = [[WCValidatorRange alloc] init];
    validator.maxValue = [[rawValidator objectForKey:@"maxValue"] integerValue];
    validator.minValue = [[rawValidator objectForKey:@"minValue"] integerValue];
    return validator;
}

- (WCValidatorLength *)validatorLengthFromJSON:(NSDictionary *)rawValidator
{
    WCValidatorLength *validator = [[WCValidatorLength alloc] init];
    validator.maxLength = [[rawValidator objectForKey:@"maxLength"] integerValue];
    validator.minLength = [[rawValidator objectForKey:@"minLength"] integerValue];
    return validator;
}

- (WCValidatorFixedList *)validatorFixedListFromJSON:(NSDictionary *)rawValidator
{
    NSArray *rawValues = [rawValidator objectForKey:@"allowedValues"];
    NSMutableArray *allowedValues = [[NSMutableArray alloc] init];
    for (NSString *value in rawValues) {
        [allowedValues addObject:value];
    }
    WCValidatorFixedList *validator = [[WCValidatorFixedList alloc] initWithAllowedValues:allowedValues];
    return validator;
}

- (WCValidatorBoletoBancarioRequiredness *)validatorBoletoBancarioRequirednessFromJSON:(NSDictionary *)rawValidator
{
    WCValidatorBoletoBancarioRequiredness *validator = [[WCValidatorBoletoBancarioRequiredness alloc] init];
    validator.fiscalNumberLength = [[rawValidator objectForKey:@"fiscalNumberLength"] integerValue];
    return validator;
}

@end
