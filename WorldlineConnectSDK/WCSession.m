//
//  WCSession.m
//  WorldlineConnectSDK
//
//  Created for Worldline Global Collect on 15/12/2016.
//  Copyright © 2017 Worldline Global Collect. All rights reserved.
//

#import  "WCSession.h"
#import  "WCBase64.h"
#import  "WCJSON.h"
#import  "WCSDKConstants.h"
#import  "WCBasicPaymentProductGroups.h"
#import  "WCPaymentProductGroup.h"
#import  "WCPaymentItems.h"
#import <PassKit/PassKit.h>

@interface WCSession ()

@property (strong, nonatomic) WCC2SCommunicator *communicator;
@property (strong, nonatomic) WCAssetManager *assetManager;
@property (strong, nonatomic) WCEncryptor *encryptor;
@property (strong, nonatomic) WCJOSEEncryptor *JOSEEncryptor;
@property (strong, nonatomic) WCStringFormatter *stringFormatter;
@property (strong, nonatomic) WCBasicPaymentProducts *paymentProducts;
@property (strong, nonatomic) WCBasicPaymentProductGroups *paymentProductGroups;
@property (strong, nonatomic) NSMutableDictionary *paymentProductMapping;
@property (strong, nonatomic) NSMutableDictionary *paymentProductGroupMapping;
@property (strong, nonatomic) NSMutableDictionary *directoryEntriesMapping;
@property (strong, nonatomic) WCBase64 *base64;
@property (strong, nonatomic) WCJSON *JSON;
@property (strong, nonatomic) NSMutableDictionary *IINMapping;
@property (assign, nonatomic) BOOL iinLookupPending; 

@end

@implementation WCSession

- (instancetype)initWithCommunicator:(WCC2SCommunicator *)communicator assetManager:(WCAssetManager *)assetManager encryptor:(WCEncryptor *)encryptor JOSEEncryptor:(WCJOSEEncryptor *)JOSEEncryptor stringFormatter:(WCStringFormatter *)stringFormatter
{
    self = [super init];
    if (self != nil) {
        self.base64 = [[WCBase64 alloc] init];
        self.JSON = [[WCJSON alloc] init];
        self.communicator = communicator;
        self.assetManager = assetManager;
        self.encryptor = encryptor;
        self.JOSEEncryptor = JOSEEncryptor;
        self.stringFormatter = stringFormatter;
        self.IINMapping = [[StandardUserDefaults objectForKey:kWCIINMapping] mutableCopy];
        if (self.IINMapping == nil) {
            self.IINMapping = [[NSMutableDictionary alloc] init];
        }
        self.paymentProductMapping = [[NSMutableDictionary alloc] init];
        self.directoryEntriesMapping = [[NSMutableDictionary alloc] init];
    }
    return self;
}

-(NSString *)baseURL {
    return [self.communicator baseURL];
}

-(NSString *)assetsBaseURL {
    return [self.communicator assetsBaseURL];
}

+ (WCSession *)sessionWithClientSessionId:(NSString *)clientSessionId customerId:(NSString *)customerId baseURL:(NSString *)baseURL assetBaseURL:(NSString *)assetBaseURL appIdentifier:(NSString *)appIdentifier loggingEnabled:(BOOL)loggingEnabled {
    WCUtil *util = [[WCUtil alloc] init];
    WCAssetManager *assetManager = [[WCAssetManager alloc] init];
    WCStringFormatter *stringFormatter = [[WCStringFormatter alloc] init];
    WCEncryptor *encryptor = [[WCEncryptor alloc] init];
    WCC2SCommunicatorConfiguration *configuration = [[WCC2SCommunicatorConfiguration alloc] initWithClientSessionId:clientSessionId customerId:customerId baseURL:baseURL assetBaseURL:assetBaseURL appIdentifier:appIdentifier util:util loggingEnabled: loggingEnabled];
    WCC2SCommunicator *communicator = [[WCC2SCommunicator alloc] initWithConfiguration:configuration];
    WCJOSEEncryptor *JOSEEncryptor = [[WCJOSEEncryptor alloc] initWithEncryptor:encryptor];
    WCSession *session = [[WCSession alloc] initWithCommunicator:communicator assetManager:assetManager encryptor:encryptor JOSEEncryptor:JOSEEncryptor stringFormatter:stringFormatter];
    return session;
}

