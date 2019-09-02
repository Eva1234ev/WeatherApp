//
//  WeatherCountryAPI.m
//  WeatherApp
//
//  Created by Eva on 31.08.2019.
//  Copyright © 2019 Eva. All rights reserved.
//


#import "WeatherCountryAPI.h"
#import "JSON.h"


@implementation WeatherCountryAPI
+ (void)getAllCountriesWithCompletion:( void (^) (id response, NSError *error))handler {

    NSString* method = @"https://api.myjson.com/bins/7zl73";//@"http://vocab.nic.in/rest.php/country/json";
    NSMutableURLRequest *request = [self requestForGetMethod:method withParams:nil];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [self executeRequestURL:request withCompletion:handler];
    
}

+ (NSMutableURLRequest *) requestForGetMethod:(NSString *)method withParams:(NSString *)params {
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:method] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:60.0f];
    [request setHTTPMethod:@"GET"];
    return request;
    
}
+ (void)executeRequestURL:(NSURLRequest*)request withCompletion:( void (^) (id response, NSError *error))handler  {
    
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        dispatch_async(dispatch_get_main_queue(), ^(void){
            handler([data objectFromJSONData], error);
            
        });
        
    }] resume];
    
    
}
@end
