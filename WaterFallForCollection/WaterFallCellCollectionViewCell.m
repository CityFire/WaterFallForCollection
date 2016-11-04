//
//  WaterFallCellCollectionViewCell.m
//  WaterFallForCollection
//
//  Created by wjc on 15/12/5.
//  Copyright © 2015年 wjc. All rights reserved.
//

#import "WaterFallCellCollectionViewCell.h"

@implementation WaterFallCellCollectionViewCell

- (void)setImage:(UIImage *)image
{
    if (_image != image) {
        _image = image;
    }
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    float newHeight = _image.size.height / _image.size.width * 100;
    [_image drawInRect:CGRectMake(0, 0, 100, newHeight)];
}

@end
