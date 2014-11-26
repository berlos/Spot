//
//  ShoesViewController.m
//  Spot
//
//  Created by Carlos Silva on 11/23/14.
//  Copyright (c) 2014 Carlos Silva. All rights reserved.
//

#import "ShoesViewController.h"
#import "ShoeCollectionViewCell.h"
#import "MainViewController.h"

@interface ShoesViewController ()

@property BOOL initialScroll;
@property BOOL smallImagesPressed;
@property (nonatomic, strong) UILabel *LB_NavTitle;

@end

@implementation ShoesViewController

@synthesize initialScroll, shoesArray, selectedIndexPath, collectionVC, LB_NavTitle, imageName, smallImagesPressed;

static NSString * const reuseIdentifier = @"ShoeCell";

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
    [LB_NavTitle setText:@"Shoes"];
    [self.navItem setTitleView:LB_NavTitle];
    [LB_NavTitle sizeToFit];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews
{
    // If we haven't done the initial scroll, do it once.
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
    ShoeItem *itemShoe = [shoesArray objectAtIndex:selectedIndexPath.row];
    
    imageName = [itemShoe.itemImagesArray objectAtIndex:bt.tag];
    [collectionVC reloadData];
}

- (IBAction)BT_SecondImageTapped:(id)sender
{
    smallImagesPressed = YES;
    UIButton *bt = (UIButton *)sender;
    ShoeItem *itemShoe = [shoesArray objectAtIndex:selectedIndexPath.row];
    
    imageName = [itemShoe.itemImagesArray objectAtIndex:bt.tag];
    [collectionVC reloadData];
    
}

- (IBAction)BT_ThirdImageTapped:(id)sender
{
    smallImagesPressed = YES;
    UIButton *bt = (UIButton *)sender;
    ShoeItem *itemShoe = [shoesArray objectAtIndex:selectedIndexPath.row];
    
    imageName = [itemShoe.itemImagesArray objectAtIndex:bt.tag];
    [collectionVC reloadData];
    
}

-(void)bindData:(ShoeItem *)itemData
{
    [collectionVC setAllowsMultipleSelection:NO];
    [collectionVC setDirectionalLockEnabled:YES];
    [collectionVC setShowsHorizontalScrollIndicator:NO];
    [collectionVC setShowsVerticalScrollIndicator:NO];
    [collectionVC setPagingEnabled:YES];
    [collectionVC setScrollEnabled:YES];
    
    [collectionVC  registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    UINib *mobileViewCell = [UINib nibWithNibName:@"ShoeCollectionViewCell" bundle:nil];
    [collectionVC registerNib:mobileViewCell forCellWithReuseIdentifier:@"ShoeCell"];
    
    [_LB_Model setText:itemData.itemName];
    [_LB_Info setText:itemData.itemInfo];
    [_LB_Brand setText:itemData.itemBrand];
    [_LB_Size setText:[@(itemData.itemSize) stringValue]];
    [_LB_Material setText:itemData.itemMaterial];
    
    [_BT_FirstImage setImage:[UIImage imageNamed:[itemData.itemSmallImagesArray objectAtIndex:0]] forState:UIControlStateNormal];
    [_BT_SecondImage setImage:[UIImage imageNamed:[itemData.itemSmallImagesArray objectAtIndex:1]] forState:UIControlStateNormal];
    [_BT_ThirdImage setImage:[UIImage imageNamed:[itemData.itemSmallImagesArray objectAtIndex:2]] forState:UIControlStateNormal];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [shoesArray count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ShoeItem *shoeItem = [[ShoeItem alloc]init];
    
    shoeItem = [shoesArray objectAtIndex:indexPath.row];
    
    static NSString *cellIdentifier = @"ShoeCell";
    
    ShoeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    if (!smallImagesPressed)
    {
        imageName = [shoeItem.itemImagesArray objectAtIndex:0];
    }
    else
    {
        smallImagesPressed = NO;
    }
    
    [cell setImageName:imageName];
    [cell bindData:shoeItem];
    
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
    ShoeItem *shoeItem = [[ShoeItem alloc]init];
    
    shoeItem = [shoesArray objectAtIndex:cellPath.row];
    
    [_LB_Title setText:shoeItem.itemName];
    [_LB_Model setText:shoeItem.itemName];
    [_LB_Info setText:shoeItem.itemInfo];
    [_LB_Brand setText:shoeItem.itemBrand];
    [_LB_Size setText:[@(shoeItem.itemSize) stringValue]];
    [_LB_Material setText:shoeItem.itemMaterial];
    imageName = [shoeItem.itemImagesArray objectAtIndex:0];
    
    [_BT_FirstImage setImage:[UIImage imageNamed:[shoeItem.itemSmallImagesArray objectAtIndex:0]] forState:UIControlStateNormal];
    [_BT_SecondImage setImage:[UIImage imageNamed:[shoeItem.itemSmallImagesArray objectAtIndex:1]] forState:UIControlStateNormal];
    [_BT_ThirdImage setImage:[UIImage imageNamed:[shoeItem.itemSmallImagesArray objectAtIndex:2]] forState:UIControlStateNormal];
    
}

- (void)didMoveToParentViewController:(UIViewController *)parent
{
    if (!parent)
    {
        ShoeItem *item = [[ShoeItem alloc]init];
        
        item = [shoesArray objectAtIndex:selectedIndexPath.row];
        
        [[MainViewController sharedInstance] setWorkArray:[[NSArray alloc] initWithObjects:item, nil]];
        [[MainViewController sharedInstance] setIdentifierClass:1];
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
