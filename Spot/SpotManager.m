//
//  SpotManager.m
//  Spot
//
//  Created by Carlos Silva on 11/25/14.
//  Copyright (c) 2014 Carlos Silva. All rights reserved.
//

#import "SpotManager.h"
#import "MobileItem.h"
#import "ShoeItem.h"
#import "ClothesItem.h"
#import "ColaItem.h"

@implementation SpotManager

@synthesize delegate;

-(void)getShoes
{
    NSMutableArray *shoesArray = [[NSMutableArray alloc]init];
    
    ShoeItem *duneItem = [[ShoeItem alloc]init];
    
    [duneItem setItemName:@"Dune Bayside"];
    [duneItem setItemInfo:@"Crafted from polido leather for a high-shine finish, they feature a lace-up design, contrasting white wedge soles and white laces."];
    [duneItem setItemBrand:@"Dune"];
    [duneItem setItemMaterial:@"Leather"];
    [duneItem setItemImage:@"dune.jpeg"];
    [duneItem setItemImagesArray:[NSArray arrayWithObjects:@"dune.jpeg", @"dune2.jpeg", @"dune3.jpeg", nil]];
    [duneItem setItemSmallImagesArray:[NSArray arrayWithObjects:@"duneSmall.jpeg", @"duneSmall2.jpeg", @"dune3Small.jpeg", nil]];
    [duneItem setItemSize:40];
    
    [shoesArray addObject:duneItem];
    
    ShoeItem *bertieItem = [[ShoeItem alloc]init];
    
    [bertieItem setItemName:@"Bertie Ratton"];
    [bertieItem setItemInfo:@"The Ratton shoes feature round toes, lace-up closures and contrast croc-effect leather toe caps. The result adds a subtle hint of personality to a crisp suit."];
    [bertieItem setItemBrand:@"Bertie"];
    [bertieItem setItemImagesArray:[NSArray arrayWithObjects:@"bertie.jpeg", @"bertie2.jpeg", @"bertie3.jpeg", nil]];
    [bertieItem setItemSmallImagesArray:[NSArray arrayWithObjects:@"bertieSmall.jpeg", @"bertie2Small.jpeg", @"bertie3Small.jpeg", nil]];
    [bertieItem setItemMaterial:@"Leather"];
    [bertieItem setItemImage:@"bertie.jpeg"];
    [bertieItem setItemSize:37];
    
    [shoesArray addObject:bertieItem];
    
    ShoeItem *kgItem = [[ShoeItem alloc]init];
    
    [kgItem setItemName:@"KG"];
    [kgItem setItemInfo:@"Great desert boots will see you through the seasons in style, and this pair from KG by Kurt Geiger is no exception."];
    [kgItem setItemBrand:@"KG"];
    [kgItem setItemImagesArray:[NSArray arrayWithObjects:@"kg.jpeg", @"kg2.jpeg", @"kg3.jpeg", nil]];
    [kgItem setItemSmallImagesArray:[NSArray arrayWithObjects:@"kgSmall.jpeg", @"kg2Small.jpeg", @"kg3Small.jpeg", nil]];
    [kgItem setItemMaterial:@"Leather"];
    [kgItem setItemSize:39];
    [kgItem setItemImage:@"kg.jpeg"];
    
    [shoesArray addObject:kgItem];
    
    [delegate gotShoes:shoesArray];
}

