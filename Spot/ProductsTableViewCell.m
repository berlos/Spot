//
//  ProductsTableViewCell.m
//  Spot
//
//  Created by Carlos Silva on 11/23/14.
//  Copyright (c) 2014 Carlos Silva. All rights reserved.
//

#import "ProductsTableViewCell.h"

@implementation ProductsTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)bindData:(NSDictionary *)itemData
{
    [_LB_Title setText:[itemData objectForKey:@"Title"]];
    [_IV_Image setImage:[UIImage imageNamed:[itemData objectForKey:@"Image"]]];
    
}


@end
