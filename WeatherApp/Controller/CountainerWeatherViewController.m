//
//  CountainerWeatherViewController.m
//  WeatherApp
//
//  Created by Eva on 01.09.2019.
//  Copyright © 2019 Eva. All rights reserved.
//

#import "CountainerWeatherViewController.h"
#import "AppDelegate.h"
#import "WeatherData.h"
#import <SDWebImage/SDWebImage.h>
#import "CurrentWeatherDelegate.h"
#import "CurrentWeatherViewController.h"

@interface CountainerWeatherViewController ()<CurrentWeatherDelegate>
@property (weak, nonatomic) IBOutlet UIButton *closeButton;
@property (weak, nonatomic) IBOutlet UILabel *countryLabel;
@property (weak, nonatomic) IBOutlet UILabel *tempreatureLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *cloudsLabel;
@property (weak, nonatomic) IBOutlet UILabel *windSpeedLabel;
@property (weak, nonatomic) IBOutlet UILabel *windDirection;
@property (weak, nonatomic) IBOutlet UILabel *humidityLabel;
@property (weak, nonatomic) IBOutlet UILabel *pressureLabel;
@property (weak, nonatomic) IBOutlet UIImageView *weatherImageView;

@end

@implementation CountainerWeatherViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    CurrentWeatherViewController *currentDelegate = [[CurrentWeatherViewController alloc]init];
    currentDelegate.delegate = self;
//    
    if(self.weatherData){
       [self configure];
    }

}

- (IBAction)closeButtinAction:(id)sender {
    
    
}


-(void)configure {

    self.countryLabel.text = self.weatherData.name;
    double tmin = [self convertFahrenheitToCelsis:self.weatherData.temp_min];
    double tmax = [self convertFahrenheitToCelsis:self.weatherData.temp_max];
    self.tempreatureLabel.text = [ NSString stringWithFormat:@"%d° - %d°", (int)tmax,(int)tmin];
    self.descriptionLabel.text = self.weatherData.desc;
    self.cloudsLabel.text = [@"Cloud - " stringByAppendingString:[[self.weatherData.clouds stringValue] stringByAppendingString:@" %"]];
    self.windSpeedLabel.text = [@"Wind Speed - " stringByAppendingString:[self.weatherData.speed stringValue]];
    self.windDirection.text = [@"Wind Direction - "stringByAppendingString:[self.weatherData.deg stringValue]];
    self.humidityLabel.text =[ @"Humidity - " stringByAppendingString:[self.weatherData.humidity stringValue]];
    self.pressureLabel.text = [@"Pressure (Atmsp.) - " stringByAppendingString:[self.weatherData.pressure stringValue]];
    NSString *urlImage = [[@"https://openweathermap.org/img/w/" stringByAppendingString:self.weatherData.icon] stringByAppendingString:@".png"];
    [self.weatherImageView sd_setImageWithURL:[NSURL URLWithString:urlImage]
                             placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    
    
}

-(double) convertFahrenheitToCelsis:(NSNumber*)temp {
    //Fahrenheit to Celsius conversion (°F to °C)
    //(°F − 32) × 5/9 = °C
    return (([temp doubleValue]- 32)*5/9);
}


- (IBAction)addButtonAction:(UIButton *)sender {
    
    
}
- (IBAction)alertHide:(UIButton *)sender {
}
- (IBAction)cancelButtonAction:(UIButton *)sender {
    
}



- (void)getWeatherData:(WeatherData *)weatherData {
   // self.weatherData=weatherData;
    //[self configure];
    
}


@end
