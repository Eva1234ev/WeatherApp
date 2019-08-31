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

@end
@implementation WeatherReuseView


- (IBAction)closeButtinAction:(id)sender {
    
    
}

-(void)showAlert:(NSString*)message {
    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:@""
                                 message:message
                                 preferredStyle:UIAlertControllerStyleAlert];
    
    //Add Buttons
    
    UIAlertAction* yesButton = [UIAlertAction
                                actionWithTitle:@"Ok"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action) {
                                    //Handle your yes please button action here
                                }];
    
    
    //Add your buttons to alert controller
    
    [alert addAction:yesButton];
    UIViewController *rootController = [[(AppDelegate*)
                                         [[UIApplication sharedApplication]delegate] window] rootViewController];
    [rootController presentViewController:alert animated:YES completion:nil];
}

-(void)configure {
    self.countryLabel.text = self.weatherData.name;
    
    //Fahrenheit to Celsius conversion (°F to °C)
    //(°F − 32) × 5/9 = °C
    double tmin = (([self.weatherData.temp_min doubleValue]- 32)*5/9);
    double tmax = (([self.weatherData.temp_max doubleValue]- 32)*5/9);
    self.tempreatureLabel.text = [ NSString stringWithFormat:@"%d° - %d°", (int)tmax,(int)tmin];
    self.descriptionLabel.text = self.weatherData.desc;
    NSString *urlImage = [[@"https://openweathermap.org/img/w/" stringByAppendingString:self.weatherData.icon] stringByAppendingString:@".png"];
    [self.weatherImageView sd_setImageWithURL:[NSURL URLWithString:urlImage]
                                placeholderImage:[UIImage imageNamed:@"placeholder.png"]];

    
}



- (IBAction)addButtonAction:(UIButton *)sender {
  
    
}
- (IBAction)alertHide:(UIButton *)sender {
}
- (IBAction)cancelButtonAction:(UIButton *)sender {
   
}


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