- (void)paymentProductsForContext:(WCPaymentContext *)context success:(void (^)(WCBasicPaymentProducts *paymentProducts))success failure:(void (^)(NSError *error))failure
{
    [self.communicator paymentProductsForContext:context success:^(WCBasicPaymentProducts *paymentProducts) {
        self.paymentProducts = paymentProducts;
        self.paymentProducts.stringFormatter = self.stringFormatter;
        [self.assetManager initializeImagesForPaymentItems:paymentProducts.paymentProducts];
        [self.assetManager updateImagesForPaymentItemsAsynchronously:paymentProducts.paymentProducts baseURL:[self.communicator assetsBaseURL] callback:^{
            [self.assetManager initializeImagesForPaymentItems:paymentProducts.paymentProducts];
            success(paymentProducts);
        }];
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (void)paymentProductNetworksForProductId:(NSString *)paymentProductId context:(WCPaymentContext *)context success:(void (^)(WCPaymentProductNetworks *paymentProductNetworks))success failure:(void (^)(NSError *error))failure {
    [self.communicator paymentProductNetworksForProductId:paymentProductId context:context success:^(WCPaymentProductNetworks *paymentProductNetworks) {
        success(paymentProductNetworks);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (void)paymentProductGroupsForContext:(WCPaymentContext *)context success:(void (^)(WCBasicPaymentProductGroups *paymentProductGroups))success failure:(void (^)(NSError *error))failure {
    [self.communicator paymentProductGroupsForContext:context success:^(WCBasicPaymentProductGroups *paymentProductGroups) {
        self.paymentProductGroups = paymentProductGroups;
        self.paymentProductGroups.stringFormatter = self.stringFormatter;
        [self.assetManager initializeImagesForPaymentItems:paymentProductGroups.paymentProductGroups];
        [self.assetManager updateImagesForPaymentItemsAsynchronously:paymentProductGroups.paymentProductGroups baseURL:[self.communicator assetsBaseURL] callback:^{
            [self.assetManager initializeImagesForPaymentItems:paymentProductGroups.paymentProductGroups];
            success(paymentProductGroups);
        }];
    } failure:^(NSError *error) {
        failure(error);
    }];

}
- (void)thirdPartyStatusForPayment:(NSString *)paymentId success:(void(^)(WCThirdPartyStatusResponse *thirdPartyStatusResponse))success failure:(void(^)(NSError *error))failure
{
    [self.communicator thirdPartyStatusForPayment:paymentId success:success failure:failure];
}
- (void)paymentItemsForContext:(WCPaymentContext *)context groupPaymentProducts:(BOOL)groupPaymentProducts success:(void (^)(WCPaymentItems *paymentItems))success failure:(void (^)(NSError *error))failure {
    [self.communicator paymentProductsForContext:context success:^(WCBasicPaymentProducts *paymentProducts) {
        self.paymentProducts = paymentProducts;
        self.paymentProducts.stringFormatter = self.stringFormatter;
        [self.assetManager initializeImagesForPaymentItems:paymentProducts.paymentProducts];
        [self.assetManager updateImagesForPaymentItemsAsynchronously:paymentProducts.paymentProducts baseURL:[self.communicator assetsBaseURL] callback:^{
            [self.assetManager initializeImagesForPaymentItems:paymentProducts.paymentProducts];
            if (groupPaymentProducts) {
                [self.communicator paymentProductGroupsForContext:context success:^(WCBasicPaymentProductGroups *paymentProductGroups) {
                    self.paymentProductGroups = paymentProductGroups;
                    self.paymentProductGroups.stringFormatter = self.stringFormatter;
                    [self.assetManager initializeImagesForPaymentItems:paymentProductGroups.paymentProductGroups];
                    [self.assetManager updateImagesForPaymentItemsAsynchronously:paymentProductGroups.paymentProductGroups baseURL:[self.communicator assetsBaseURL] callback:^{
                        [self.assetManager initializeImagesForPaymentItems:paymentProductGroups.paymentProductGroups];
                        WCPaymentItems *items = [[WCPaymentItems alloc] initWithPaymentProducts:paymentProducts groups:paymentProductGroups];
                        success(items);
                    }];
                    
                } failure:failure];
            }
            else {
                WCPaymentItems *items = [[WCPaymentItems alloc] initWithPaymentProducts:paymentProducts groups:nil];
                success(items);
            }
        }];

    } failure:failure];
}

- (void)paymentProductWithId:(NSString *)paymentProductId context:(WCPaymentContext *)context success:(void (^)(WCPaymentProduct *paymentProduct))success failure:(void (^)(NSError *error))failure
{
    NSString *key = [NSString stringWithFormat:@"%@-%@", paymentProductId, [context description]];
    WCPaymentProduct *paymentProduct = [self.paymentProductMapping objectForKey:key];
    if (paymentProduct != nil) {
        success(paymentProduct);
    } else {
        [self.communicator paymentProductWithId:paymentProductId context:context success:^(WCPaymentProduct *paymentProduct) {
            [self.paymentProductMapping setObject:paymentProduct forKey:key];
            [self.assetManager initializeImagesForPaymentItem:paymentProduct];
            [self.assetManager updateImagesForPaymentItemAsynchronously:paymentProduct baseURL:[self.communicator assetsBaseURL] callback:^{
                [self.assetManager initializeImagesForPaymentItem:paymentProduct];
                success(paymentProduct);
            }];
        } failure:^(NSError *error) {
            failure(error);
        }];
    }
}

- (void)paymentProductGroupWithId:(NSString *)paymentProductGroupId context:(WCPaymentContext *)context success:(void (^)(WCPaymentProductGroup *paymentProductGroup))success failure:(void (^)(NSError *error))failure {
    NSString *key = [NSString stringWithFormat:@"%@-%@", paymentProductGroupId, [context description]];
    WCPaymentProductGroup *paymentProductGroup = [self.paymentProductGroupMapping objectForKey:key];
    if (paymentProductGroup != nil) {
        success(paymentProductGroup);
    } else {
        [self.communicator paymentProductGroupWithId:paymentProductGroupId context:context success:^(WCPaymentProductGroup *paymentProductGroup) {
            [self.paymentProductGroupMapping setObject:paymentProductGroup forKey:key];
            [self.assetManager initializeImagesForPaymentItem:paymentProductGroup];
            [self.assetManager updateImagesForPaymentItemAsynchronously:paymentProductGroup baseURL:[self.communicator assetsBaseURL] callback:^{
                [self.assetManager initializeImagesForPaymentItem:paymentProductGroup];
                success(paymentProductGroup);
            }];
        } failure:^(NSError *error) {
            failure(error);
        }];
    }
}

- (void)privacyPolicyForProductId:(NSString *)paymentProductId locale:(NSString *)locale success:(void (^)(WCPrivacyPolicyResponse *privacyPolicyResponse))success failure:(void (^)(NSError *error))failure
{
    [self.communicator privacyPolicyForProductId:paymentProductId locale:locale success:^(WCPrivacyPolicyResponse *privacyPolicyResponse) {
        success(privacyPolicyResponse);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (void)IINDetailsForPartialCreditCardNumber:(NSString *)partialCreditCardNumber context:(WCPaymentContext *)context success:(void (^)(WCIINDetailsResponse *iinDetailsResponse))success failure:(void (^)(NSError *error))failure
{
    if (partialCreditCardNumber.length < 6) {
        WCIINDetailsResponse *response = [[WCIINDetailsResponse alloc] initWithStatus:WCNotEnoughDigits];
        success(response);
    } else if (self.iinLookupPending == YES) {
        WCIINDetailsResponse *response = [[WCIINDetailsResponse alloc] initWithStatus:WCPending];
        success(response);
    }
    else {
        self.iinLookupPending = YES;
        [self.communicator paymentProductIdByPartialCreditCardNumber:partialCreditCardNumber context:context success:^(WCIINDetailsResponse *response) {
            self.iinLookupPending = NO;
            success(response);
        } failure:^(NSError *error) {
            self.iinLookupPending = NO;
            failure(error);

        }];
    }
}

- (void)convertAmount:(long)amountInCents withSource:(NSString *)source target:(NSString *)target success:(void (^)(long convertedAmountInCents))success failure:(void (^)(NSError *error))failure
{
    [self.communicator convertAmount:amountInCents withSource:source target:target success:^(long convertedAmountInCents) {
        success(convertedAmountInCents);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (void)directoryForPaymentProductId:(NSString *)paymentProductId countryCode:(NSString *)countryCode currencyCode:(NSString *)currencyCode success:(void (^)(WCDirectoryEntries *directory))success failure:(void (^)(NSError *error))failure
{
    NSString *key = [NSString stringWithFormat:@"%@-%@-%@", paymentProductId, countryCode, currencyCode];
    WCDirectoryEntries *directoryEntries = [self.directoryEntriesMapping objectForKey:key];
    if (directoryEntries != nil) {
        success(directoryEntries);
    } else {
        [self.communicator directoryForPaymentProductId:paymentProductId countryCode:countryCode currencyCode:currencyCode success:^(WCDirectoryEntries *directoryEntries) {
            [self.directoryEntriesMapping setObject:directoryEntries forKey:key];
            success(directoryEntries);
        } failure:^(NSError *error) {
            failure(error);
        }];
    }
}

- (void)preparePaymentRequest:(WCPaymentRequest *)paymentRequest success:(void (^)(WCPreparedPaymentRequest *preparedPaymentRequest))success failure:(void (^)(NSError *error))failure;
{
    [self.communicator publicKey:^(WCPublicKeyResponse *publicKeyResponse) {
        NSString *keyId = publicKeyResponse.keyId;
        
        NSString *encodedPublicKey = publicKeyResponse.encodedPublicKey;
        NSData *publicKeyAsData = [self.base64 decode:encodedPublicKey];
        NSData *strippedPublicKeyAsData = [self.encryptor stripPublicKey:publicKeyAsData];
        NSString *tag = @"globalcollect-sdk-public-key";
        [self.encryptor deleteRSAKeyWithTag:tag];
        [self.encryptor storePublicKey:strippedPublicKeyAsData tag:tag];
        SecKeyRef publicKey = [self.encryptor RSAKeyWithTag:tag];
        
        WCPreparedPaymentRequest *preparedRequest = [[WCPreparedPaymentRequest alloc] init];
        NSMutableString *paymentRequestJSON = [[NSMutableString alloc] init];
        NSString *clientSessionId = [NSString stringWithFormat:@"{\"clientSessionId\": \"%@\", ", [self clientSessionId]];
        [paymentRequestJSON appendString:clientSessionId];
        NSString *nonce = [NSString stringWithFormat:@"\"nonce\": \"%@\", ", [self.encryptor UUID]];
        [paymentRequestJSON appendString:nonce];
        NSString *paymentProduct = [NSString stringWithFormat:@"\"paymentProductId\": %ld, ", (long)[paymentRequest.paymentProduct.identifier integerValue]];
        [paymentRequestJSON appendString:paymentProduct];
        if (paymentRequest.accountOnFile != nil) {
            NSString *accountOnFile = [NSString stringWithFormat:@"\"accountOnFileId\": %ld, ", (long)[paymentRequest.accountOnFile.identifier integerValue]];
            [paymentRequestJSON appendString:accountOnFile];
        }
        if (paymentRequest.tokenize == YES) {
            NSString *tokenize = @"\"tokenize\": true, ";
            [paymentRequestJSON appendString:tokenize];
        }
        NSString *paymentValues = [NSString stringWithFormat:@"\"paymentValues\": %@}", [self.JSON keyValueJSONFromDictionary:paymentRequest.unmaskedFieldValues]];
        [paymentRequestJSON appendString:paymentValues];
        preparedRequest.encryptedFields = [self.JOSEEncryptor encryptToCompactSerialization:paymentRequestJSON withPublicKey:publicKey keyId:keyId];
        preparedRequest.encodedClientMetaInfo = [self.communicator base64EncodedClientMetaInfo];
        success(preparedRequest);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (void)publicKey:(void (^)(WCPublicKeyResponse *publicKeyResponse))success failure:(void (^)(NSError *error))failure
{
    [self.communicator publicKey:success failure:failure];
}

- (NSString *)clientSessionId
{
    return [self.communicator clientSessionId];
}

- (BOOL)loggingEnabled {
    return [self.communicator loggingEnabled];
}

-(void)setLoggingEnabled:(BOOL)loggingEnabled {
    [self.communicator setLoggingEnabled:loggingEnabled];
}

@end
