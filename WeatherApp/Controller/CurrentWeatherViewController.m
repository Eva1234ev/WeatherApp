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
#import "AnimatedGIFImageSerialization.h"


#define kUpdateInterval 3600
@interface CurrentWeatherViewController ()<CLLocationManagerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *degreesLabel;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) NSDate *lastUpdate;
@property (weak, nonatomic) IBOutlet UIView *containerCurrentWeatherView;
@property (weak, nonatomic) IBOutlet UIImageView *gifImageView;
@property (strong, nonatomic) WeatherData *weatherData;
@end

@implementation CurrentWeatherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.containerCurrentWeatherView.hidden=YES;
    self.locationManager = [[CLLocationManager alloc] init];
    [self enableLocationServices];
}

-(void)addGif{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    imageView.image = [UIImage imageNamed:@"weathergif.gif"];
    [self.view addSubview:imageView];

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
    if ([[NSDate date] timeIntervalSinceDate:self.lastUpdate] > kUpdateInterval || !self.lastUpdate) {
        [[OpenWeatherMapAPI sharedInstance]
         fetchCurrentWeatherDataForLocation:[locations lastObject]
         completion:^(WeatherData *weatherData) {
             dispatch_async(dispatch_get_main_queue(), ^{
                 
                 WeatherReuseView* sView = [[NSBundle mainBundle] loadNibNamed:@"WeatherReuseView" owner:self options:nil].firstObject;
                 sView.frame = UIScreen.mainScreen.bounds;
                 sView.weatherCurrentOrCountry=YES;
                 sView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.05f];
                 sView.weatherData = weatherData;
                 [self.view addSubview:sView];
                 [sView configure];
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
