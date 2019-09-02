
#import <UIKit/UIKit.h>

@interface UIAlertController (Additions)

+ (void)showWithTitle:(NSString *)title message:(NSString *)message completion:(void (^)(void))completion; 


@end
