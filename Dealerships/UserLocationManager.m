//
//  UserLocationManager.m
//  Dealerships
//
//  Created by Home on 5/10/16.
//  Copyright © 2016 Kumar. All rights reserved.
//

#import "UserLocationManager.h"

static UserLocationManager *manager = nil;

@interface UserLocationManager ()<CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;

@end

@implementation UserLocationManager

- (void)initLocationManager {
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    [self.locationManager requestWhenInUseAuthorization];
}

+ (id)sharedManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[UserLocationManager alloc] init];
        [manager initLocationManager];
    });
    
    return manager;
}

#pragma mark - Location Manager Delegate Methods

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    if (status == kCLAuthorizationStatusAuthorizedWhenInUse) {
        [manager startUpdatingLocation];
        return;
    }
    else if (status == kCLAuthorizationStatusDenied) {
        [manager stopUpdatingLocation];
        return;
    }
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    if (error) {
        NSLog(@"Location manager failed with error: %@", error.localizedDescription);
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    self.lastKnownLocation = [locations lastObject];
}

@end
