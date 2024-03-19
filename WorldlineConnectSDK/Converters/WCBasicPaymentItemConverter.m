//
//  WCBasicPaymentItemConverter.m
//  WorldlineConnectSDK
//
//  Created for Worldline Global Collect on 15/12/2016.
//  Copyright © 2017 Worldline Global Collect. All rights reserved.
//

#import  "WCBasicPaymentItemConverter.h"
#import  "WCValidator.h"
#import  "WCBasicPaymentItem.h"
#import  "WCMacros.h"
#import  "WCBasicPaymentProductConverter.h"
#import  "WCAccountOnFileAttribute.h"
#import  "WCLabelTemplateItem.h"

@implementation WCBasicPaymentItemConverter {

}

- (void)setBasicPaymentItem:(NSObject <WCBasicPaymentItem> *)paymentItem JSON:(NSDictionary *)rawPaymentItem {
    NSObject *identifier = [rawPaymentItem objectForKey:@"id"];
    if ([identifier isKindOfClass:[NSString class]]) {
        paymentItem.identifier = (NSString *) identifier;
    } else if ([identifier isKindOfClass:[NSNumber class]]) {
        paymentItem.identifier = [(NSNumber *)identifier stringValue];
    }

    [self setPaymentProductDisplayHints:paymentItem.displayHints JSON:[rawPaymentItem objectForKey:@"displayHints"]];
    [self setAccountsOnFile:paymentItem.accountsOnFile JSON:[rawPaymentItem objectForKey:@"accountsOnFile"]];
    paymentItem.acquirerCountry = [rawPaymentItem objectForKey:@"acquirerCountry"];
}

- (void)setPaymentProductDisplayHints:(WCPaymentItemDisplayHints *)displayHints JSON:(NSDictionary *)rawDisplayHints
{
    displayHints.displayOrder = [[rawDisplayHints objectForKey:@"displayOrder"] integerValue];
    displayHints.label = [[rawDisplayHints objectForKey:@"label"] stringValue];
    displayHints.logoPath = [rawDisplayHints objectForKey:@"logo"];
}

- (void)setAccountsOnFile:(WCAccountsOnFile *)accountsOnFile JSON:(NSArray *)rawAccounts
{
    for (NSDictionary *rawAccount in rawAccounts) {
        WCAccountOnFile *account = [self accountOnFileFromJSON:rawAccount];
        [accountsOnFile.accountsOnFile addObject:account];
    }
}

- (WCAccountOnFile *)accountOnFileFromJSON:(NSDictionary *)rawAccount
{
    WCAccountOnFile *account = [[WCAccountOnFile alloc] init];
    account.identifier = [[rawAccount objectForKey:@"id"] stringValue];
    account.paymentProductIdentifier = [[rawAccount objectForKey:@"paymentProductId"] stringValue];
    [self setAccountOnFileDisplayHints:account.displayHints JSON:[rawAccount objectForKey:@"displayHints"]];
    [self setAttributes:account.attributes JSON:[rawAccount objectForKey:@"attributes"]];
    return account;
}

- (void)setAccountOnFileDisplayHints:(WCAccountOnFileDisplayHints *)displayHints JSON:(NSDictionary *)rawDisplayHints
{
    [self setLabelTemplate:displayHints.labelTemplate JSON:[rawDisplayHints objectForKey:@"labelTemplate"]];
    displayHints.logo = [[rawDisplayHints objectForKey:@"logo"] stringValue];
}

- (void)setLabelTemplate:(WCLabelTemplate *)labelTemplate JSON:(NSArray *)rawLabelTemplate
{
    for (NSDictionary *rawLabelTemplateItem in rawLabelTemplate) {
        WCLabelTemplateItem *item = [self labelTemplateItemFromJSON:rawLabelTemplateItem];
        [labelTemplate.labelTemplateItems addObject:item];
    }
}

- (WCLabelTemplateItem *)labelTemplateItemFromJSON:(NSDictionary *)rawLabelTemplateItem
{
    WCLabelTemplateItem *item = [[WCLabelTemplateItem alloc] init];
    item.attributeKey = [rawLabelTemplateItem objectForKey:@"attributeKey"];
    item.mask = [rawLabelTemplateItem objectForKey:@"mask"];
    return item;
}

- (void)setAttributes:(WCAccountOnFileAttributes *)attributes JSON:(NSArray *)rawAttributes
{
    for (NSDictionary *rawAttribute in rawAttributes) {
        WCAccountOnFileAttribute *attribute = [self attributeFromJSON:rawAttribute];
        [attributes.attributes addObject:attribute];
    }
}

- (WCAccountOnFileAttribute *)attributeFromJSON:(NSDictionary *)rawAttribute
{
    WCAccountOnFileAttribute *attribute = [[WCAccountOnFileAttribute alloc] init];
    attribute.key = [rawAttribute objectForKey:@"key"];
    attribute.value = [rawAttribute objectForKey:@"value"];
    NSString *rawStatus = [rawAttribute objectForKey:@"status"];
    if ([rawStatus isEqualToString:@"READ_ONLY"] == YES) {
        attribute.status = WCReadOnly;
    } else if ([rawStatus isEqualToString:@"CAN_WRITE"] == YES) {
        attribute.status = WCCanWrite;
    } else if ([rawStatus isEqualToString:@"MUST_WRITE"] == YES) {
        attribute.status = WCMustWrite;
    } else {
        DLog(@"Status %@ in JSON fragment %@ is invalid", rawStatus, rawAttribute);
    }
    attribute.mustWriteReason = [rawAttribute objectForKey:@"mustWriteReason"];

    return attribute;
}

@end
