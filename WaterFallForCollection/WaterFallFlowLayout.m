//
//  WaterFallFlowLayout.m
//  WaterFallForCollection
//
//  Created by wjc on 15/12/5.
//  Copyright © 2015年 wjc. All rights reserved.
//

#import "WaterFallFlowLayout.h"
CGFloat const colCount = 3;

@implementation WaterFallFlowLayout

// 准备布局
- (void)prepareLayout
{
    [super prepareLayout];
    _colArr = [NSMutableArray array];
    _attributeDict = [NSMutableDictionary dictionary];
    self.delegate = (id<UICollectionViewDelegateFlowLayout>)self.collectionView.delegate;
    _cellCount = [self.collectionView numberOfItemsInSection:0];
    if (_cellCount == 0) {
        return;
    }
    float top = 0;
    for (NSInteger i = 0; i < colCount; i++) {
        [_colArr addObject:[NSNumber numberWithFloat:top]];
    }
    for (NSInteger i = 0; i < _cellCount; i++) {
        [self layoutItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
    }
}

// 布局cell
- (void)layoutItemAtIndexPath:(NSIndexPath *)indexPath
{
    // 通过协议得到cell的间隙
    UIEdgeInsets edgeInsets = [self.delegate collectionView:self.collectionView layout:self insetForSectionAtIndex:indexPath.row];
    CGSize itemSize = [self.delegate collectionView:self.collectionView layout:self sizeForItemAtIndexPath:indexPath];
    float col = 0;
    float shortHeight = [[_colArr objectAtIndex:col] floatValue];
    for (NSInteger i = 0; i < _colArr.count; i++) {
        float height = [[_colArr objectAtIndex:i] floatValue];
        if (height < shortHeight) {
            shortHeight = height;
            col = i;
        }
    }
    float top = [[_colArr objectAtIndex:col] floatValue];
    // 确定cell的frame
    CGRect frame = CGRectMake(edgeInsets.left + col * (edgeInsets.left + itemSize.width), top + edgeInsets.top, itemSize.width, itemSize.height);
    // 更新列高
    [_colArr replaceObjectAtIndex:col withObject:[NSNumber numberWithFloat:top + edgeInsets.top + itemSize.height]];
    // 每个cell的frame对应一个indexPath,放入字典中
    [_attributeDict setObject:indexPath forKey:NSStringFromCGRect(frame)];
}

- (NSArray *)indexPathsOfItem:(CGRect)rect {
    NSMutableArray *array = [NSMutableArray array];
    for (NSString *rectStr in _attributeDict) {
        CGRect cellRect = CGRectFromString(rectStr);
        if (CGRectIntersectsRect(cellRect, rect)) {
            NSIndexPath *indexPath = _attributeDict[rectStr];
            [array addObject:indexPath];
        }
    }
    return array;
}

// 返回cell的布局信息
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray *muArr = [NSMutableArray array];
    // indexPathsOfItem方法，根据传入的frame值计算当前应该显示的cnell
    NSArray *indexPaths = [self indexPathsOfItem:rect];
    for (NSIndexPath *indexPath in indexPaths) {
        UICollectionViewLayoutAttributes *attribute = [self layoutAttributesForItemAtIndexPath:indexPath];
        [muArr addObject:attribute];
    }
    return muArr;
}

// 计算collectionView的内容大小
- (CGSize)collectionViewContentSize
{
    if (_colArr.count <= 0) {
        return CGSizeZero;
    }
    CGSize size = self.collectionView.frame.size;
    float maxHeight = [[_colArr objectAtIndex:0] floatValue];
    // 查找最高的列的高度
    for (int i = 0; i < _colArr.count; i++) {
        float colHeight = [[_colArr objectAtIndex:i] floatValue];
        if (colHeight > maxHeight) {
            maxHeight = colHeight;
        }
    }
    size.height = maxHeight;
    return size;
}

@end
