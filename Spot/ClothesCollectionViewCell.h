//
//  ClothesCollectionViewCell.h
//  Spot
//
//  Created by Carlos Silva on 11/25/14.
//  Copyright (c) 2014 Carlos Silva. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ClothesItem.h"

@interface ClothesCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *IV_Image;
@property (nonatomic, strong) NSString *imageName;

-(void)bindData:(ClothesItem *)itemData;

@end
