//
//  WeatherCountryTableViewCell.m
//  WeatherApp
//
//  Created by Eva on 31.08.2019.
//  Copyright © 2019 Eva. All rights reserved.
//

#import "WeatherCountryTableViewCell.h"
#import <SDWebImage/SDWebImage.h>

@interface WeatherCountryTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *countryLabel;
@property (weak, nonatomic) IBOutlet UIImageView *countryFlagImageView;
@end

@implementation WeatherCountryTableViewCell


- (void)awakeFromNib {
    [super awakeFromNib];
  
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}
-(void)weatherCountry: (WeatherCountryListData *) weatherCountry
{
    self.countryLabel.text = weatherCountry.name;
    NSString* url_Img_FULL = [[@"https://www.countryflags.io/" stringByAppendingString:weatherCountry.code] stringByAppendingString:@"/flat/64.png"];
    //  Get country flag image by country code
    //  UIImage * flag = [PCCPViewController imageForCountryCode:[d objectForKey:@"country_id"]];
    [self.countryFlagImageView sd_setImageWithURL:[NSURL URLWithString:url_Img_FULL]
                                  placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
}
@end
