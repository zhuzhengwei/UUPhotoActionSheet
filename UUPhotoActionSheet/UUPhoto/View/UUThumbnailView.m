//
//  UUThumbnailView.m
//  UUPhotoActionSheet
//
//  Created by zhangyu on 15/7/10.
//  Copyright (c) 2015年 zhangyu. All rights reserved.
//

#import "UUThumbnailView.h"
#import "UUPhoto-Import.h"
#import "UUPhoto-Macros.h"

@interface UUThumbnailView()< UICollectionViewDelegate,
                              UICollectionViewDataSource >

@property (nonatomic, strong, getter = getCollectionView) UICollectionView *collectionView;


@end

@implementation UUThumbnailView

- (instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        
        [self configUI];
    }
    
    return self;
}

#pragma mark - life cycle

- (void)configUI{
    
    [self addSubview:self.collectionView];
}

#pragma mark - UICollectionView DataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return [[UUAssetManager sharedInstance] getPhotoCountOfCurrentGroup];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UUThumbnailCollectionCell *cell;
    cell = [collectionView dequeueReusableCellWithReuseIdentifier:[UUThumbnailCollectionCell cellReuseIdentifier]
                                                     forIndexPath:indexPath];
    
    cell.layer.borderWidth = 2;
    cell.layer.backgroundColor = [UIColor greenColor].CGColor;

    [cell setContentWithIndexPath:indexPath];
//
//    cell.tag = indexPath.item;
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
//    [self.navigationController pushViewController:UUPhotoBrowserViewController.new animated:YES];
}


#pragma mark - Custom Deledate

#pragma mark - Event Response

#pragma mark - Public Methods

#pragma mark - Private Methods

#pragma mark - Getters And Setters

- (UICollectionView *)getCollectionView{
    
    if (!_collectionView) {
        
        UICollectionViewFlowLayout *flowLayout= [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flowLayout.minimumLineSpacing = 4;
        flowLayout.sectionInset = UIEdgeInsetsMake(10.0f, 4.0f, 10.0f, 4.0f);

        flowLayout.itemSize = CGSizeMake(105, 180);
//        flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = COLOR_WITH_RGB(230,231,234,1);
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        
        //        _collectionView.backgroundColor = COLOR_WITH_RGB(235,235,235,1);
        
        [_collectionView registerClass:[UUThumbnailCollectionCell class]
            forCellWithReuseIdentifier:[UUThumbnailCollectionCell cellReuseIdentifier]];
        
        
        [UUAssetManager sharedInstance].currentGroupIndex = 0;
        [[UUAssetManager sharedInstance] getGroupList:^(NSArray *obj) {
        
            [[UUAssetManager sharedInstance] getPhotoListOfGroupByIndex:[UUAssetManager sharedInstance].currentGroupIndex result:^(NSArray *r) {
                
                [_collectionView reloadData];
                
            }];
        }];
        
        
    }
    
    return _collectionView;
}

@end
