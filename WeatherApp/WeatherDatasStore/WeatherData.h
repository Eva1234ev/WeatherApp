//
//  WeatherData.h
//  WeatherApp
//
//  Created by Eva on 30.08.2019.
//  Copyright © 2019 Eva. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel/JSONModel.h>
NS_ASSUME_NONNULL_BEGIN

@interface WeatherData : JSONModel
@property (strong, nonatomic) NSString *desc;
@property (strong, nonatomic) NSString *main;
@property (strong, nonatomic) NSString *icon;
@property (strong, nonatomic) NSNumber *temp;
@property (strong, nonatomic) NSNumber *pressure;
@property (strong, nonatomic) NSNumber *humidity;
@property (strong, nonatomic) NSNumber *temp_min;
@property (strong, nonatomic) NSNumber *temp_max;

@property (strong, nonatomic) NSString *country;
@property (strong, nonatomic) NSString *sunrise;
@property (strong, nonatomic) NSString *sunset;
@property (strong, nonatomic) NSNumber *clouds;
@property (strong, nonatomic) NSNumber *speed;
@property (strong, nonatomic) NSNumber *deg;
@property (strong, nonatomic) NSString *name;

-(id)initWithJSON:(NSData *)jsonData;
@end


NS_ASSUME_NONNULL_END
