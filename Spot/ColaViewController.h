//
//  ColaViewController.h
//  Spot
//
//  Created by Carlos Silva on 11/23/14.
//  Copyright (c) 2014 Carlos Silva. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ColaItem.h"

@interface ColaViewController : UIViewController

@property (nonatomic, strong) NSArray *colaArray;
@property (nonatomic, strong) NSIndexPath *selectedIndexPath;
@property (weak, nonatomic) IBOutlet UIView *VW_Bottom;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionVC;
@property (weak, nonatomic) IBOutlet UILabel *LB_Type;
@property (weak, nonatomic) IBOutlet UILabel *LB_Description;
@property (weak, nonatomic) IBOutlet UILabel *LB_Capacity;
@property (weak, nonatomic) IBOutlet UINavigationItem *navItem;
@property (weak, nonatomic) IBOutlet UILabel *LB_Title;
@property (weak, nonatomic) IBOutlet UIButton *BT_FirstImage;
@property (weak, nonatomic) IBOutlet UIButton *BT_Video;

- (IBAction)BT_ImageTapped:(id)sender;
- (IBAction)BT_VideoTapped:(id)sender;

-(void)bindData:(ColaItem *)itemData;

@end
