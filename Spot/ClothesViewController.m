//
//  ClothesViewController.m
//  Spot
//
//  Created by Carlos Silva on 11/23/14.
//  Copyright (c) 2014 Carlos Silva. All rights reserved.
//

#import "ClothesViewController.h"
#import "ClothesCollectionViewCell.h"
#import "MainViewController.h"

@interface ClothesViewController ()

@property BOOL initialScroll;
@property BOOL smallImagesPressed;
@property (nonatomic, strong) UILabel *LB_NavTitle;

@end

@implementation ClothesViewController

@synthesize initialScroll, clothesArray, selectedIndexPath, collectionVC, LB_NavTitle, imageName, smallImagesPressed;

static NSString * const reuseIdentifier = @"ClothesCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    initialScroll = NO;
    smallImagesPressed = NO;
    
    [self.navigationController.navigationBar.topItem setTitle:@""];
    [self.navigationController.navigationBar setTintColor:[UIColor orangeColor]];
    [self.navigationController.navigationBar setBarTintColor:[UIColor blackColor]];
    
    LB_NavTitle = [[UILabel alloc]initWithFrame:CGRectZero];
    [LB_NavTitle setBackgroundColor:[UIColor clearColor]];
    [LB_NavTitle setFont:[UIFont fontWithName:@"Helvetica-Bold" size:15]];
    [LB_NavTitle setTextAlignment:NSTextAlignmentCenter];
    [LB_NavTitle setTextColor:[UIColor orangeColor]];
    [LB_NavTitle setText:@"Clothes"];
    [self.navItem setTitleView:LB_NavTitle];
    [LB_NavTitle sizeToFit];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews
{
    if (!initialScroll)
    {
        [collectionVC scrollToItemAtIndexPath:selectedIndexPath
                             atScrollPosition:UICollectionViewScrollPositionRight animated:NO];
    }
    
}

- (IBAction)BT_FirstImageTapped:(id)sender
{
    smallImagesPressed = YES;
    UIButton *bt = (UIButton *)sender;
    ClothesItem *item = [clothesArray objectAtIndex:selectedIndexPath.row];
    
    imageName = [item.itemImagesArray objectAtIndex:bt.tag];
    [collectionVC reloadData];
}

- (IBAction)BT_SecondImageTapped:(id)sender
{
    smallImagesPressed = YES;
    UIButton *bt = (UIButton *)sender;
    ClothesItem *item = [clothesArray objectAtIndex:selectedIndexPath.row];
    
    imageName = [item.itemImagesArray objectAtIndex:bt.tag];
    [collectionVC reloadData];
    
}

-(void)bindData:(ClothesItem *)itemData
{
    [collectionVC setAllowsMultipleSelection:NO];
    [collectionVC setDirectionalLockEnabled:YES];
    [collectionVC setShowsHorizontalScrollIndicator:NO];
    [collectionVC setShowsVerticalScrollIndicator:NO];
    [collectionVC setPagingEnabled:YES];
    [collectionVC setScrollEnabled:YES];
    
    [collectionVC  registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    UINib *mobileViewCell = [UINib nibWithNibName:@"ClothesCollectionViewCell" bundle:nil];
    [collectionVC registerNib:mobileViewCell forCellWithReuseIdentifier:@"ClothesCell"];
    
    [_LB_Model setText:itemData.itemName];
    [_LB_Info setText:itemData.itemInfo];
    [_LB_Brand setText:itemData.itemBrand];
    [_LB_Size setText:itemData.itemSize];
    [_LB_Material setText:itemData.itemMaterial];
    
    [_BT_FirstImage setImage:[UIImage imageNamed:[itemData.itemSmallImagesArray objectAtIndex:0]] forState:UIControlStateNormal];
    [_BT_SecondImage setImage:[UIImage imageNamed:[itemData.itemSmallImagesArray objectAtIndex:1]] forState:UIControlStateNormal];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [clothesArray count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ClothesItem *item = [[ClothesItem alloc]init];
    
    item = [clothesArray objectAtIndex:indexPath.row];
    
    static NSString *cellIdentifier = @"ClothesCell";
    
    ClothesCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    if (!smallImagesPressed)
    {
        imageName = [item.itemImagesArray objectAtIndex:0];
    }
    else
    {
        smallImagesPressed = NO;
    }
    
    [cell setImageName:imageName];
    [cell bindData:item];
    
    return cell;
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
}


#pragma mark <UICollectionViewDelegate>
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize itemSize = CGSizeMake(320, 240);
    
    return itemSize;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    initialScroll = YES;
    
    for (UICollectionViewCell *cell in [collectionVC visibleCells])
    {
        NSIndexPath *activeIndex = [collectionVC indexPathForCell:cell];
        selectedIndexPath = activeIndex;
        [self cellDataPrepare:activeIndex];
        
    }
}

-(void)cellDataPrepare:(NSIndexPath *)cellPath
{
    ClothesItem *item = [[ClothesItem alloc]init];
    
    item = [clothesArray objectAtIndex:cellPath.row];
    
    [_LB_Title setText:item.itemName];
    [_LB_Model setText:item.itemName];
    [_LB_Info setText:item.itemInfo];
    [_LB_Brand setText:item.itemBrand];
    [_LB_Size setText:item.itemSize];
    [_LB_Material setText:item.itemMaterial];
    imageName = [item.itemImagesArray objectAtIndex:0];
    
    [_BT_FirstImage setImage:[UIImage imageNamed:[item.itemSmallImagesArray objectAtIndex:0]] forState:UIControlStateNormal];
    [_BT_SecondImage setImage:[UIImage imageNamed:[item.itemSmallImagesArray objectAtIndex:1]] forState:UIControlStateNormal];
    
}

- (void)didMoveToParentViewController:(UIViewController *)parent
{
    if (!parent)
    {
        ClothesItem *item = [[ClothesItem alloc]init];
        
        item = [clothesArray objectAtIndex:selectedIndexPath.row];
        
        [[MainViewController sharedInstance] setWorkArray:[[NSArray alloc] initWithObjects:item, nil]];
        [[MainViewController sharedInstance] setIdentifierClass:3];
        [[MainViewController sharedInstance].productsTableView reloadData];
        [[MainViewController sharedInstance].LB_ProductToChoose setHidden:NO];
        [[MainViewController sharedInstance].productsTableView setHidden:NO];
        [[MainViewController sharedInstance].VW_Loading setHidden:YES];
    }
    
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end

