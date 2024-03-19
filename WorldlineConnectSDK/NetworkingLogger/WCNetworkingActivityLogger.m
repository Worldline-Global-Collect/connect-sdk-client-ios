// WCNetworkActivityLogger.h
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

#import "WCNetworkingActivityLogger.h"
#import "WCNetworkingActivityConsoleLogger.h"
#import "WCNetworkingWrapper.h"
#import <objc/runtime.h>

static NSError * WCNetworkingErrorFromNotification(NSNotification *notification) {
    NSError *error = nil;
    if ([[notification object] isKindOfClass:[NSURLSessionTask class]]) {
        error = [(NSURLSessionTask *)[notification object] error];
        if (!error) {
            error = notification.userInfo[WCNetworkingTaskDidCompleteErrorKey];
        }
    }
    return error;
}

@interface WCNetworkingActivityLogger ()
@property (nonatomic, strong) NSMutableSet *mutableLoggers;

@end

@implementation WCNetworkingActivityLogger

+ (instancetype)sharedLogger {
    static WCNetworkingActivityLogger *_sharedLogger = nil;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedLogger = [[self alloc] init];
    });

    return _sharedLogger;
}

- (id)init {
    self = [super init];
    if (!self) {
        return nil;
    }

    self.mutableLoggers = [NSMutableSet set];

    WCNetworkingActivityConsoleLogger *consoleLogger = [WCNetworkingActivityConsoleLogger new];
    [self addLogger:consoleLogger];

    return self;
}

- (NSSet *)loggers {
    return self.mutableLoggers;
}

- (void)dealloc {
    [self stopLogging];
}

- (void)addLogger:(id<WCNetworkingActivityLoggerProtocol>)logger {
    [self.mutableLoggers addObject:logger];
}

- (void)removeLogger:(id<WCNetworkingActivityLoggerProtocol>)logger {
    [self.mutableLoggers removeObject:logger];
}

- (void)setLogLevel:(WCHTTPRequestLoggerLevel)level {
    for (id<WCNetworkingActivityLoggerProtocol>logger in self.loggers) {
        logger.level = level;
    }
}

- (void)startLogging {
    [self stopLogging];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkRequestDidStart:) name:WCNetworkingTaskDidResumeNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkRequestDidFinish:) name:WCNetworkingTaskDidCompleteNotification object:nil];
}

- (void)stopLogging {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - NSNotification

static void * WCNetworkingRequestStartDate = &WCNetworkingRequestStartDate;

- (void)networkRequestDidStart:(NSNotification *)notification {
    NSURLSessionTask *task = [notification object];
    NSURLRequest *request = task.originalRequest;

    if (!request) {
        return;
    }

    objc_setAssociatedObject(notification.object, WCNetworkingRequestStartDate, [NSDate date], OBJC_ASSOCIATION_RETAIN_NONATOMIC);

    for (id <WCNetworkingActivityLoggerProtocol> logger in self.loggers) {
        if (request && logger.filterPredicate && [logger.filterPredicate evaluateWithObject:request]) {
            return;
        }

        [logger URLSessionTaskDidStart:task];
    }
}

- (void)networkRequestDidFinish:(NSNotification *)notification {
    NSURLSessionTask *task = [notification object];
    NSURLRequest *request = task.originalRequest;
    NSURLResponse *response = task.response;
    NSError *error = WCNetworkingErrorFromNotification(notification);

    if (!request && !response) {
        return;
    }

    id responseObject = nil;
    if (notification.userInfo) {
        responseObject = notification.userInfo[WCNetworkingTaskDidCompleteSerializedResponseKey];
    }

    NSTimeInterval elapsedTime = [[NSDate date] timeIntervalSinceDate:objc_getAssociatedObject(notification.object, WCNetworkingRequestStartDate)];

    for (id <WCNetworkingActivityLoggerProtocol> logger in self.loggers) {
        if (request && logger.filterPredicate && [logger.filterPredicate evaluateWithObject:request]) {
            return;
        }

        [logger URLSessionTaskDidFinish:task withResponseObject:responseObject inElapsedTime:elapsedTime withError:error];
    }
}

@end
