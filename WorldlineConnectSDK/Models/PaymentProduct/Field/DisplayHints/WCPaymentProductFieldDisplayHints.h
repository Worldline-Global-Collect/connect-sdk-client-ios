//
//  WCPaymentProductFieldDisplayHints.h
//  WorldlineConnectSDK
//
//  Created for Worldline Global Collect on 15/12/2016.
//  Copyright © 2017 Worldline Global Collect. All rights reserved.
//

#import <Foundation/Foundation.h>

#import  "WCPreferredInputType.h"
#import  "WCFormElement.h"
#import  "WCToolTip.h"

@interface WCPaymentProductFieldDisplayHints : NSObject

@property (nonatomic) BOOL alwaysShow;
@property (nonatomic) NSInteger displayOrder;
@property (strong, nonatomic) WCFormElement *formElement;
@property (strong, nonatomic) NSString *mask;
@property (nonatomic) BOOL obfuscate;
@property (nonatomic) WCPreferredInputType preferredInputType;
@property (strong, nonatomic) WCTooltip *tooltip;
@property (strong, nonatomic) NSString *label;
@property (strong, nonatomic) NSString *placeholderLabel;
@property (strong, nonatomic) NSURL *link;

@end