-(void)getClothes
{
    NSMutableArray *clothesArray = [[NSMutableArray alloc]init];
    
    ClothesItem *sportingItem = [[ClothesItem alloc]init];
    
    [sportingItem setItemName:@"Sporting Portugal"];
    [sportingItem setItemInfo:@"One of the big three in Portuguese football, Sporting Lisbon is also one of the founding members of the league."];
    [sportingItem setItemBrand:@"Puma"];
    [sportingItem setItemMaterial:@"Nylon"];
    [sportingItem setItemImage:@"sportingFront.jpg"];
    [sportingItem setItemImagesArray:[NSArray arrayWithObjects:@"sportingFront.jpg", @"sportingBack.jpg", nil]];
    [sportingItem setItemSmallImagesArray:[NSArray arrayWithObjects:@"sportingFrontSmall.jpg", @"sportingBackSmall.jpg", nil]];
    [sportingItem setItemSize:@"S, M, L, XL, XXL"];
    
    [clothesArray addObject:sportingItem];
    
    ClothesItem *chelseaItem = [[ClothesItem alloc]init];
    
    [chelseaItem setItemName:@"Chelsea FC"];
    [chelseaItem setItemInfo:@"Made with an engineered front panel design and ventilated clima cool to keep you cool and dry."];
    [chelseaItem setItemBrand:@"Adidas"];
    [chelseaItem setItemImagesArray:[NSArray arrayWithObjects:@"chelseaFront.jpg", @"chelseaBack.jpg", nil]];
    [chelseaItem setItemSmallImagesArray:[NSArray arrayWithObjects:@"chelseaFrontSmall.jpg", @"chelseaBackSmall.jpg", nil]];
    [chelseaItem setItemMaterial:@"Nylon"];
    [chelseaItem setItemImage:@"chelseaFront.jpeg"];
    [chelseaItem setItemSize:@"S, M, L, XL, XXL"];
    
    [clothesArray addObject:chelseaItem];
    
    ClothesItem *manchesterItem = [[ClothesItem alloc]init];
    
    [manchesterItem setItemName:@"Manchester City"];
    [manchesterItem setItemInfo:@"This is the new mens Man City football shirt which is available to buy online in a full range of adult sizes S, M, L, XL, XXL and is manufactured by Nike."];
    [manchesterItem setItemBrand:@"Nike"];
    [manchesterItem setItemImagesArray:[NSArray arrayWithObjects:@"manchesterFront.jpg", @"manchesterBack.jpg", nil]];
    [manchesterItem setItemSmallImagesArray:[NSArray arrayWithObjects:@"manchesterFrontSmall.jpg", @"manchesterBackSmall.jpg", nil]];
    [manchesterItem setItemMaterial:@"Nylon"];
    [manchesterItem setItemSize:@"S, M, L, XL, XXL"];
    [manchesterItem setItemImage:@"manchesterFront.jpeg"];
    
    [clothesArray addObject:manchesterItem];

    [delegate gotClothes:clothesArray];
}

-(void)getMobile
{
    NSMutableArray *mobileArray = [[NSMutableArray alloc]init];
    
    MobileItem *appleItem = [[MobileItem alloc]init];
    [appleItem setItemName:@"Iphone 6"];
    [appleItem setItemFeatures:@"Back-illuminated sensor (BSI), Autofocus, Phase detection autofocus, Touch to focus, Digital image stabilization, Face detection, Exposure compensation, Burst mode, Digital zoom, Geo tagging, High Dynamic Range mode (HDR), Panorama, Self-timer"];
    [appleItem setItemProcessor:@"Dual core, 1400 MHz, 64-bit"];
    [appleItem setItemStorage:@"128 GB"];
    [appleItem setItemOS:@"iOS (8.x)"];
    [appleItem setItemMovieUrl:@"https://www.youtube.com/watch?v=RS5mzvqWM-c"];
    [appleItem setItemImage:@"iphone.png"];
    [appleItem setItemImageSmall:@"iphoneSmall.png"];
    
    [mobileArray addObject:appleItem];
    
    MobileItem *nokiaItem = [[MobileItem alloc]init];
    [nokiaItem setItemName:@"Lumia 535"];
    [nokiaItem setItemFeatures:@"Autofocus, Face detection, White balance presets, Geo tagging"];
    [nokiaItem setItemProcessor:@"Quad core, 1200 MHz"];
    [nokiaItem setItemStorage:@"8 GB"];
    [nokiaItem setItemOS:@"Windows Phone 8.1"];
    [nokiaItem setItemMovieUrl:@"https://www.youtube.com/watch?v=xL_u52AaEw0&list=UUZPiiUjDlrBv4jiiRqk5dSA"];
    [nokiaItem setItemImage:@"Lumia.jpeg"];
    [nokiaItem setItemImageSmall:@"LumiaSmall.jpeg"];
    
    [mobileArray addObject:nokiaItem];
    
    MobileItem *galaxyItem = [[MobileItem alloc]init];
    [galaxyItem setItemName:@"Samsung Galaxy A5"];
    [galaxyItem setItemFeatures:@"Light sensor, Proximity sensor"];
    [galaxyItem setItemProcessor:@"Quad core, 1200 MHz, ARM Cortex-A53, 64-bit"];
    [galaxyItem setItemStorage:@"16 GB"];
    [galaxyItem setItemOS:@"Android (4.4.4)"];
    [galaxyItem setItemMovieUrl:@"https://www.youtube.com/watch?v=Tv7C4e8thv0"];
    //[galaxyItem setItemMovieUrl:[[NSBundle mainBundle] pathForResource:@"Samsung" ofType:@"mp4"]];
    [galaxyItem setItemImage:@"galaxy.png"];
    [galaxyItem setItemImageSmall:@"galaxySmall.png"];
    
    [mobileArray addObject:galaxyItem];
    
    [delegate gotMobile:mobileArray];

}

