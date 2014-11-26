//
//  MobileCollectionViewCell.h
//  Spot
//
//  Created by Carlos Silva on 11/23/14.
//  Copyright (c) 2014 Carlos Silva. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MobileItem.h"
#import <XCDYouTubeVideoPlayerViewController.h>
#import <XCDYouTubeClient.h>

@interface MobileCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIView *VW_Background;
@property (weak, nonatomic) IBOutlet UIImageView *IV_Image;
@property (strong, nonatomic) XCDYouTubeVideoPlayerViewController *moviePlayerController;

-(void)bindData:(MobileItem *)itemData;
-(void)bindDataImage:(MobileItem *)itemData;

@end
