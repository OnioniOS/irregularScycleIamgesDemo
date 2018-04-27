//
//  ZJYRoadView.m
//  ZJY_IosMobile
//
//  Created by Onion on 2018/4/26.
//  Copyright © 2018年 ZJY. All rights reserved.
//

#import "ZJYRoadView.h"
#import "ZJYRoadBtn.h"

#define ViewWidth [UIScreen mainScreen].bounds.size.width * 0.6
#define ViewHeight [UIScreen mainScreen].bounds.size.height * 0.5
#define ViewSmallHeight [UIScreen mainScreen].bounds.size.height * 0.43
#define LeftMargin 35
#define ViewMargin 15
#define AnimationDuration 0.4

#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

@interface ZJYRoadView ()
@property (nonatomic, strong) ZJYRoadBtn *view0;
@property (nonatomic, strong) ZJYRoadBtn *view1;
@property (nonatomic, strong) ZJYRoadBtn *view2;
@property (nonatomic, strong) ZJYRoadBtn *view3;
@property (nonatomic, strong) NSMutableArray *array;
@property (nonatomic, strong) NSMutableArray *imageArray;
@property (nonatomic, assign) BOOL isAnimating;
@property (nonatomic, assign) NSInteger leftCount;

@end
@implementation ZJYRoadView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *bg = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        bg.image = [UIImage imageNamed:@"roadBG"];
        [self addSubview:bg];
        [self addSubview:self.view0];
        [self addSubview:self.view1];
        [self addSubview:self.view2];
        [self addSubview:self.view3];
        self.imageArray = [@[@"1", @"2", @"3", @"4", @"5", @"6"] mutableCopy];
        [self.view1 roadBtn_setImage:[UIImage imageNamed:self.imageArray[0]]];
        [self.view2 roadBtn_setImage:[UIImage imageNamed:self.imageArray[1]]];
        [self.view3 roadBtn_setImage:[UIImage imageNamed:self.imageArray[2]]];
        self.array = [@[@100, @101, @102, @103] mutableCopy];
        UISwipeGestureRecognizer *swipeGLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(leftAction)];
        swipeGLeft.direction = UISwipeGestureRecognizerDirectionLeft;
        UISwipeGestureRecognizer *swipeGRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(rightAction)];
        swipeGRight.direction = UISwipeGestureRecognizerDirectionRight;
        [self addGestureRecognizer:swipeGLeft];
        [self addGestureRecognizer:swipeGRight];
    }
    return self;
}


