//
//  CountainerWeatherViewController.h
//  WeatherApp
//
//  Created by Eva on 01.09.2019.
//  Copyright © 2019 Eva. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WeatherData;
NS_ASSUME_NONNULL_BEGIN

@interface CountainerWeatherViewController : UIViewController
@property (strong, nonatomic) WeatherData * weatherData;
@end

NS_ASSUME_NONNULL_END
