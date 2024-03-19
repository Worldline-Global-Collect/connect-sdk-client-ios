//
//  WCConstants.h
//  WorldlineConnectSDK
//
//  Created for Worldline Global Collect on 15/12/2016.
//  Copyright © 2017 Worldline Global Collect. All rights reserved.
//

#ifndef WorldlineConnectSDK_WCSDKConstants_h
#define WorldlineConnectSDK_WCSDKConstants_h
#import  "WCSession.h"

//Keys
#define kWCSDKLocalizable           @"WCSDKLocalizable"
#define kWCImageMapping             @"kWCImageMapping"
#define kWCImageMappingInitialized  @"kWCImageMappingInitialized"
#define kWCIINMapping               @"kWCIINMapping"
#define kWCSDKBundlePath            [[NSBundle bundleForClass:[WCSession class]] pathForResource:@"WorldlineConnectSDK" ofType:@"bundle"]
#define kWCAPIVersion               @"client/v1"

#define StandardUserDefaults        [NSUserDefaults standardUserDefaults]
#define DocumentsFolderPath         [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]
#define kWCAndroidPayIdentifier        @"320"
#define kWCApplePayIdentifier          @"302"

#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

#endif
