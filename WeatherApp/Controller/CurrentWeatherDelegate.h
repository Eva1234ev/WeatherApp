
//
//  Created by Eva on 09.08.2019.
//  Copyright © 2019 Eva. All rights reserved.
//

#import <Foundation/Foundation.h>
@class WeatherData;



@protocol CurrentWeatherDelegate

- (void)getWeatherData:(WeatherData *) weatherData;

@end


