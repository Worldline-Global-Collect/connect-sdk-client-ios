// WCNetworkingWrapper.h
// WorldlineConnectSDK
//
// Copyright (c) 2018 AFNetworking (http://afnetworking.com/)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.


#import <Foundation/Foundation.h>

FOUNDATION_EXPORT NSString * const WCURLResponseSerializationErrorDomain;
FOUNDATION_EXPORT NSString * const WCNetworkingTaskDidResumeNotification;
FOUNDATION_EXPORT NSString * const WCNetworkingTaskDidCompleteNotification;
FOUNDATION_EXPORT NSString * const WCNetworkingTaskDidSuspendNotification;
FOUNDATION_EXPORT NSString * const WCNetworkingTaskDidCompleteErrorKey;
FOUNDATION_EXPORT NSString * const WCNSURLSessionTaskDidResumeNotification;
FOUNDATION_EXPORT NSString * const WCNSURLSessionTaskDidSuspendNotification;
FOUNDATION_EXPORT NSString * const WCNetworkingTaskDidCompleteSerializedResponseKey;
FOUNDATION_EXPORT NSString * const WCNetworkingOperationFailingURLResponseErrorKey;
FOUNDATION_EXPORT NSString * const WCNetworkingOperationFailingURLResponseDataErrorKey;

@interface WCNetworkingWrapper : NSObject

- (void)getResponseForURL:(NSString *)URL headers:(NSDictionary *)headers additionalAcceptableStatusCodes:(NSIndexSet *)additionalAcceptableStatusCodes success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;
- (void)postResponseForURL:(NSString *)URL headers:(NSDictionary *)headers withParameters:(NSDictionary *)parameters additionalAcceptableStatusCodes:(NSIndexSet *)additionalAcceptableStatusCodes success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

@end
