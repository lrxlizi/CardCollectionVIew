//
//  ViewController.m
//  卡片CollectionVIew
//
//  Created by 栗子 on 2017/8/16.
//  Copyright © 2017年 http://www.cnblogs.com/Lrx-lizi/. All rights reserved.
//

#import "ViewController.h"
#import "CardCollectionVIewLayout.h"
#import "CardCollectionViewCell.h"

#define ITEMCELLID  @"ITEMCELLID"

@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
{
    UIImageView      *bgImageV;
    UICollectionView *cardCollectionVIew;
    NSArray          *imageArray;
    
    CGFloat          startX;
    CGFloat          endX;
    NSInteger        currentIndex;
    
}
@property (nonatomic, strong) UILabel *titleLB;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    
    imageArray = @[@"1.jpg",@"10.jpg",@"2.jpg",@"12.jpg",@"5.jpg",@"12.jpg",@"11.jpg",@"7.jpg",@"11.jpg",@"8.jpg",@"9.jpg",];
    
    //创建视图
    [self createUI];
    
}

-(void)createUI{
    
    bgImageV  = [[UIImageView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:bgImageV];
    bgImageV.image = [UIImage imageNamed:@"1.jpg"];
    [Healp blurEffect:bgImageV];//设置毛玻璃效果
    
    CardCollectionVIewLayout *layout = [[CardCollectionVIewLayout alloc]init];
    cardCollectionVIew  = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, LZScreenW, LZScreenH) collectionViewLayout:layout];
    [self.view addSubview:cardCollectionVIew];
    cardCollectionVIew.delegate=self;
    cardCollectionVIew.dataSource=self;
    cardCollectionVIew.backgroundView=bgImageV;
    cardCollectionVIew.showsHorizontalScrollIndicator=NO;
    [cardCollectionVIew registerClass:[CardCollectionViewCell class] forCellWithReuseIdentifier:ITEMCELLID];
    
    
    self.titleLB = [[UILabel alloc]initWithFrame:CGRectMake(10, 40, LZScreenW-20, 20)];
    [self.view addSubview:self.titleLB];
     self.titleLB.text = @"标题标题标题标题标题";
     self.titleLB.textAlignment = NSTextAlignmentCenter;
    
     self.titleLB.font = [UIFont systemFontOfSize:20];
    
    if ([Healp isLightColor:[UIColor colorWithPatternImage:[Healp imageFromView:bgImageV atFrame:CGRectMake(0, 0, LZScreenW, 100)]]]) {
        self.titleLB.textColor = [UIColor blackColor];
    }else{
         self.titleLB.textColor = [UIColor whiteColor];
    }
    
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return imageArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CardCollectionViewCell *cell =[collectionView dequeueReusableCellWithReuseIdentifier:ITEMCELLID forIndexPath:indexPath];
    cell.imageIV.image=[UIImage imageNamed:[NSString stringWithFormat:@"%@",imageArray[indexPath.row]]];
    return cell;
}


-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    startX = scrollView.contentOffset.x;
    
}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    endX = scrollView.contentOffset.x;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self cellToCenter];
    });
}
-(void)cellToCenter{
        //最小滚动距离
    float  dragMinDistance = cardCollectionVIew.bounds.size.width/20.0f;
    if (startX - endX >= dragMinDistance) {
        currentIndex -= 1; //向右
    }else if (endX - startX >= dragMinDistance){
        currentIndex += 1 ;//向左
    }
    NSInteger maxIndex  = [cardCollectionVIew numberOfItemsInSection:0] - 1;
    currentIndex = currentIndex <= 0 ? 0 :currentIndex;
    currentIndex = currentIndex >= maxIndex ? maxIndex : currentIndex;
    
    bgImageV.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",imageArray[currentIndex]]];
    
    [cardCollectionVIew scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:currentIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    
    if ([Healp isLightColor:[UIColor colorWithPatternImage:[Healp imageFromView:bgImageV atFrame:CGRectMake(0, 0, LZScreenW, 100)]]]) {
        self.titleLB.textColor = [UIColor blackColor];
    }else{
        self.titleLB.textColor = [UIColor whiteColor];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
