//
//  LoadingView.h
//  WeatherApp
//
//  Created by Eva on 30.08.2019.
//  Copyright © 2019 Eva. All rights reserved.
//

#import "LoadingView.h"

@interface LoadingView () {
    UIActivityIndicatorView *spinner;
}

@end

@implementation LoadingView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(id)init {
    self =[super init];
//    self.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width-120)/2,([UIScreen mainScreen].bounds.size.height-120)/2, 120.0, 120.0);
    self.frame = [UIScreen mainScreen].bounds;
    self.dialogView =[[UIView alloc] initWithFrame:self.frame/*CGRectMake(0, 0, 120.0, 120.0)*/];
    
    self.dialogView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.9];//txtColor;
    self.dialogView.alpha = 0.7;

    
    spinner =[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    spinner.hidden = YES;
    spinner.hidesWhenStopped = YES;
    [spinner startAnimating];
    spinner.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    [self.dialogView addSubview:spinner];
    return self;
    
}

-(void)show {
    
    self.dialogView.layer.shouldRasterize = YES;
    self.dialogView.layer.rasterizationScale = [[UIScreen mainScreen] scale];
    
    self.dialogView.layer.opacity = 0.7f;
    self.dialogView.layer.transform = CATransform3DMakeScale(1.3f, 1.3f, 1.0);
    
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    
    [self addSubview:self.dialogView];
    
    // Can be attached to a view or to the top most window
    // Attached to a view:
    
    UIInterfaceOrientation interfaceOrientation = [[UIApplication sharedApplication] statusBarOrientation];
    
    switch (interfaceOrientation) {
        case UIInterfaceOrientationLandscapeLeft:
            self.transform = CGAffineTransformMakeRotation(M_PI * 270.0 / 180.0);
            break;
            
        case UIInterfaceOrientationLandscapeRight:
            self.transform = CGAffineTransformMakeRotation(M_PI * 90.0 / 180.0);
            break;
            
        case UIInterfaceOrientationPortraitUpsideDown:
            self.transform = CGAffineTransformMakeRotation(M_PI * 180.0 / 180.0);
            break;
            
        default:
            break;
    }
    
    //[self setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [[[[UIApplication sharedApplication] windows] lastObject] addSubview:self];
    
    [UIView animateWithDuration:0.2f delay:0.0 options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.f];
                         self.dialogView.layer.opacity = 0.7f;
                         self.dialogView.layer.transform = CATransform3DMakeScale(1, 1, 1);
                     }
                     completion:^(BOOL finished) {
                         
                         
                     }
     ];
}


-(void)hide {
    
    [self close];
}

- (void)close
{
    self.dialogView.layer.transform = CATransform3DMakeScale(1, 1, 1);
    self.dialogView.layer.opacity = 0.7f;
    
    [UIView animateWithDuration:0.2f delay:0.0 options:UIViewAnimationOptionTransitionNone
                     animations:^{
                         self.backgroundColor = [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.0f];
                         self.dialogView.layer.transform = CATransform3DMakeScale(0.6f, 0.6f, 1.0);
                         self.dialogView.layer.opacity = 0.0f;
                     }
                     completion:^(BOOL finished) {
                         for (UIView *v in [self subviews]) {
                             [v removeFromSuperview];
                         }
                         [self removeFromSuperview];
                     }
     ];
}

@end
