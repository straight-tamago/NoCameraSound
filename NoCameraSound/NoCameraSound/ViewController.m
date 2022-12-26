//
//  ViewController.m
//  NoCameraSound
//
//  Created by すとれーとたまご★ on 2022/12/26.
//

#import "ViewController.h"
#import "poc.h"

@interface ViewController ()

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
    
    
UIAlertAction *firstAction = [UIAlertAction actionWithTitle:@"写真撮影"
                                                      style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            startr_0();
    });
}];
UIAlertAction *secondAction = [UIAlertAction actionWithTitle:@"動画撮影開始（画面収録を含む）"
                                                      style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            startr_1();
    });
}];
UIAlertAction *thirdAction = [UIAlertAction actionWithTitle:@"動画撮影終了（画面収録を含む）"
                                                      style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
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

@end
