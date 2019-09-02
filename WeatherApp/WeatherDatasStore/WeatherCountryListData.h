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

@interface WeatherCountryListData : JSONModel
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *code;

@end
NS_ASSUME_NONNULL_END
