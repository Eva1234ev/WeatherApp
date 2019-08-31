//
//  WeatherCountryListData.h
//  WeatherApp
//
//  Created by Eva on 30.08.2019.
//  Copyright © 2019 Eva. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <JSONModel/JSONModel.h>
NS_ASSUME_NONNULL_BEGIN
@class WeatherCountry;
@protocol WeatherCountry;

@interface WeatherCountry : JSONModel
@property (strong, nonatomic) NSString *country_name;
@property (strong, nonatomic) NSString *country_id;
@end

@interface WeatherCountryListData : JSONModel
@property (strong, nonatomic)  WeatherCountry *country;

@end

NS_ASSUME_NONNULL_END
