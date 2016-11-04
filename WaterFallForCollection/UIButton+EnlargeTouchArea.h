//
//  UIButton+EnlargeTouchArea.h
//  Wealth88
//
//  Created by wjc on 16/3/18.
//  Copyright © 2016年 深圳市中科创财富通网络金融有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (EnlargeTouchArea)

- (void)setEnlargeEdgeWithTop:(CGFloat)top
                        right:(CGFloat)right
                            bottom:(CGFloat)bottom
                                left:(CGFloat)left;

@end
