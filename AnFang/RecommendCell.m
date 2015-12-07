//
//  RecommendCell.m
//  AnFang
//
//  Created by MyOS on 15/12/4.
//  Copyright © 2015年 wellgood. All rights reserved.
//

#import "RecommendCell.h"
#import "Common.h"
#import "UIColor+Extensions.h"
#import "RecommendVideoCell.h"

@implementation RecommendCell

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
        self.recommendVideo = [[UICollectionView alloc]initWithFrame:CGRectMake(5, 0, WIDTH-10, 140) collectionViewLayout:flowLayout];
        self.recommendVideo.delegate = self;
        self.recommendVideo.dataSource = self;
#pragma mark -- 头尾部大小设置
        //设置头部并给定大小
        //[flowLayout setHeaderReferenceSize:CGSizeMake(videoClass.frame.size.width, 40)];
#pragma mark -- 注册头部视图
        //    [videoCollection registerClass:[PublicHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];
        
        //[self.view addSubview:videoClass];
        self.recommendVideo.backgroundColor = [UIColor colorWithHexString:@"040818"];
        self.recommendVideo.scrollEnabled = NO;
        [self.recommendVideo registerClass:[RecommendVideoCell class] forCellWithReuseIdentifier:@"cell"];
        [self.contentView addSubview:self.recommendVideo];
    }
    
    self.backgroundColor = [UIColor clearColor];
    return self;

}

#pragma mark UICollectionViewDataSource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return self.recondVideoArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *identifyId = @"cell";
    RecommendVideoCell *cell = (RecommendVideoCell *)[collectionView dequeueReusableCellWithReuseIdentifier:identifyId forIndexPath:indexPath];
    RecommendVideoModel *model = [self.recondVideoArray objectAtIndex:indexPath.item];
    cell.recommendVideoModel = model;
    [cell setTag:indexPath.row];
    //[cell.backViewBtn addTarget:self action:@selector(doJumpTo:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

#pragma mark UICollectionViewDelegateFlowLayout

//定义每个cell的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
//    CGFloat w = self.recommendVideo.frame.size.width;
//    NSLog(@"宽度 %f",w);
    
    return CGSizeMake((self.recommendVideo.frame.size.width-40)/3, 120);
}

//设置每组cell的边界
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    
    return UIEdgeInsetsMake(10, 10, 10, 10);//上,左，下，右
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    // int index = (int)indexPath.row;
   // [[NSNotificationCenter defaultCenter] postNotificationName:@"showHUD" object:nil];
    //[self performSelector:@selector(doJumpTo:) withObject:indexPath afterDelay:2.0f];
}

-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    return YES;
}



@end
