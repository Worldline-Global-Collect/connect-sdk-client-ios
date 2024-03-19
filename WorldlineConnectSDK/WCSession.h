//
//  WCSession.h
//  WorldlineConnectSDK
//
//  Created for Worldline Global Collect on 15/12/2016.
//  Copyright © 2017 Worldline Global Collect. All rights reserved.
//

#import <Foundation/Foundation.h>

#import  "WCPaymentRequest.h"
#import  "WCBasicPaymentProducts.h"
#import  "WCC2SCommunicator.h"
#import  "WCIINDetailsResponse.h"
#import  "WCPreparedPaymentRequest.h"
#import  "WCPaymentContext.h"
#import  "WCAssetManager.h"
#import  "WCJOSEEncryptor.h"
#import  "WCDirectoryEntries.h"

@class WCBasicPaymentProductGroups;
@class WCPaymentProductGroup;

@interface WCSession : NSObject
@property (nonatomic, strong) NSString *baseURL;
@property (nonatomic, strong) NSString *assetsBaseURL;

- (instancetype)initWithCommunicator:(WCC2SCommunicator *)communicator assetManager:(WCAssetManager *)assetManager encryptor:(WCEncryptor *)encryptor JOSEEncryptor:(WCJOSEEncryptor *)JOSEEncryptor stringFormatter:(WCStringFormatter *)stringFormatter;
+ (WCSession *)sessionWithClientSessionId:(NSString *)clientSessionId customerId:(NSString *)customerId baseURL:(NSString *)baseURL assetBaseURL:(NSString *)assetBaseURL appIdentifier:(NSString *)appIdentifier loggingEnabled:(BOOL)loggingEnabled;

- (void)paymentProductsForContext:(WCPaymentContext *)context success:(void (^)(WCBasicPaymentProducts *paymentProducts))success failure:(void (^)(NSError *error))failure;
- (void)paymentProductGroupsForContext:(WCPaymentContext *)context success:(void (^)(WCBasicPaymentProductGroups *paymentProductGroups))success failure:(void (^)(NSError *error))failure;
- (void)paymentItemsForContext:(WCPaymentContext *)context groupPaymentProducts:(BOOL)groupPaymentProducts success:(void (^)(WCPaymentItems *paymentItems))success failure:(void (^)(NSError *error))failure;

- (void)paymentProductWithId:(NSString *)paymentProductId context:(WCPaymentContext *)context success:(void (^)(WCPaymentProduct *paymentProduct))success failure:(void (^)(NSError *error))failure;
- (void)paymentProductGroupWithId:(NSString *)paymentProductGroupId context:(WCPaymentContext *)context success:(void (^)(WCPaymentProductGroup *paymentProductGroup))success failure:(void (^)(NSError *error))failure;

- (void)privacyPolicyForProductId:(NSString *)paymentProductId locale:(NSString *)locale success:(void (^)(WCPrivacyPolicyResponse *privacyPolicyResponse))success failure:(void (^)(NSError *error))failure;
- (void)IINDetailsForPartialCreditCardNumber:(NSString *)partialCreditCardNumber context:(WCPaymentContext *)context success:(void (^)(WCIINDetailsResponse *iinDetailsResponse))success failure:(void (^)(NSError *error))failure;
- (void)convertAmount:(long)amountInCents withSource:(NSString *)source target:(NSString *)target success:(void (^)(long convertedAmountInCents))success failure:(void (^)(NSError *error))failure;
- (void)directoryForPaymentProductId:(NSString *)paymentProductId countryCode:(NSString *)countryCode currencyCode:(NSString *)currencyCode success:(void (^)(WCDirectoryEntries *directoryEntries))success failure:(void (^)(NSError *error))failure;
- (void)preparePaymentRequest:(WCPaymentRequest *)paymentRequest success:(void (^)(WCPreparedPaymentRequest *preparedPaymentRequest))success failure:(void (^)(NSError *error))failure;
- (void)paymentProductNetworksForProductId:(NSString *)paymentProductId context:(WCPaymentContext *)context success:(void (^)(WCPaymentProductNetworks *paymentProductNetworks))success failure:(void (^)(NSError *error))failure;
- (void)thirdPartyStatusForPayment:(NSString *)paymentId success:(void(^)(WCThirdPartyStatusResponse *thirdPartyStatusResponse))success failure:(void(^)(NSError *error))failure;
- (BOOL)loggingEnabled;
- (void)setLoggingEnabled:(BOOL)loggingEnabled;

@end
