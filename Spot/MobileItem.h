//
//  MobileItem.h
//  Spot
//
//  Created by Carlos Silva on 11/23/14.
//  Copyright (c) 2014 Carlos Silva. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MobileItem : NSObject

@property (nonatomic, strong) NSString *itemName;
@property (nonatomic, strong) NSString *itemFeatures;
@property (nonatomic, strong) NSString *itemOS;
@property (nonatomic, strong) NSString *itemProcessor;
@property (nonatomic, strong) NSString *itemStorage;
@property (nonatomic, strong) NSString *itemMovieUrl;
@property (nonatomic, strong) NSString *itemImageSmall;
@property (nonatomic, strong) NSString *itemImage;
@property (nonatomic, strong) NSNumber *itemID;

@end
