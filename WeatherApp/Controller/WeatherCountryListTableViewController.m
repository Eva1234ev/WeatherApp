//
//  WeatherCountryListTableViewController.m
//  WeatherApp
//
//  Created by Eva on 30.08.2019.
//  Copyright © 2019 Eva. All rights reserved.
//

#import "WeatherCountryListTableViewController.h"
#import "WeatherCountryListData.h"
#import "WeatherCountryTableViewCell.h"
#import "PCCPViewController.h"
#import "WeatherReuseView.h"
#import "JSON.h"
#import "WeatherCountryAPI.h"
#import <CoreLocation/CoreLocation.h>
#import "OpenWeatherMapAPI.h"


@interface WeatherCountryListTableViewController ()<CLLocationManagerDelegate>
@property (nonatomic,strong) NSMutableArray *weatherCountryList;
@end


@implementation WeatherCountryListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.weatherCountryList = [[NSMutableArray alloc] init];
    [WeatherCountryAPI getAllCountriesWithCompletion:^(id response, NSError *error) {
        if (!error) {
            self.weatherCountryList  = [WeatherCountryListData  arrayOfModelsFromDictionaries: response error:&error];
            //self.weatherCountryList  = [WeatherCountryListData  arrayOfModelsFromDictionaries: response[@"countries"] error:&error];
            [self.tableView reloadData];
        }
    }];
    
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  self.weatherCountryList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 50;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *weatherCountryTableViewCell = @"WeatherCountryTableViewCell";
    
    WeatherCountryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:weatherCountryTableViewCell];
    if (cell == nil) {
        cell = [[WeatherCountryTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:weatherCountryTableViewCell];
    }
    
    WeatherCountryListData * weather = [self.weatherCountryList objectAtIndex:indexPath.row];
    [cell weatherCountry: weather];

    return  cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    WeatherCountryListData * weather = [self.weatherCountryList objectAtIndex:indexPath.row];
    [self getLocationFromAddressString:weather.name];
    
}



-(void) getLocationFromAddressString: (NSString*) addressStr {
    CLGeocoder *geoCode = [[CLGeocoder alloc] init];
    [geoCode geocodeAddressString:addressStr completionHandler:^(NSArray *placemarks, NSError *error) {
        if (!error) {
            CLPlacemark *place = [placemarks objectAtIndex:0];
            CLLocation *location = place.location;
            [[OpenWeatherMapAPI sharedInstance]
             fetchCurrentWeatherDataForLocation:location
             completion:^(WeatherData *weatherData) {
                 
                 dispatch_async(dispatch_get_main_queue(), ^{
                     NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"WeatherReuseView"
                                                                           owner:self
                                                                         options:nil];
                     
                     WeatherReuseView* sView = arrayOfViews[0];
                     sView.frame = UIScreen.mainScreen.bounds;
                     sView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.05f];
                     sView.weatherData = weatherData;
                     [self.view addSubview:sView];
                     [sView configure];
                     
                     
                 });
             }
             failure:^(NSError *error) {
                 NSLog(@"Failed: %@",error);
             }
             ];
        }
        
    }];

    
}


@end
