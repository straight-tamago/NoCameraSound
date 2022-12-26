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
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"すとれーとたまご★"
                                                                   message:@"処理が完了するとこのアプリは落ちるけど、シャッター音は消えてるはずだよ。（いや知らんけど）"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    
UIAlertAction *firstAction = [UIAlertAction actionWithTitle:@"写真撮影（スクショを含む）"
                                                      style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
    self->_running.hidden = false;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            startr_0();
    });
}];
UIAlertAction *secondAction = [UIAlertAction actionWithTitle:@"動画撮影開始（画面収録を含む）"
                                                      style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
    self->_running.hidden = false;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            startr_1();
    });
}];
UIAlertAction *thirdAction = [UIAlertAction actionWithTitle:@"動画撮影終了（画面収録を含む）"
                                                      style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
    self->_running.hidden = false;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            startr_2();
    });
}];
UIAlertAction *fourthAction = [UIAlertAction actionWithTitle:@"やめる"
                                                          style:UIAlertActionStyleCancel handler:^(UIAlertAction * action) {
    }];
    
    [alert addAction:firstAction];
    [alert addAction:secondAction];
    [alert addAction:thirdAction];
    [alert addAction:fourthAction];
    [self presentViewController:alert animated:YES completion:nil];
}

- (IBAction)info:(id)sender {
    UIApplication *application = [UIApplication sharedApplication];
    NSURL *URL = [NSURL URLWithString:@"https://github.com/straight-tamago/NoCameraSound"];
    NSURL *URL2 = [NSURL URLWithString:@"https://github.com/zhuowei/MacDirtyCowDemo"];
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"NoCameraSound 2.0"
                                                                   message:@"by すとれーとたまご★"
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
        UIAlertAction *thirdAction = [UIAlertAction actionWithTitle:@"Close"
              style:UIAlertActionStyleCancel handler:^(UIAlertAction * action) {
        }];
    
        [alert addAction:firstAction];
        [alert addAction:secondAction];
        [alert addAction:thirdAction];

        [self presentViewController:alert animated:YES completion:nil];

}
@end
