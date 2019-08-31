//
//  OpenWeatherMapAPI.h
//  WeatherApp
//
//  Created by Eva on 30.08.2019.
//  Copyright © 2019 Eva. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "WeatherData.h"
NS_ASSUME_NONNULL_BEGIN

@interface OpenWeatherMapAPI : NSObject

+ (OpenWeatherMapAPI *)sharedInstance;

- (void)fetchCurrentWeatherDataForLocation:(CLLocation *)location completion:(void(^)(WeatherData *weatherData))completion failure:(void(^)(NSError* error))failure;

@end


NS_ASSUME_NONNULL_END
