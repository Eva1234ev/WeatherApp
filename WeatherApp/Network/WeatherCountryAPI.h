//
//  WeatherCountryAPI.h
//  WeatherApp
//
//  Created by Eva on 31.08.2019.
//  Copyright © 2019 Eva. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WeatherCountryAPI : NSObject
+ (void)getAllCountriesWithCompletion:( void (^) (id response, NSError *error))handler;
@end

NS_ASSUME_NONNULL_END
