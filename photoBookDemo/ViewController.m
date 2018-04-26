//
//  ViewController.m
//  test
//
//  Created by Onion on 2018/4/25.
//  Copyright © 2018年 Onion. All rights reserved.
//

#import "ViewController.h"
#define ViewWidth [UIScreen mainScreen].bounds.size.width * 0.6
#define ViewHeight [UIScreen mainScreen].bounds.size.height * 0.5
#define ViewSmallHeight [UIScreen mainScreen].bounds.size.height * 0.43
#define LeftMargin 35
#define ViewMargin 15
#define AnimationDuration 0.4

#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

@interface ViewController ()
@property (nonatomic, strong) UIImageView *view0;
@property (nonatomic, strong) UIImageView *view1;
@property (nonatomic, strong) UIImageView *view2;
@property (nonatomic, strong) UIImageView *view3;
@property (nonatomic, strong) NSMutableArray *array;
@property (nonatomic, strong) NSMutableArray *imageArray;
@property (nonatomic, assign) BOOL isAnimating;
@property (nonatomic, assign) NSInteger leftCount;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.view0];
    [self.view addSubview:self.view1];
    [self.view addSubview:self.view2];
    [self.view addSubview:self.view3];  
    self.imageArray = [@[@"1", @"2", @"3", @"4", @"5", @"6"] mutableCopy];
    self.view1.image = [UIImage imageNamed:self.imageArray[0]];
    self.view2.image = [UIImage imageNamed:self.imageArray[1]];
    self.view3.image = [UIImage imageNamed:self.imageArray[2]];
    self.array = [@[@100, @101, @102, @103] mutableCopy];
    UISwipeGestureRecognizer *swipeGLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(leftAction)];
    swipeGLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    UISwipeGestureRecognizer *swipeGRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(rightAction)];
    swipeGRight.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swipeGLeft];
    [self.view addGestureRecognizer:swipeGRight];
}
- (void)leftAction {
    if (self.isAnimating) {
        return;
    }
    if (self.leftCount == self.imageArray.count-1) {
        [self alertViewWithTitle:@"提示" message:@"最后一页了" leftBtnTitle:@"确定" leftBlock:nil rightBtnTitle:@"" rightBlock:nil];
        return;
    }
    self.leftCount++;
    self.isAnimating = YES;
    [self.view bringSubviewToFront:((UIImageView *)[self.view viewWithTag:[self.array[2] integerValue]])];
    [UIView animateWithDuration:AnimationDuration animations:^{
        ((UIImageView *)[self.view viewWithTag:[self.array[0] integerValue]]).frame = CGRectMake(WIDTH + (WIDTH-ViewWidth-LeftMargin-ViewMargin) + ViewMargin,  HEIGHT/2-ViewSmallHeight/2, (WIDTH-ViewWidth-LeftMargin-ViewMargin)*2, ViewSmallHeight);
        ((UIImageView *)[self.view viewWithTag:[self.array[1] integerValue]]).alpha = 0;
        ((UIImageView *)[self.view viewWithTag:[self.array[2] integerValue]]).frame = CGRectMake(LeftMargin, HEIGHT/2-ViewHeight/2, ViewWidth, ViewHeight);
        ((UIImageView *)[self.view viewWithTag:[self.array[2] integerValue]]).layer.shadowColor = [UIColor blackColor].CGColor;
        ((UIImageView *)[self.view viewWithTag:[self.array[2] integerValue]]).layer.shadowOffset = CGSizeMake(4, 4);
        ((UIImageView *)[self.view viewWithTag:[self.array[2] integerValue]]).layer.shadowOpacity = 0.5;
        ((UIImageView *)[self.view viewWithTag:[self.array[3] integerValue]]).frame = CGRectMake(WIDTH - (WIDTH-ViewWidth-LeftMargin-ViewMargin), HEIGHT/2-ViewSmallHeight/2, (WIDTH-ViewWidth-LeftMargin-ViewMargin)*2, ViewSmallHeight);
    } completion:^(BOOL finished) {
        if (self.leftCount+2 <= self.imageArray.count-1) {
            ((UIImageView *)[self.view viewWithTag:[self.array[0] integerValue]]).image = [UIImage imageNamed:self.imageArray[self.leftCount+2]];
        }else {
            ((UIImageView *)[self.view viewWithTag:[self.array[0] integerValue]]).image = [UIImage imageNamed:@""];
        }
        ((UIImageView *)[self.view viewWithTag:[self.array[1] integerValue]]).layer.shadowOpacity = 0;
        ((UIImageView *)[self.view viewWithTag:[self.array[0] integerValue]]).alpha = 1;
        [self.array insertObject:[self.array firstObject] atIndex:4];
        [self.array removeObjectAtIndex:0];
        self.isAnimating = NO;
    }];
}
- (void)rightAction {
    if (self.isAnimating) {
        return;
    }
    if (self.leftCount == 0) {
        [self alertViewWithTitle:@"提示" message:@"已经是首页了" leftBtnTitle:@"确定" leftBlock:nil rightBtnTitle:@"" rightBlock:nil];
        return;
    }
    self.leftCount--;
    self.isAnimating = YES;
    ((UIImageView *)[self.view viewWithTag:[self.array[3] integerValue]]).alpha = 0;
    [UIView animateWithDuration:AnimationDuration animations:^{
        ((UIImageView *)[self.view viewWithTag:[self.array[0] integerValue]]).alpha = 1;
        ((UIImageView *)[self.view viewWithTag:[self.array[0] integerValue]]).layer.shadowOpacity = 0.5;
        ((UIImageView *)[self.view viewWithTag:[self.array[1] integerValue]]).frame = CGRectMake(WIDTH - (WIDTH-ViewWidth-LeftMargin-ViewMargin), HEIGHT/2-ViewSmallHeight/2, (WIDTH-ViewWidth-LeftMargin-ViewMargin)*2, ViewSmallHeight);
        ((UIImageView *)[self.view viewWithTag:[self.array[1] integerValue]]).layer.shadowOpacity = 0;
        ((UIImageView *)[self.view viewWithTag:[self.array[2] integerValue]]).frame = CGRectMake(WIDTH + (WIDTH-ViewWidth-LeftMargin-ViewMargin) + ViewMargin,  HEIGHT/2-ViewSmallHeight/2, (WIDTH-ViewWidth-LeftMargin-ViewMargin)*2, ViewSmallHeight);
        ((UIImageView *)[self.view viewWithTag:[self.array[3] integerValue]]).frame = CGRectMake(LeftMargin, HEIGHT/2-ViewHeight/2, ViewWidth, ViewHeight);
    } completion:^(BOOL finished) {
        if (self.leftCount - 1 >= 0) {
            ((UIImageView *)[self.view viewWithTag:[self.array[3] integerValue]]).image = [UIImage imageNamed:self.imageArray[self.leftCount - 1]];
        }else {
            ((UIImageView *)[self.view viewWithTag:[self.array[3] integerValue]]).image = [UIImage imageNamed:@""];
        }
        
        [self.array insertObject:[self.array lastObject] atIndex:0];
        [self.array removeObjectAtIndex:4];
        self.isAnimating = NO;
    }];

}

