//
//  DealershipTableViewCell.h
//  Dealerships
//
//  Created by Home on 5/10/16.
//  Copyright © 2016 Kumar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Dealership.h"

@interface DealershipTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *dealershipImageView;

@property (weak, nonatomic) IBOutlet UILabel *delearshipNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *dealershipAddressLabel;

@property (weak, nonatomic) IBOutlet UILabel *dealershipDistanceLabel;

- (void)fillWithDealership:(Dealership *)dealership;

@end
