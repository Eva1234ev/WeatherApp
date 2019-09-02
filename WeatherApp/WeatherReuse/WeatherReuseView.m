//
//  WeatherReuseView.m
//  WeatherApp
//
//  Created by Eva on 30.08.2019.
//  Copyright © 2019 Eva. All rights reserved.
//

#import "WeatherReuseView.h"
#import "AppDelegate.h"
#import "WeatherData.h"
#import <SDWebImage/SDWebImage.h>

@interface WeatherReuseView()
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


@implementation WeatherReuseView


- (IBAction)closeButtinAction:(id)sender {
   [self removeFromSuperview];
    
}
 
-(void)configure {
    self.weatherImageView.layer.cornerRadius = self.weatherImageView.frame.size.width/2;
    self.weatherImageView.layer.masksToBounds = YES;
  
    if (self.weatherCurrentOrCountry)
       
    {
        self.closeButton.hidden = YES;
    }
    else{
         self.closeButton.hidden = NO;
    }
    self.countryLabel.text = self.weatherData.name;
    double tmin = [self convertFahrenheitToCelsis:self.weatherData.temp_min];
    double tmax = [self convertFahrenheitToCelsis:self.weatherData.temp_max];
    NSString *temp = [ NSString stringWithFormat:@"%d° - %d°", (int)tmax,(int)tmin];
    if(tmin < 0){
        temp = [ NSString stringWithFormat:@"%d°,%d°", (int)tmax,(int)tmin];
    }
    self.tempreatureLabel.text = temp;
    self.descriptionLabel.text = self.weatherData.desc;
    self.cloudsLabel.text = [@"Cloud - " stringByAppendingString:[[self.weatherData.clouds stringValue] stringByAppendingString:@" %"]];
    
    NSNumberFormatter *decimalStyleFormatter = [[NSNumberFormatter alloc] init];
    [decimalStyleFormatter setMaximumFractionDigits:2];
    NSString *resultStringSpeed = [decimalStyleFormatter stringFromNumber:self.weatherData.speed];
    self.windSpeedLabel.text = [@"Wind Speed - " stringByAppendingString:resultStringSpeed];
    
    self.windDirection.text = [[@"Wind Direction - "stringByAppendingString:[self.weatherData.deg stringValue]]stringByAppendingString:@" km/h"];
    self.humidityLabel.text =[[ @"Humidity - " stringByAppendingString:[self.weatherData.humidity stringValue]] stringByAppendingString:@" %"];
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





@end
