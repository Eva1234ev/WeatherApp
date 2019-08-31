//
//  CurrentWeatherViewController.m
//  WeatherApp
//
//  Created by Eva on 30.08.2019.
//  Copyright © 2019 Eva. All rights reserved.
//

#import "CurrentWeatherViewController.h"
#import "OpenWeatherMapAPI.h"
#import "WeatherReuseView.h"
#import <CoreLocation/CoreLocation.h>

#define kUpdateInterval 3600
@interface CurrentWeatherViewController ()<CLLocationManagerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *degreesLabel;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) NSDate *lastUpdate;

@end

@implementation CurrentWeatherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.locationManager = [[CLLocationManager alloc] init];
    [self enableLocationServices];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Location Services

- (void)enableLocationServices {
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers;
    
    switch ([CLLocationManager authorizationStatus]) {
        case kCLAuthorizationStatusNotDetermined:
            [self.locationManager requestWhenInUseAuthorization];
            [self.locationManager startUpdatingLocation];
            break;
        case kCLAuthorizationStatusDenied:
        case kCLAuthorizationStatusRestricted:
            [self.locationManager stopUpdatingLocation];
            break;
        case kCLAuthorizationStatusAuthorizedAlways:
        case kCLAuthorizationStatusAuthorizedWhenInUse:
            [self.locationManager startUpdatingLocation];
            break;
        default:
            break;
    }
}

#pragma mark - CLLocationManagerDelegate Methods

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    NSLocale *currentLocale = [NSLocale currentLocale];  // get the current locale.
    NSString *countryCode = [currentLocale objectForKey:NSLocaleCountryCode];
    //NSString *cityCode = [currentLocale objectForKey:NSLocal];
    // If it's a relatively recent event, turn off updates to save power.
    CLLocation* location = [locations lastObject];
    NSDate* eventDate = location.timestamp;
    NSTimeInterval howRecent = [eventDate timeIntervalSinceNow];
   // if (abs(howRecent) < 15.0) {
        // If the event is recent, do something with it.
        NSLog(@"latitude %+.6f, longitude %+.6f\n",
              location.coordinate.latitude,
              location.coordinate.longitude);
  //  }
    if ([[NSDate date] timeIntervalSinceDate:self.lastUpdate] > kUpdateInterval || !self.lastUpdate) {
        
        [[OpenWeatherMapAPI sharedInstance]
         fetchCurrentWeatherDataForLocation:[locations lastObject]
         completion:^(WeatherData *weatherData) {
             
             NSString *currentCountryString = [weatherData currentCountryString];
             
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
                 
                 
               //  self.degreesLabel.text = tempString;
                 self.lastUpdate = [NSDate date];
             });
         }
         failure:^(NSError *error) {
             NSLog(@"Failed: %@",error);
         }
         ];
    }
    

}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    switch (status) {
        case kCLAuthorizationStatusNotDetermined:
            [self.locationManager requestWhenInUseAuthorization];
            [self.locationManager startUpdatingLocation];
            break;
        case kCLAuthorizationStatusDenied:
        case kCLAuthorizationStatusRestricted:
            [self.locationManager stopUpdatingLocation];
            break;
        case kCLAuthorizationStatusAuthorizedAlways:
        case kCLAuthorizationStatusAuthorizedWhenInUse:
            [self.locationManager startUpdatingLocation];
            break;
        default:
            break;
    }
}







@end
