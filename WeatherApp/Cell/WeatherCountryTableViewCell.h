//
//  WeatherCountryTableViewCell.h
//  WeatherApp
//
//  Created by Eva on 31.08.2019.
//  Copyright © 2019 Eva. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WeatherCountryTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *countryLabel;
@property (weak, nonatomic) IBOutlet UIImageView *countryFlagImageView;

@end

NS_ASSUME_NONNULL_END
