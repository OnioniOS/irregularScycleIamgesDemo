//
//  ZJYRoadBtn.m
//  ZJY_IosMobile
//
//  Created by Onion on 2018/4/26.
//  Copyright © 2018年 ZJY. All rights reserved.
//

#import "ZJYRoadBtn.h"
@interface ZJYRoadBtn ()
@end
@implementation ZJYRoadBtn
- (void)roadBtn_setImage:(UIImage *)image {
    [self setImage:image forState:UIControlStateNormal];
    [self setImage:image forState:UIControlStateHighlighted];
}


@end
