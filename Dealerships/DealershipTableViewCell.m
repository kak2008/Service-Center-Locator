//
//  DealershipTableViewCell.m
//  Dealerships
//
//  Created by Home on 5/10/16.
//  Copyright © 2016 Kumar. All rights reserved.
//

#import "DealershipTableViewCell.h"

@implementation DealershipTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _delearshipNameLabel.font       = [UIFont systemFontOfSize:22];
    _dealershipDistanceLabel.font   = [UIFont systemFontOfSize:13];
    _dealershipAddressLabel.font    = [UIFont systemFontOfSize:12];
    
    _dealershipAddressLabel.textColor = [UIColor lightGrayColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)fillWithDealership:(Dealership *)dealership {
    _delearshipNameLabel.text = dealership.name;
    _dealershipAddressLabel.text = [NSString stringWithFormat:@"%@ \n%@, %@ - %@", dealership.street, dealership.city, dealership.state, dealership.zip];
    _dealershipDistanceLabel.text = [NSString stringWithFormat:@"%0.2f %@", dealership.value, dealership.unit];
}

@end