- (void)leftAction {
    if (self.isAnimating) {
        return;
    }
    if (self.leftCount == self.imageArray.count-1) {
        return;
    }
    self.leftCount++;
    self.isAnimating = YES;
    [self bringSubviewToFront:((ZJYRoadBtn *)[self viewWithTag:[self.array[2] integerValue]])];
    [UIView animateWithDuration:AnimationDuration animations:^{
        ((ZJYRoadBtn *)[self viewWithTag:[self.array[0] integerValue]]).frame = CGRectMake(WIDTH + (WIDTH-ViewWidth-LeftMargin-ViewMargin) + ViewMargin,  HEIGHT/2-ViewSmallHeight/2, (WIDTH-ViewWidth-LeftMargin-ViewMargin)*2, ViewSmallHeight);
        ((ZJYRoadBtn *)[self viewWithTag:[self.array[1] integerValue]]).alpha = 0;
        ((ZJYRoadBtn *)[self viewWithTag:[self.array[2] integerValue]]).frame = CGRectMake(LeftMargin, HEIGHT/2-ViewHeight/2, ViewWidth, ViewHeight);
        ((ZJYRoadBtn *)[self viewWithTag:[self.array[2] integerValue]]).layer.shadowColor = [UIColor blackColor].CGColor;
        ((ZJYRoadBtn *)[self viewWithTag:[self.array[2] integerValue]]).layer.shadowOffset = CGSizeMake(4, 4);
        ((ZJYRoadBtn *)[self viewWithTag:[self.array[2] integerValue]]).layer.shadowOpacity = 0.5;
        ((ZJYRoadBtn *)[self viewWithTag:[self.array[3] integerValue]]).frame = CGRectMake(WIDTH - (WIDTH-ViewWidth-LeftMargin-ViewMargin), HEIGHT/2-ViewSmallHeight/2, (WIDTH-ViewWidth-LeftMargin-ViewMargin)*2, ViewSmallHeight);
        ((ZJYRoadBtn *)[self viewWithTag:[self.array[3] integerValue]]).btnIndex = self.leftCount + 1;
    } completion:^(BOOL finished) {
        if (self.leftCount+2 <= self.imageArray.count-1) {
            [((ZJYRoadBtn *)[self viewWithTag:[self.array[0] integerValue]]) roadBtn_setImage:[UIImage imageNamed:self.imageArray[self.leftCount+2]]];
        }else {
            [((ZJYRoadBtn *)[self viewWithTag:[self.array[0] integerValue]]) roadBtn_setImage:[UIImage imageNamed:@""]];
        }
        ((ZJYRoadBtn *)[self viewWithTag:[self.array[1] integerValue]]).layer.shadowOpacity = 0;
        ((ZJYRoadBtn *)[self viewWithTag:[self.array[0] integerValue]]).alpha = 1;
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
        return;
    }
    self.leftCount--;
    self.isAnimating = YES;
    ((ZJYRoadBtn *)[self viewWithTag:[self.array[3] integerValue]]).alpha = 0;
    [UIView animateWithDuration:AnimationDuration animations:^{
        ((ZJYRoadBtn *)[self viewWithTag:[self.array[0] integerValue]]).alpha = 1;
        ((ZJYRoadBtn *)[self viewWithTag:[self.array[0] integerValue]]).layer.shadowOpacity = 0.5;
        ((ZJYRoadBtn *)[self viewWithTag:[self.array[1] integerValue]]).frame = CGRectMake(WIDTH - (WIDTH-ViewWidth-LeftMargin-ViewMargin), HEIGHT/2-ViewSmallHeight/2, (WIDTH-ViewWidth-LeftMargin-ViewMargin)*2, ViewSmallHeight);
        ((ZJYRoadBtn *)[self viewWithTag:[self.array[1] integerValue]]).btnIndex = self.leftCount + 1;
        ((ZJYRoadBtn *)[self viewWithTag:[self.array[1] integerValue]]).layer.shadowOpacity = 0;
        ((ZJYRoadBtn *)[self viewWithTag:[self.array[2] integerValue]]).frame = CGRectMake(WIDTH + (WIDTH-ViewWidth-LeftMargin-ViewMargin) + ViewMargin,  HEIGHT/2-ViewSmallHeight/2, (WIDTH-ViewWidth-LeftMargin-ViewMargin)*2, ViewSmallHeight);
        ((ZJYRoadBtn *)[self viewWithTag:[self.array[3] integerValue]]).frame = CGRectMake(LeftMargin, HEIGHT/2-ViewHeight/2, ViewWidth, ViewHeight);
    } completion:^(BOOL finished) {
        if (self.leftCount - 1 >= 0) {
            [((ZJYRoadBtn *)[self viewWithTag:[self.array[3] integerValue]]) roadBtn_setImage:[UIImage imageNamed:self.imageArray[self.leftCount - 1]]];
        }else {
            [((ZJYRoadBtn *)[self viewWithTag:[self.array[3] integerValue]]) roadBtn_setImage:[UIImage imageNamed:@""]];
        }
        [self.array insertObject:[self.array lastObject] atIndex:0];
        [self.array removeObjectAtIndex:4];
        self.isAnimating = NO;
    }];
    
}

- (ZJYRoadBtn *)view0 {
    if (!_view0) {
        _view0 = [ZJYRoadBtn buttonWithType:UIButtonTypeCustom];
        _view0.frame = CGRectMake(LeftMargin, HEIGHT/2-ViewHeight/2, ViewWidth, ViewHeight);
        _view0.alpha = 0;
        _view0.tag = 100;
        [self addBtnAction:_view0];
    }
    return _view0;
}
- (ZJYRoadBtn *)view1 {
    if (!_view1) {
        _view1 = [ZJYRoadBtn buttonWithType:UIButtonTypeCustom];
        _view1.frame = CGRectMake(LeftMargin, HEIGHT/2-ViewHeight/2, ViewWidth, ViewHeight);
        _view1.layer.shadowOpacity = 0.5;
        _view1.layer.shadowOffset = CGSizeMake(4, 4);
        _view1.layer.shadowColor = [UIColor blackColor].CGColor;
        _view1.tag = 101;
        [self addBtnAction:_view1];
    }
    return _view1;
}
- (ZJYRoadBtn *)view2 {
    if (!_view2) {
        _view2 = [ZJYRoadBtn buttonWithType:UIButtonTypeCustom];
        _view2.frame = CGRectMake(WIDTH-(WIDTH-ViewWidth-LeftMargin-ViewMargin), HEIGHT/2-ViewSmallHeight/2, (WIDTH-ViewWidth-LeftMargin-ViewMargin)*2, ViewSmallHeight);
        _view2.tag = 102;
        _view2.btnIndex = 1;
        [self addBtnAction:_view2];
    }
    return _view2;
}
- (ZJYRoadBtn *)view3 {
    if (!_view3) {
        _view3 = [ZJYRoadBtn buttonWithType:UIButtonTypeCustom];
        _view3.frame = CGRectMake(WIDTH+(WIDTH-ViewWidth-LeftMargin-ViewMargin)+ViewMargin, HEIGHT/2-ViewSmallHeight/2, (WIDTH-ViewWidth-LeftMargin-ViewMargin)*2, ViewSmallHeight);
        _view3.tag = 103;
        [self addBtnAction:_view3];
    }
    return _view3;
}

- (void)addBtnAction:(ZJYRoadBtn *)btn {
    [btn addTarget:self action:@selector(handleBtnAction:) forControlEvents:UIControlEventTouchUpInside];
}
- (void)handleBtnAction:(ZJYRoadBtn *)sender {
    if (sender.btnIndex == self.leftCount) {
        if (self.didClickBtnBlock) {
            self.didClickBtnBlock(self.leftCount);
        }
    }else {
        [self leftAction];
    }
}
@end
