//
//  WCPaymentItemDisplayHints.h
//  WorldlineConnectSDK
//
//  Created for Worldline Global Collect on 15/12/2016.
//  Copyright © 2017 Worldline Global Collect. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface WCPaymentItemDisplayHints : NSObject

@property (nonatomic) NSUInteger displayOrder;
@property (strong, nonatomic) NSString *label;
@property (strong, nonatomic) NSString *logoPath;
@property (strong, nonatomic) UIImage *logoImage;

@end
