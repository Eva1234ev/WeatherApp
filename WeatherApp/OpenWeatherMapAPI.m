//
//  OpenWeatherMapAPI.m
//  WeatherApp
//
//  Created by Eva on 30.08.2019.
//  Copyright © 2019 Eva. All rights reserved.
//

#import "OpenWeatherMapAPI.h"

@implementation OpenWeatherMapAPI


+ (OpenWeatherMapAPI *)sharedInstance {
    static OpenWeatherMapAPI *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[OpenWeatherMapAPI alloc] init];
    });
    return sharedInstance;
}

- (void)fetchCurrentWeatherDataForLocation:(CLLocation *)location completion:(void(^)(WeatherData *weatherData))completion failure:(void(^)(NSError* error))failure{
    float latitude = location.coordinate.latitude;
    float longitude = location.coordinate.longitude;
    

    //  NSString *urlString = [NSString stringWithFormat:@"http://api.openweathermap.org/data/2.5/weather?lat=%f&lon=%f&units=imperial&appid=%s",latitude,longitude,kOpenWeatherMapAPIKey];
    //a28594d3377e9f55a918b16a30100b16
    
    NSString *urlString = [NSString stringWithFormat:@"http://api.openweathermap.org/data/2.5/weather?lat=%f&lon=%f&units=imperial&appid=a28594d3377e9f55a918b16a30100b16",latitude,longitude];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURL *url = [NSURL URLWithString:urlString];
    
    [[session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error){
        if(error) {
            failure(error);
        } else {
            WeatherData *weather = [[WeatherData alloc] initWithJSON:data];
            completion(weather);
        }
        
    }] resume];
}
@end
