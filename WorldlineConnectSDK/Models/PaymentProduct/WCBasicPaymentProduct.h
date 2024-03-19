//
//  WCBasicPaymentProduct.h
//  WorldlineConnectSDK
//
//  Created for Worldline Global Collect on 15/12/2016.
//  Copyright © 2017 Worldline Global Collect. All rights reserved.
//

#import <Foundation/Foundation.h>

#import  "WCAccountsOnFile.h"
#import  "WCAccountOnFile.h"
#import  "WCAuthenticationIndicator.h"
#import  "WCPaymentItemDisplayHints.h"
#import  "WCPaymentItem.h"
#import  "WCBasicPaymentItem.h"
#import  "WCPaymentProduct302SpecificData.h"
#import  "WCPaymentProduct320SpecificData.h"
#import  "WCPaymentProduct863SpecificData.h"

@interface WCBasicPaymentProduct : NSObject <WCBasicPaymentItem>

@property (nonatomic, strong) NSString *identifier;
@property (nonatomic, strong) WCPaymentItemDisplayHints *displayHints;
@property (strong, nonatomic) WCAccountsOnFile *accountsOnFile;
@property (strong, nonatomic) NSString *acquirerCountry;
@property (nonatomic) BOOL allowsTokenization;
@property (nonatomic) BOOL allowsRecurring;
@property (nonatomic) BOOL autoTokenized;
@property (nonatomic) BOOL allowsInstallments;

@property (strong, nonatomic) WCAuthenticationIndicator *authenticationIndicator;

@property (nonatomic) BOOL *deviceFingerprintEnabled;

@property (nonatomic) NSInteger *minAmount;
@property (nonatomic) NSInteger *maxAmount;

@property (nonatomic) NSString *paymentMethod;
@property (nonatomic) NSString *mobileIntegrationLevel;
@property (nonatomic) BOOL *usesRedirectionTo3rdParty;
@property (nonatomic) NSString *paymentProductGroup;
@property (nonatomic) BOOL *supportsMandates;

@property (strong, nonatomic) WCPaymentProduct302SpecificData *paymentProduct302SpecificData;
@property (strong, nonatomic) WCPaymentProduct320SpecificData *paymentProduct320SpecificData;
@property (strong, nonatomic) WCPaymentProduct863SpecificData *paymentProduct863SpecificData;

- (WCAccountOnFile *)accountOnFileWithIdentifier:(NSString *)accountOnFileIdentifier;
- (void)setStringFormatter:(WCStringFormatter *)stringFormatter;

@end
