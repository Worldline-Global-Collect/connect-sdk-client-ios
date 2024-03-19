//
//  WCC2SCommunicator.h
//  WorldlineConnectSDK
//
//  Created for Worldline Global Collect on 15/12/2016.
//  Copyright © 2017 Worldline Global Collect. All rights reserved.
//

#import <Foundation/Foundation.h>
#import  "WCC2SCommunicatorConfiguration.h"
#import  "WCPaymentContext.h"
#import  "WCPublicKeyResponse.h"
#import  "WCBasicPaymentProducts.h"
#import  "WCPaymentProduct.h"
#import  "WCAssetManager.h"
#import  "WCStringFormatter.h"
#import  "WCDirectoryEntries.h"
#import  "WCIINDetailsResponse.h"
#import  "WCPrivacyPolicyResponse.h"
#import  "WCPaymentProductNetworks.h"

@class WCBasicPaymentProductGroups;
@class WCPaymentProductGroup;
@class WCThirdPartyStatusResponse;
@interface WCC2SCommunicator : NSObject

- (instancetype)initWithConfiguration:(WCC2SCommunicatorConfiguration *)configuration;
- (void)paymentProductsForContext:(WCPaymentContext *)context success:(void (^)(WCBasicPaymentProducts *paymentProducts))success failure:(void (^)(NSError *error))failure;
- (void)paymentProductGroupsForContext:(WCPaymentContext *)context success:(void (^)(WCBasicPaymentProductGroups *paymentProductGroups))success failure:(void (^)(NSError *error))failure;
- (void)paymentProductWithId:(NSString *)paymentProductId context:(WCPaymentContext *)context success:(void (^)(WCPaymentProduct *paymentProduct))success failure:(void (^)(NSError *error))failure;
- (void)paymentProductGroupWithId:(NSString *)paymentProductGroupId context:(WCPaymentContext *)context success:(void (^)(WCPaymentProductGroup *paymentProductGroup))success failure:(void (^)(NSError *error))failure;
- (void)paymentProductIdByPartialCreditCardNumber:(NSString *)partialCreditCardNumber context:(WCPaymentContext *)context success:(void (^)(WCIINDetailsResponse *iinDetailsResponse))success failure:(void (^)(NSError *error))failure;
- (void)privacyPolicyForProductId:(NSString *)paymentProductId locale:(NSString *)locale success:(void (^)(WCPrivacyPolicyResponse *privacyPolicyResponse))success failure:(void (^)(NSError *error))failure;
- (void)publicKey:(void (^)(WCPublicKeyResponse *publicKeyResponse))success failure:(void (^)(NSError *error))failure;
- (void)convertAmount:(long)amountInCents withSource:(NSString *)source target:(NSString *)target success:(void (^)(long convertedAmountInCents))success failure:(void (^)(NSError *error))failure;
- (void)directoryForPaymentProductId:(NSString *)paymentProductId countryCode:(NSString *)countryCode currencyCode:(NSString *)currencyCode success:(void (^)(WCDirectoryEntries *directoryEntries))success failure:(void (^)(NSError *error))failure;
- (void)paymentProductNetworksForProductId:(NSString *)paymentProductId context:(WCPaymentContext *)context success:(void (^)(WCPaymentProductNetworks *paymentProductNetworks))success failure:(void (^)(NSError *error))failure;
- (void)thirdPartyStatusForPayment:(NSString *)paymentId success:(void(^)(WCThirdPartyStatusResponse *thirdPartyStatusResponse))success failure:(void(^)(NSError *error))failure;
- (NSString *)base64EncodedClientMetaInfo;
- (NSString *)baseURL;
- (NSString *)assetsBaseURL;
- (NSString *)clientSessionId;
- (BOOL)loggingEnabled;
- (void)setLoggingEnabled:(BOOL)loggingEnabled;

@end
