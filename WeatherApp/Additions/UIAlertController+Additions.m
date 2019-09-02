

#import "UIAlertController+Additions.h"

@implementation UIAlertController (Additions)

+ (void) showWithTitle:(NSString *)title message:(NSString *)message completion:(void (^ __nullable)(void))completion {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"OK", nil) style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        if (completion) {
            completion();
        }
    }]];
    UIViewController *topScreen = [[UIApplication sharedApplication] keyWindow].rootViewController;
    while (topScreen.presentedViewController) {
        topScreen = topScreen.presentedViewController;
    }
    [topScreen presentViewController:alert animated:YES completion:nil];
}

@end
