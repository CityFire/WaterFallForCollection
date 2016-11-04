//
//  ViewController.m
//  WaterFallForCollection
//
//  Created by wjc on 15/12/5.
//  Copyright © 2015年 wjc. All rights reserved.
//

#import "ViewController.h"
#import "WaterFallFlowLayout.h"
#import "WaterFallCellCollectionViewCell.h"
#import "UIColor+Extension.h"

static NSString *cellIdentifierID = @"myCollectionCell";
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
CGFloat const kImgCount = 47;

@interface ViewController ()<UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) NSMutableArray *imgArr;// 数据源
@property (strong, nonatomic) UICollectionView *myCollectionView;

@end

@implementation ViewController
// 懒加载
- (NSMutableArray *)imgArr
{
    if (!_imgArr) {
        NSMutableArray *muArr = [NSMutableArray array];
        for (NSInteger i = 1; i < kImgCount; i++) {
//            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"image%@", @(i)]];
            float rp = arc4random_uniform((u_int32_t)255);
            float gp = arc4random_uniform((u_int32_t)255);
            float bp = arc4random_uniform((u_int32_t)255);
            float r = rp / 255;
            float g = gp / 255;
            float b = bp / 255;
//            NSLog(@"%f, %f, %f", r, g, b);
            UIImage *image = [UIColor imageWithColor:[UIColor colorWithRed:r green:g blue:b alpha:1.0]];
            [muArr addObject:image];
        }
        _imgArr = muArr;
    }
    return _imgArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    [self initCollectionView];
}

- (void)initCollectionView
{
    WaterFallFlowLayout *layout = [[WaterFallFlowLayout alloc] init];
    _myCollectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    _myCollectionView.delegate = self;
    _myCollectionView.dataSource = self;
    // 注册单元格
    [_myCollectionView registerClass:[WaterFallCellCollectionViewCell class] forCellWithReuseIdentifier:cellIdentifierID];
//    [_myCollectionView registerNib:[UINib nibWithNibName:@"InvestCollectionCell" bundle:nil] forCellWithReuseIdentifier:cellIdentifierID];
    _myCollectionView.alwaysBounceVertical = YES;
    _myCollectionView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:_myCollectionView];
    
}

#pragma mark - UICollectionView Datasource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.imgArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    WaterFallCellCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifierID forIndexPath:indexPath];
    if (!cell) {
        cell = [[WaterFallCellCollectionViewCell alloc] init];
    }
    if (self.imgArr.count > indexPath.item) {
        cell.image = self.imgArr[indexPath.item];
    }
    
    return cell;
}

- (CGFloat)ImgHeight:(CGFloat)height Width:(CGFloat)width
{
    // cellW 默认宽为100 高度/宽度 = 压缩后高度/压缩后宽度
    CGFloat newHight = height * 100 / width;
    return newHight;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.imgArr.count > indexPath.item) {
        UIImage *img = [self.imgArr objectAtIndex:indexPath.item];
        return CGSizeMake(100, [self ImgHeight:img.size.height Width:img.size.width]);
    }
    return CGSizeZero;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    UIEdgeInsets edgeInset = UIEdgeInsetsMake(5, 5, 5, 5);
    return edgeInset;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
