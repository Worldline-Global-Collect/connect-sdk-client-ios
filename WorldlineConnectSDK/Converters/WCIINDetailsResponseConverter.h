//
//  WCIINDetailsResponseConverter.h
//  WorldlineConnectSDK
//
//  Created for Worldline Global Collect on 15/12/2016.
//  Copyright © 2017 Worldline Global Collect. All rights reserved.
//

#import <Foundation/Foundation.h>
#import  "WCIINDetailsResponse.h"

@interface WCIINDetailsResponseConverter : NSObject

- (WCIINDetailsResponse *)IINDetailsResponseFromJSON:(NSDictionary *)rawIINDetailsResponse;

@end
