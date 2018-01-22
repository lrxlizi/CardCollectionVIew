//
//  CardCollectionViewCell.m
//  卡片CollectionVIew
//
//  Created by 栗子 on 2017/8/16.
//  Copyright © 2017年 http://www.cnblogs.com/Lrx-lizi/. All rights reserved.
//

#import "CardCollectionViewCell.h"

@implementation CardCollectionViewCell



-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addSubviews];
        
    }
    return self;
}

-(void)addSubviews{
    
    self.layer.cornerRadius = 8;
    self.layer.masksToBounds=YES;
    
    self.imageIV = [[UIImageView alloc]initWithFrame:self.bounds];
    [self.contentView addSubview:self.imageIV];
    
    
}

@end
