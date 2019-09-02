//
//  CountriesWeatherViewController.m
//  WeatherApp
//
//  Created by Eva on 01.09.2019.
//  Copyright © 2019 Eva. All rights reserved.
//

#import "CountriesWeatherViewController.h"
#import "WeatherCountryTableViewCell.h"
#import "PCCPViewController.h"
#import "WeatherReuseView.h"
#import "JSON.h"
#import "WeatherCountryAPI.h"
#import <CoreLocation/CoreLocation.h>
#import "OpenWeatherMapAPI.h"
#import "LoadingView.h"


@interface CountriesWeatherViewController ()<CLLocationManagerDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) NSMutableArray *weatherCountryList;
@property (weak, nonatomic) IBOutlet UITableView *countryTableView;
@property (nonatomic,strong) WeatherData *weatherData;
@end

@implementation CountriesWeatherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.countryTableView.delegate = self;
    self.weatherCountryList = [[NSMutableArray alloc] init];
    LoadingView *loader = [[LoadingView alloc] init];
    [loader show];
    [WeatherCountryAPI getAllCountriesWithCompletion:^(id response, NSError *error) {
        if (!error) {
            self.weatherCountryList  = [WeatherCountryListData arrayOfModelsFromDictionaries: response error:&error];
            [loader hide];
            [self.countryTableView reloadData];
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
    LoadingView *loader = [[LoadingView alloc] init];
    [loader show];
    CLGeocoder *geoCode = [[CLGeocoder alloc] init];
    [geoCode geocodeAddressString:addressStr completionHandler:^(NSArray *placemarks, NSError *error) {
        if (!error) {
             [loader hide];
            CLPlacemark *place = [placemarks objectAtIndex:0];
            CLLocation *location = place.location;
            [[OpenWeatherMapAPI sharedInstance]
             fetchCurrentWeatherDataForLocation:location
             completion:^(WeatherData *weatherData) {
               
                 dispatch_async(dispatch_get_main_queue(), ^{
                     
                    WeatherReuseView* sView = [[NSBundle mainBundle] loadNibNamed:@"WeatherReuseView" owner:self options:nil].firstObject;
                     sView.frame = UIScreen.mainScreen.bounds;   
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
