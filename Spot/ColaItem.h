//
//  ColaItem.h
//  Spot
//
//  Created by Carlos Silva on 11/25/14.
//  Copyright (c) 2014 Carlos Silva. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ColaItem : NSObject

@property (nonatomic, strong) NSString *itemName;
@property (nonatomic, strong) NSString *itemCapacity;
@property (nonatomic, strong) NSString *itemDescription;
@property (nonatomic, strong) NSString *itemType;
@property (nonatomic, strong) NSString *itemMovieUrl;
@property (nonatomic, strong) NSString *itemImageSmall;
@property (nonatomic, strong) NSString *itemImage;
@property (nonatomic, strong) NSNumber *itemID;

@end
