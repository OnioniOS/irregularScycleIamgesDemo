//
//  ViewController.m
//  test
//
//  Created by Onion on 2018/4/25.
//  Copyright © 2018年 Onion. All rights reserved.
//

#import "ViewController.h"
#import "ZJYRoadView.h"
#define ViewWidth [UIScreen mainScreen].bounds.size.width * 0.6
#define ViewHeight [UIScreen mainScreen].bounds.size.height * 0.5
#define ViewSmallHeight [UIScreen mainScreen].bounds.size.height * 0.43
#define LeftMargin 35
#define ViewMargin 15
#define AnimationDuration 0.4

#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

@interface ViewController ()
@property (nonatomic, strong) ZJYRoadView *roadView;
@end

@implementation ViewController
- (void)loadView {
    self.view = self.roadView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
}
- (ZJYRoadView *)roadView {
    if (!_roadView) {
        _roadView = [[ZJYRoadView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _roadView.backgroundColor = [UIColor whiteColor];
        _roadView.didClickBtnBlock = ^(NSInteger index) {
            NSLog(@"----%ld", index);
        };
    }
    return _roadView;
}
- (void)alertViewWithTitle:(NSString *)title message:(NSString *)message leftBtnTitle:(NSString *)leftTitle leftBlock:(void(^)(void))leftBlock rightBtnTitle:(NSString *)rightTitle rightBlock:(void(^)(void))rightBlock {
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    if (rightTitle.length) {
        UIAlertAction *rightAction = [UIAlertAction actionWithTitle:rightTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (rightBlock) {
                rightBlock();
            }
        }];
        [alertC addAction:rightAction];
    }
    if (leftTitle.length) {
        UIAlertAction *leftActon = [UIAlertAction actionWithTitle:leftTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (leftBlock) {
                leftBlock();
            }
        }];
        [alertC addAction:leftActon];
    }
    [self presentViewController:alertC animated:YES completion:nil];
}
@end
