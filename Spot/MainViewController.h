//
//  ViewController.h
//  Spot
//
//  Created by Carlos Silva on 11/22/14.
//  Copyright (c) 2014 Carlos Silva. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>
#import "SpotManager.h"

@interface MainViewController : UIViewController <SpotManagerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *LB_MessageToUser;
@property (weak, nonatomic) IBOutlet UILabel *LB_ProductToChoose;
@property (weak, nonatomic) IBOutlet UIButton *BT_Recheck;
@property (weak, nonatomic) IBOutlet SKView *VW_Loading;
@property (weak, nonatomic) IBOutlet UITableView *productsTableView;
@property (nonatomic, strong) NSArray *workArray;
@property int identifierClass;
@property id activeItem;

- (IBAction)BT_RecheckTapped:(id)sender;

+(MainViewController *)sharedInstance;

@end

