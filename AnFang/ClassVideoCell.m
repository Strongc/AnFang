//
//  ClassVideoCell.m
//  AnFang
//
//  Created by MyOS on 15/12/4.
//  Copyright © 2015年 wellgood. All rights reserved.
//

#import "ClassVideoCell.h"
#import "Common.h"
#import "UIColor+Extensions.h"
#import "PublicVideoClassCell.h"

@implementation ClassVideoCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if(self){
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        self.videoClass = [[UICollectionView alloc]initWithFrame:CGRectMake(5, 0, WIDTH-10, WIDTH-60) collectionViewLayout:flowLayout];
        self.videoClass.delegate = self;
        self.videoClass.dataSource = self;
#pragma mark -- 头尾部大小设置
        //设置头部并给定大小
        //[flowLayout setHeaderReferenceSize:CGSizeMake(videoClass.frame.size.width, 40)];
#pragma mark -- 注册头部视图
        //    [videoCollection registerClass:[PublicHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];
        
        //[self.view addSubview:videoClass];
        self.videoClass.backgroundColor = [UIColor colorWithHexString:@"040818"];
        self.videoClass.scrollEnabled = YES;
        [self.videoClass registerClass:[PublicVideoClassCell class] forCellWithReuseIdentifier:@"cell"];
        [self.contentView addSubview:self.videoClass];
    }
    self.backgroundColor = [UIColor clearColor];
    return self;
    
}

#pragma mark UICollectionViewDataSource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return self.classDataArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *identifyId = @"cell";
    PublicVideoClassCell *cell = (PublicVideoClassCell *)[collectionView dequeueReusableCellWithReuseIdentifier:identifyId forIndexPath:indexPath];
    PublicVideoClassModel *model = [self.classDataArray objectAtIndex:indexPath.item];
    cell.publicClass = model;
    [cell setTag:indexPath.row];

    //[cell.backViewBtn addTarget:self action:@selector(doJumpTo:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

#pragma mark UICollectionViewDelegateFlowLayout

//定义每个cell的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    return CGSizeMake((self.videoClass.frame.size.width-40)/2 +5, (self.videoClass.frame.size.height-30)/2 + 5);
}

//设置每组cell的边界
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    
    return UIEdgeInsetsMake(0, 10, 10, 10);//上,左，下，右
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    int index = (int)indexPath.row;
    self.cellIndex = index;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"showHUD" object:nil];
    [self performSelector:@selector(clickClassVideoCell) withObject:nil afterDelay:2.0f];
    
}

-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

    return YES;
}

/**
 *  点击cell调用的方法
 */
-(void)clickClassVideoCell
{
    if([self.delegate respondsToSelector:@selector(jumpToItemVideo:)]){
    
        [self.delegate jumpToItemVideo:self];
    }

}

@end
