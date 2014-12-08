//
//  ColaViewController.m
//  Spot
//
//  Created by Carlos Silva on 11/23/14.
//  Copyright (c) 2014 Carlos Silva. All rights reserved.
//

#import "ColaViewController.h"
#import "ColaCollectionViewCell.h"
#import "MainViewController.h"

@interface ColaViewController ()

@property BOOL initialScroll;
@property BOOL pictureView;
@property (nonatomic, strong) UILabel *LB_NavTitle;
@property NSInteger previousPage;

@end

@implementation ColaViewController

@synthesize colaArray, collectionVC, initialScroll, selectedIndexPath, LB_NavTitle, pictureView, previousPage;

static NSString * const reuseIdentifier = @"ColaCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    initialScroll = NO;
    pictureView = NO;
    previousPage = 0;
    
    [self.navigationController.navigationBar.topItem setTitle:@""];
    [self.navigationController.navigationBar setTintColor:[UIColor orangeColor]];
    [self.navigationController.navigationBar setBarTintColor:[UIColor blackColor]];
    
    LB_NavTitle = [[UILabel alloc]initWithFrame:CGRectZero];
    [LB_NavTitle setBackgroundColor:[UIColor clearColor]];
    [LB_NavTitle setFont:[UIFont fontWithName:@"Helvetica-Bold" size:15]];
    [LB_NavTitle setTextAlignment:NSTextAlignmentCenter];
    [LB_NavTitle setTextColor:[UIColor orangeColor]];
    [LB_NavTitle setText:@"Drink"];
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

-(void)bindData:(ColaItem *)itemData
{
    [collectionVC setAllowsMultipleSelection:NO];
    [collectionVC setDirectionalLockEnabled:YES];
    [collectionVC setShowsHorizontalScrollIndicator:NO];
    [collectionVC setShowsVerticalScrollIndicator:NO];
    [collectionVC setPagingEnabled:YES];
    [collectionVC setScrollEnabled:YES];
    
    [collectionVC  registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    UINib *mobileViewCell = [UINib nibWithNibName:@"ColaCollectionViewCell" bundle:nil];
    [collectionVC registerNib:mobileViewCell forCellWithReuseIdentifier:@"ColaCell"];
    
    [_LB_Type setText:itemData.itemType];
    [_LB_Capacity setText:itemData.itemCapacity];
    [_LB_Description setText:itemData.itemDescription];
    [_BT_FirstImage setImage:[UIImage imageNamed:itemData.itemImageSmall] forState:UIControlStateNormal];
    [_BT_Video setImage:[UIImage imageNamed:itemData.itemImageSmall] forState:UIControlStateNormal];
    
}

- (IBAction)BT_ImageTapped:(id)sender
{
    pictureView = YES;
    [collectionVC reloadData];
}

- (IBAction)BT_VideoTapped:(id)sender
{
    pictureView = NO;
    [collectionVC reloadData];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [colaArray count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ColaItem *colaItem = [[ColaItem alloc]init];
    
    colaItem = [colaArray objectAtIndex:indexPath.row];
    
    static NSString *cellIdentifier = @"ColaCell";
    
    ColaCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    if (pictureView)
    {
        [cell bindDataImage:colaItem];
    }
    else
    {
        [cell bindData:colaItem];
    }
    
    selectedIndexPath = indexPath;
    
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
    
    CGFloat pageWidth = scrollView.frame.size.width;
    float fractionalPage = scrollView.contentOffset.x / pageWidth;
    NSInteger page = lround(fractionalPage);
    if (previousPage != page)
    {
        [self cellDataPrepare:[NSIndexPath indexPathForRow:page inSection:0]];
        
        previousPage = page;
    }
    
}

-(void)cellDataPrepare:(NSIndexPath *)cellPath
{
    selectedIndexPath = cellPath;

    ColaItem *colaItem = [[ColaItem alloc]init];
    
    colaItem = [colaArray objectAtIndex:cellPath.row];
    
    [_LB_Title setText:colaItem.itemName];
    [_LB_Capacity setText:colaItem.itemCapacity];
    [_LB_Type setText:colaItem.itemType];
    [_LB_Description setText:colaItem.itemDescription];
    [_BT_FirstImage setImage:[UIImage imageNamed:colaItem.itemImageSmall] forState:UIControlStateNormal];
    [_BT_Video setImage:[UIImage imageNamed:colaItem.itemImageSmall] forState:UIControlStateNormal];
}

- (void)didMoveToParentViewController:(UIViewController *)parent
{
    if (!parent)
    {
        ColaCollectionViewCell *cell = (ColaCollectionViewCell *)[collectionVC cellForItemAtIndexPath:selectedIndexPath];
        
        [cell.moviePlayerController.moviePlayer stop];
        
        ColaItem *item = [[ColaItem alloc]init];
        
        item = [colaArray objectAtIndex:selectedIndexPath.row];
        
        [[MainViewController sharedInstance] setWorkArray:[[NSArray alloc] initWithObjects:item, nil]];
        [[MainViewController sharedInstance] setIdentifierClass:2];
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