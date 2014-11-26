//
//  ShoeItem.h
//  Spot
//
//  Created by Carlos Silva on 11/24/14.
//  Copyright (c) 2014 Carlos Silva. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShoeItem : NSObject

@property (nonatomic, strong) NSString *itemName;
@property (nonatomic, strong) NSString *itemInfo;
@property (nonatomic, strong) NSString *itemBrand;
@property (nonatomic, strong) NSString *itemMaterial;
@property (nonatomic, strong) NSString *itemImage;
@property (nonatomic, strong) NSArray *itemImagesArray;
@property (nonatomic, strong) NSArray *itemSmallImagesArray;
@property (nonatomic, strong) NSNumber *itemID;

@property int itemSize;

@end
