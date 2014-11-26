//
//  ShoeCollectionViewCell.m
//  Spot
//
//  Created by Carlos Silva on 11/24/14.
//  Copyright (c) 2014 Carlos Silva. All rights reserved.
//

#import "ShoeCollectionViewCell.h"

@implementation ShoeCollectionViewCell

@synthesize IV_Image, imageName;

- (void)awakeFromNib {
    // Initialization code
}

-(void)bindData:(ShoeItem *)itemData
{    
    [IV_Image setImage:[UIImage imageNamed:imageName]];
}

@end
