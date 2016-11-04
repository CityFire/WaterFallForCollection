//
//  WaterFallFlowLayout.h
//  WaterFallForCollection
//
//  Created by wjc on 15/12/5.
//  Copyright © 2015年 wjc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WaterFallFlowLayout : UICollectionViewFlowLayout

@property (nonatomic, weak) id<UICollectionViewDelegateFlowLayout>delegate;
@property (nonatomic, strong) NSMutableArray *colArr; // 存放列的高度
@property (nonatomic, strong) NSMutableDictionary *attributeDict; // 存放cell的信息
@property (nonatomic, assign) NSInteger cellCount; // cell的个数

@end