-(void)getCola
{
    NSMutableArray *colaArray = [[NSMutableArray alloc]init];
    
    ColaItem *colaItem = [[ColaItem alloc]init];
    [colaItem setItemName:@"Coca Cola"];
    [colaItem setItemDescription:@"Coca-Cola is the most popular and biggest-selling soft drink in history, as well as the best-known brand in the world."];
    [colaItem setItemCapacity:@"1L"];
    [colaItem setItemType:@"Plastic Bottle"];
    [colaItem setItemMovieUrl:@"https://www.youtube.com/watch?v=aMed07FEDEg"];
    [colaItem setItemImage:@"cola.png"];
    [colaItem setItemImageSmall:@"colaSmall.png"];
    
    [colaArray addObject:colaItem];
    
    ColaItem *redbullItem = [[ColaItem alloc]init];
    [redbullItem setItemName:@"Red Bull"];
    [redbullItem setItemDescription:@"Red Bull Energy Drink is providing wings whenever you need them."];
    [redbullItem setItemCapacity:@"22CL"];
    [redbullItem setItemType:@"Can"];
    [redbullItem setItemMovieUrl:@"https://www.youtube.com/watch?v=KgeA0vy0QJU"];
    [redbullItem setItemImage:@"redbull.png"];
    [redbullItem setItemImageSmall:@"redbullSmall.png"];
    
    [colaArray addObject:redbullItem];
    
    ColaItem *budItem = [[ColaItem alloc]init];
    [budItem setItemName:@"Budweiser"];
    [budItem setItemDescription:@"Budweiser is the only major beer in the world using the traditional beechwood ageing process to naturally age the beer."];
    [budItem setItemCapacity:@"33CL"];
    [budItem setItemType:@"Glass Bottle"];
    [budItem setItemMovieUrl:@"https://www.youtube.com/watch?v=uQB7QRyF4p4"];
    [budItem setItemImage:@"budweiser.png"];
    [budItem setItemImageSmall:@"budweiserSmall.png"];
    
    [colaArray addObject:budItem];
    
    ColaItem *heinekenItem = [[ColaItem alloc]init];
    [heinekenItem setItemName:@"Heineken"];
    [heinekenItem setItemDescription:@"Heineken is a 5 % premium lager with a delicate hop and malt aroma."];
    [heinekenItem setItemCapacity:@"33CL"];
    [heinekenItem setItemType:@"Glass Bottle"];
    [heinekenItem setItemMovieUrl:@"https://www.youtube.com/watch?v=S1ZZreXEqSY"];
    [heinekenItem setItemImage:@"heineken.jpg"];
    [heinekenItem setItemImageSmall:@"heinekenSmall.jpg"];
    
    [colaArray addObject:heinekenItem];
    
    [delegate gotCola:colaArray];
}


@end
