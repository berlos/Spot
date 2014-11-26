//
//  ColaCollectionViewCell.h
//  Spot
//
//  Created by Carlos Silva on 11/25/14.
//  Copyright (c) 2014 Carlos Silva. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ColaItem.h"
#import <XCDYouTubeVideoPlayerViewController.h>
#import <XCDYouTubeClient.h>

@interface ColaCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIView *VW_Background;
@property (weak, nonatomic) IBOutlet UIImageView *IV_Image;
@property (strong, nonatomic) XCDYouTubeVideoPlayerViewController *moviePlayerController;

-(void)bindData:(ColaItem *)itemData;
-(void)bindDataImage:(ColaItem *)itemData;

@end
