//
//  WeatherCountryTableViewCell.h
//  WeatherApp
//
//  Created by Eva on 31.08.2019.
//  Copyright © 2019 Eva. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeatherCountryListData.h"
NS_ASSUME_NONNULL_BEGIN

@interface WeatherCountryTableViewCell : UITableViewCell

-(void)weatherCountry: (WeatherCountryListData*) weatherCountry;
@end

NS_ASSUME_NONNULL_END
