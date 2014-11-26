//
//  SpotManager.h
//  Spot
//
//  Created by Carlos Silva on 11/25/14.
//  Copyright (c) 2014 Carlos Silva. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SpotManagerDelegate <NSObject>

@optional

-(void)gotShoes:(NSArray *)shoesArray;
-(void)gotClothes:(NSArray *)clothesArray;
-(void)gotMobile:(NSArray *)mobileArray;
-(void)gotCola:(NSArray *)colaArray;

@end

@interface SpotManager : NSObject
{
    id <SpotManagerDelegate> delegate;
}

@property (retain) id delegate;

-(void)getShoes;
-(void)getClothes;
-(void)getMobile;
-(void)getCola;

@end