- (UIImageView *)view0 {
    if (!_view0) {
        _view0 = [[UIImageView alloc] initWithFrame:CGRectMake(LeftMargin, HEIGHT/2-ViewHeight/2, ViewWidth, ViewHeight)];
        _view0.alpha = 0;
        _view0.tag = 100;
    }
    return _view0;
}
- (UIImageView *)view1 {
    if (!_view1) {
        _view1 = [[UIImageView alloc] initWithFrame:CGRectMake(LeftMargin, HEIGHT/2-ViewHeight/2, ViewWidth, ViewHeight)];
        _view1.layer.shadowOpacity = 0.5;
        _view1.layer.shadowOffset = CGSizeMake(4, 4);
        _view1.layer.shadowColor = [UIColor blackColor].CGColor;
        _view1.tag = 101;
    }
    return _view1;
}
- (UIImageView *)view2 {
    if (!_view2) {
        _view2 = [[UIImageView alloc] initWithFrame:CGRectMake(WIDTH-(WIDTH-ViewWidth-LeftMargin-ViewMargin), HEIGHT/2-ViewSmallHeight/2, (WIDTH-ViewWidth-LeftMargin-ViewMargin)*2, ViewSmallHeight)];
        _view2.tag = 102;
    }
    return _view2;
}
- (UIImageView *)view3 {
    if (!_view3) {
        _view3 = [[UIImageView alloc] initWithFrame:CGRectMake(WIDTH+(WIDTH-ViewWidth-LeftMargin-ViewMargin)+ViewMargin, HEIGHT/2-ViewSmallHeight/2, (WIDTH-ViewWidth-LeftMargin-ViewMargin)*2, ViewSmallHeight)];
        _view3.tag = 103;
    }
    return _view3;
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
