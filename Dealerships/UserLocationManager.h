//
//  UserLocationManager.h
//  Dealerships
//
//  Created by Home on 5/10/16.
//  Copyright © 2016 Kumar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface UserLocationManager : NSObject

@property (nonatomic, strong) CLLocation *lastKnownLocation;

+ (id)sharedManager;

@end
