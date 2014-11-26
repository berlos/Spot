//
//  ProductsTableViewCell.h
//  Spot
//
//  Created by Carlos Silva on 11/23/14.
//  Copyright (c) 2014 Carlos Silva. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SpotzSDK/SpotzSDK.h>

@interface ProductsTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *LB_Title;
@property (weak, nonatomic) IBOutlet UIImageView *IV_Image;

-(void)bindData:(NSDictionary *)itemData;

@end
