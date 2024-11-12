//
//  WCIINStatus.h
//  WorldlineConnectSDK
//
//  Created for Worldline Global Collect on 15/12/2016.
//  Copyright © 2017 Worldline Global Collect. All rights reserved.
//

#ifndef WCIINStatus_h
#define WCIINStatus_h

typedef enum {
    WCSupported,
    WCUnsupported,
    WCUnknown,
    WCNotEnoughDigits,
    WCPending,
    WCExistingButNotAllowed
} WCIINStatus;

#endif
