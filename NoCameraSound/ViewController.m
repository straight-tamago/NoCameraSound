//
//  ViewController.m
//  NoCameraSound
//
//  Created by すとれーとたまご★ on 2022/12/26.
//

#import "ViewController.h"
#import "poc.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *running;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)go:(id)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"Select Operation", nil)
                                                                   message:NSLocalizedString(@"When the process is complete, this app will crash, but the shutter sound should be gone. (It will return to normal after a certain period of time or restart)", nil)
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    
UIAlertAction *firstAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"Photo & ScreenShot", nil)
                                                      style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
    self->_running.hidden = false;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            startr_0();
    });
}];
UIAlertAction *secondAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"Video Recording (Start)", nil)
                                                      style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
    self->_running.hidden = false;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            startr_1();
    });
}];
UIAlertAction *thirdAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"Video Recording (End)", nil)
                                                      style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
    self->_running.hidden = false;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            startr_2();
    });
}];
UIAlertAction *fourthAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"Close", nil)
                                                          style:UIAlertActionStyleCancel handler:^(UIAlertAction * action) {
    }];
    
    [alert addAction:firstAction];
    [alert addAction:secondAction];
    [alert addAction:thirdAction];
    [alert addAction:fourthAction];
    [self presentViewController:alert animated:YES completion:nil];
}

- (IBAction)info:(id)sender {
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    NSString *versionText = @"NoCameraSound v";
    NSString *fullversion = [versionText stringByAppendingString:version];
    UIApplication *application = [UIApplication sharedApplication];
    NSURL *URL = [NSURL URLWithString:@"https://github.com/straight-tamago/NoCameraSound"];
    NSURL *URL2 = [NSURL URLWithString:@"https://github.com/zhuowei/MacDirtyCowDemo"];
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:fullversion
                                                                   message:NSLocalizedString(@"by straight-tamago", nil)
                                                            preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *firstAction = [UIAlertAction actionWithTitle:@"Source Code"
                                                               style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
            [application openURL:URL options:@{} completionHandler:^(BOOL success) {
                if (success) {
                    NSLog(@"Success");
                }
            }];
        }];
        UIAlertAction *secondAction = [UIAlertAction actionWithTitle:@"MacDirtyCowDemo (Exploit)"
                                                               style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
            [application openURL:URL2 options:@{} completionHandler:^(BOOL success) {
                if (success) {
                    NSLog(@"Success");
                }
            }];
        }];
        UIAlertAction *thirdAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"Close", nil)
              style:UIAlertActionStyleCancel handler:^(UIAlertAction * action) {
        }];
    
        [alert addAction:firstAction];
        [alert addAction:secondAction];
        [alert addAction:thirdAction];

        [self presentViewController:alert animated:YES completion:nil];

}
@end
