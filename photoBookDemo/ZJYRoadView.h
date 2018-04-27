//
//  ZJYRoadView.h
//  ZJY_IosMobile
//
//  Created by Onion on 2018/4/26.
//  Copyright © 2018年 ZJY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZJYRoadView : UIView
@property (nonatomic, copy) void(^didClickBtnBlock)(NSInteger index);

@end
