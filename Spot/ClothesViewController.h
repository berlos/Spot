//
//  ClothesViewController.h
//  Spot
//
//  Created by Carlos Silva on 11/23/14.
//  Copyright (c) 2014 Carlos Silva. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ClothesItem.h"

@interface ClothesViewController : UIViewController

@property (weak, nonatomic) IBOutlet UICollectionView *collectionVC;
@property (weak, nonatomic) IBOutlet UILabel *LB_Model;
@property (weak, nonatomic) IBOutlet UILabel *LB_Size;
@property (weak, nonatomic) IBOutlet UILabel *LB_Material;
@property (weak, nonatomic) IBOutlet UILabel *LB_Brand;
@property (weak, nonatomic) IBOutlet UILabel *LB_Info;
@property (weak, nonatomic) IBOutlet UIButton *BT_FirstImage;
@property (weak, nonatomic) IBOutlet UIButton *BT_SecondImage;
@property (weak, nonatomic) IBOutlet UILabel *LB_Title;
@property (weak, nonatomic) IBOutlet UINavigationItem *navItem;
@property (nonatomic, strong) NSIndexPath *selectedIndexPath;
@property (nonatomic, strong) NSString *imageName;
@property (nonatomic, strong) NSArray *clothesArray;

-(IBAction)BT_FirstImageTapped:(id)sender;
-(IBAction)BT_SecondImageTapped:(id)sender;

-(void)bindData:(ClothesItem *)itemData;

@end
