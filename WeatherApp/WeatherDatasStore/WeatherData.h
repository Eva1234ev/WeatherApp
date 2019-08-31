//
//  WeatherData.h
//  WeatherApp
//
//  Created by Eva on 30.08.2019.
//  Copyright © 2019 Eva. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel/JSONModel.h>
NS_ASSUME_NONNULL_BEGIN


@interface WeatherData : JSONModel

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *main;
@property (strong, nonatomic) NSString *icon;
@property (strong, nonatomic) NSString *desc;
@property (strong, nonatomic) NSNumber *temp;
@property (strong, nonatomic) NSNumber *pressure;
@property (strong, nonatomic) NSNumber *humidity;
@property (strong, nonatomic) NSNumber *temp_min;
@property (strong, nonatomic) NSNumber *temp_max;
@property (strong, nonatomic) NSNumber *wind_speed;
@property (strong, nonatomic) NSNumber *wind_deg;

//@property (nonatomic, strong) NSDate *date;
//@property (nonatomic, strong) NSNumber *humidity;
//@property (nonatomic, strong) NSNumber *temperature;
//@property (nonatomic, strong) NSNumber *tempHigh;
//@property (nonatomic, strong) NSNumber *tempLow;
//@property (nonatomic, strong) NSString *locationName;
//@property (nonatomic, strong) NSDate *sunrise;
//@property (nonatomic, strong) NSDate *sunset;
//@property (nonatomic, strong) NSString *conditionDescription;
//@property (nonatomic, strong) NSString *condition;
//@property (nonatomic, strong) NSNumber *windBearing;
//@property (nonatomic, strong) NSNumber *windSpeed;
//@property (nonatomic, strong) NSString *icon;


//@property (strong, nonatomic) NSString *name;
//@property (strong, nonatomic) NSString *main;
//@property (strong, nonatomic) NSString *desc;
//@property (strong, nonatomic) NSNumber *temp;
//@property (strong, nonatomic) NSNumber *pressure;
//@property (strong, nonatomic) NSNumber *humidity;
//@property (strong, nonatomic) NSNumber *temp_min;
//@property (strong, nonatomic) NSNumber *temp_max;
//@property (strong, nonatomic) NSNumber *wind_speed;
//@property (strong, nonatomic) NSNumber *wind_deg;
//
//
//
//
//{"coord":
//    {"lon":-122.41,"lat":37.79},
//    "weather":
//    [
//    {"id":804,
//        "main":"Clouds",
//        "description":"overcast clouds",
//        "icon":"04d"}
//     ],
//    "base":"stations",
//    "main":{"temp":59.34,"pressure":1017,"humidity":93,"temp_min":55.99,"temp_max":62.01},
//    "visibility":16093,
//    "wind":{"speed":1.45,"deg":319.456},
//    "clouds":{"all":90},
//    "dt":1567173691,
//    "sys":{"type":1,"id":4322,"message":0.0166,"country":"US","sunrise":1567172284,"sunset":1567219378},
//    "timezone":-25200,
//    "id":5391959,
//    "name":"San Francisco",
//    "cod":200}
-(id)initWithJSON:(NSData *)jsonData;
- (NSString *)currentCountryString;
@end

NS_ASSUME_NONNULL_END
