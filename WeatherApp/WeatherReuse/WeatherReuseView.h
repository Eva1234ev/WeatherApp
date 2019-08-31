//
//  WeatherReuseView.h
//  WeatherApp
//
//  Created by Eva on 30.08.2019.
//  Copyright © 2019 Eva. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WeatherData;
NS_ASSUME_NONNULL_BEGIN

@interface WeatherReuseView : UIView
@property (weak, nonatomic) IBOutlet UILabel *countryLabel;
@property (weak, nonatomic) IBOutlet UILabel *tempreatureLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;

@property (weak, nonatomic) IBOutlet UIImageView *weatherImageView;
@property (strong, nonatomic) WeatherData * weatherData;
-(void)showAlert:(NSString*)message;
-(void)configure;
@end

NS_ASSUME_NONNULL_END
