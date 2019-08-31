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
#import <SDWebImage/SDWebImage.h>
#import "PCCPViewController.h"
#import "WeatherReuseView.h"
#import "JSON.h"
#import "WeatherCountryAPI.h"
#import <CoreLocation/CoreLocation.h>

#define kUpdateInterval 3600

@interface WeatherCountryListTableViewController ()<CLLocationManagerDelegate>
@property (nonatomic,strong) NSMutableArray *weatherCountryList;

@end


@implementation WeatherCountryListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.weatherCountryList = [[NSMutableArray alloc] init];
    [WeatherCountryAPI getAllCountriesWithCompletion:^(id response, NSError *error) {
        if (!error) {
       
        self.weatherCountryList  = [WeatherCountryListData  arrayOfModelsFromDictionaries: response[@"countries"] error:&error];
            [self.tableView reloadData];
        }
    }];


}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  self.weatherCountryList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *weatherCountryTableViewCell = @"WeatherCountryTableViewCell";
    
    WeatherCountryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:weatherCountryTableViewCell];
    if (cell == nil) {
        cell = [[WeatherCountryTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:weatherCountryTableViewCell];
    }

    WeatherCountryListData * weather = [self.weatherCountryList objectAtIndex:indexPath.row];
    WeatherCountry *w = weather.country;
    NSDictionary *d = w;

    cell.countryLabel.text = [d objectForKey:@"country_name"];

    NSString* url_Img_FULL = [[@"https://www.countryflags.io/" stringByAppendingString:[d objectForKey:@"country_id"]] stringByAppendingString:@"/flat/64.png"];
    // Get country flag image by country code
    UIImage * flag = [PCCPViewController imageForCountryCode:[d objectForKey:@"country_id"]];
    [cell.countryFlagImageView sd_setImageWithURL:[NSURL URLWithString:url_Img_FULL]
                                placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    return  cell;
    }
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    WeatherCountryListData * weather = [self.weatherCountryList objectAtIndex:indexPath.row];
//    NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"WeatherReuseView"
//                                                          owner:self
//                                                        options:nil];
//
//    WeatherReuseView* sView = arrayOfViews[0];
//    sView.frame = UIScreen.mainScreen.bounds;
//    sView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.05f];
//    sView.weatherData = weather;
//    [self.view addSubview:sView];
//    [sView configure];
    
    
    WeatherCountry *w = weather.country;
    NSDictionary *d = w;
    
    [self getLocationFromAddressString:[d objectForKey:@"country_name"]];
    
}
-(void) getLocationFromAddressString: (NSString*) addressStr {
    double latitude = 0, longitude = 0;
    NSString *esc_addr =  [addressStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *req = [NSString stringWithFormat:@"http://maps.google.com/maps/api/geocode/json?sensor=false&address=%@", esc_addr];
    NSString *result = [NSString stringWithContentsOfURL:[NSURL URLWithString:req] encoding:NSUTF8StringEncoding error:NULL];
    if (result) {
        NSScanner *scanner = [NSScanner scannerWithString:result];
        if ([scanner scanUpToString:@"\"lat\" :" intoString:nil] && [scanner scanString:@"\"lat\" :" intoString:nil]) {
            [scanner scanDouble:&latitude];
            if ([scanner scanUpToString:@"\"lng\" :" intoString:nil] && [scanner scanString:@"\"lng\" :" intoString:nil]) {
                [scanner scanDouble:&longitude];
            }
        }
    }
    CLLocationCoordinate2D center;
    center.latitude=latitude;
    center.longitude = longitude;
    NSLog(@"View Controller get Location Logitute : %f",center.latitude);
    NSLog(@"View Controller get Location Latitute : %f",center.longitude);
    
//
//    [[OpenWeatherMapAPI sharedInstance]
//     fetchCurrentWeatherDataForLocation:[locations lastObject]
//     completion:^(WeatherData *weatherData) {
//
//         NSString *currentCountryString = [weatherData currentCountryString];
//
//         dispatch_async(dispatch_get_main_queue(), ^{
//             NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"WeatherReuseView"
//                                                                   owner:self
//                                                                 options:nil];
//
//             WeatherReuseView* sView = arrayOfViews[0];
//             sView.frame = UIScreen.mainScreen.bounds;
//             sView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.05f];
//             sView.weatherData = weatherData;
//             [self.view addSubview:sView];
//             [sView configure];
//
//
//             //  self.degreesLabel.text = tempString;
//             self.lastUpdate = [NSDate date];
//         });
//     }
//     failure:^(NSError *error) {
//         NSLog(@"Failed: %@",error);
//     }
//     ];
   // return center;
    
}

@end
