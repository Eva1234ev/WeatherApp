//
//  WeatherReuseView.h
//  WeatherApp
//
//  Created by Eva on 30.08.2019.
//  Copyright © 2019 Eva. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WeatherData;
NS_ASSUME_NONNULL_BEGIN

@interface WeatherReuseView : UIView

@property (strong, nonatomic) WeatherData * weatherData;

-(void)configure;
@property (nonatomic,assign) BOOL weatherCurrentOrCountry;
@end

NS_ASSUME_NONNULL_END
