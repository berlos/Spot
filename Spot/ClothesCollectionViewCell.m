//
//  ClothesCollectionViewCell.m
//  Spot
//
//  Created by Carlos Silva on 11/25/14.
//  Copyright (c) 2014 Carlos Silva. All rights reserved.
//

#import "ClothesCollectionViewCell.h"

@implementation ClothesCollectionViewCell

@synthesize IV_Image, imageName;

- (void)awakeFromNib {
    // Initialization code
}

-(void)bindData:(ClothesItem *)itemData
{
    [IV_Image setImage:[UIImage imageNamed:imageName]];
}

@end
