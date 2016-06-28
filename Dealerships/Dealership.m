//
//  Dealership.m
//  Dealerships
//
//  Created by Home on 5/10/16.
//  Copyright © 2016 Kumar. All rights reserved.
//

#import "Dealership.h"

static NSString *kNameKey = @"name";

static NSString *kDistanceKey = @"distance";
static NSString *kDistanceValueKey = @"value";
static NSString *kDistanceUnitKey = @"unit";

static NSString *kAddressKey = @"address";
static NSString *kStreetAddressKey = @"street";
static NSString *kCityKey = @"city";
static NSString *kStateKey = @"state";
static NSString *kZipcodeKey = @"zipcode";

@implementation Dealership

- (id)initWithDictionary:(NSDictionary *)details {
    self = [super init];
    if (self) {
        if (![self isNull:details key:kNameKey]) {
            self.name = [details objectForKey:kNameKey];
        }
        
        if (![self isNull:details key:kAddressKey]) {
            
            NSDictionary *addressDictionary = [details objectForKey:kAddressKey];
            
            if (![self isNull:addressDictionary key:kStreetAddressKey]) {
                self.street = [addressDictionary objectForKey:kStreetAddressKey];
            }
            
            if (![self isNull:addressDictionary key:kCityKey]) {
                self.city = [addressDictionary objectForKey:kCityKey];
            }
            
            if (![self isNull:addressDictionary key:kStateKey]) {
                self.state = [addressDictionary objectForKey:kStateKey];
            }
            
            if (![self isNull:addressDictionary key:kZipcodeKey]) {
                self.zip = [addressDictionary objectForKey:kZipcodeKey];
            }
        }
        
        if (![self isNull:details key:kDistanceKey]) {
            
            NSDictionary *distanceDetails = [details objectForKey:kDistanceKey];
            
            if (![self isNull:distanceDetails key:kDistanceUnitKey]) {
                self.unit = [distanceDetails objectForKey:kDistanceUnitKey];
            }
            
            if (![self isNull:distanceDetails key:kDistanceValueKey]) {
                self.value = [[distanceDetails objectForKey:kDistanceValueKey] floatValue];
            }
        }
    }
    
    return self;
}

- (BOOL)isNull:(NSDictionary *)dictionary key:(NSString *)key {
    return (!dictionary || ![dictionary objectForKey:key] || [dictionary objectForKey:key] == [NSNull null]);
}

@end
