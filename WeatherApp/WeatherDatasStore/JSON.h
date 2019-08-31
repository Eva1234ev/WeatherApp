//
//  JSON.h
//  WeatherApp
//
//  Created by Eva on 31.08.2019.
//  Copyright © 2019 Eva. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark Deserializing methods

@interface NSString (JSONDeserializing)

- (id)objectFromJSONString;

@end

@interface NSData (JSONDeserializing)

- (id)objectFromJSONData;

@end


#pragma mark Serializing methods

@interface NSString (JSONSerializing)
- (NSData *)JSONData;
- (NSString *)JSONString;
@end

@interface NSArray (JSONSerializing)
- (NSData *)JSONData;
- (NSString *)JSONString;
@end

@interface NSDictionary (JSONSerializing)
- (NSData *)JSONData;
- (NSString *)JSONString;
@end

