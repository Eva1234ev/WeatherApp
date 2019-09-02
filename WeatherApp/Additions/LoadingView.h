//
//  LoadingView.h
//  WeatherApp
//
//  Created by Eva on 30.08.2019.
//  Copyright © 2019 Eva. All rights reserved.
//
#import <UIKit/UIKit.h>


@interface LoadingView : UIView

@property (nonatomic, retain) UIView *dialogView;    


-(void)show;
-(void)hide;

@end
