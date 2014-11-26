//
//  ShoeCollectionViewCell.h
//  Spot
//
//  Created by Carlos Silva on 11/24/14.
//  Copyright (c) 2014 Carlos Silva. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShoeItem.h"

@interface ShoeCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *IV_Image;
@property (nonatomic, strong) NSString *imageName;

-(void)bindData:(ShoeItem *)itemData;

@end
