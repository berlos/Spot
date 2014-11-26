//
//  ClothesItem.h
//  Spot
//
//  Created by Carlos Silva on 11/25/14.
//  Copyright (c) 2014 Carlos Silva. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ClothesItem : NSObject

@property (nonatomic, strong) NSString *itemName;
@property (nonatomic, strong) NSString *itemInfo;
@property (nonatomic, strong) NSString *itemBrand;
@property (nonatomic, strong) NSString *itemMaterial;
@property (nonatomic, strong) NSString *itemImage;
@property (nonatomic, strong) NSString *itemSize;
@property (nonatomic, strong) NSArray *itemImagesArray;
@property (nonatomic, strong) NSArray *itemSmallImagesArray;
@property (nonatomic, strong) NSNumber *itemID;

@end
