//
//  Dealership.h
//  Dealerships
//
//  Created by Home on 5/10/16.
//  Copyright © 2016 Kumar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Dealership : NSObject

@property (nonatomic, strong) NSString *name;

@property (nonatomic) float value;
@property (nonatomic, strong) NSString *unit;

@property (nonatomic, strong) NSString *street;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *state;
@property (nonatomic, strong) NSString *zip;

- (id)initWithDictionary:(NSDictionary *)details;

@end
