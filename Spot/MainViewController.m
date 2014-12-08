//
//  ViewController.m
//  Spot
//
//  Created by Carlos Silva on 11/22/14.
//  Copyright (c) 2014 Carlos Silva. All rights reserved.
//

#import "MainViewController.h"
#import "ProductsTableViewCell.h"
#import "IphoneViewController.h"
#import "ShoesViewController.h"
#import "ColaViewController.h"
#import "ClothesViewController.h"
#import "MobileItem.h"
#import "ShoeItem.h"
#import "ColaItem.h"
#import "LoadingSonar.h"
#import <SpotzSDK/SpotzSDK.h>

typedef enum {
    iPhone = 0,
    shoes,
    cocacola,
    clothes,
} ProductName;


static MainViewController *singletonMainViewController;

@interface MainViewController ()

@property (nonatomic, strong) UIViewController *activeVC;
@property (nonatomic, strong) UIStoryboard *storyboard;
@property SpotManager *serviceManager;

@end

@implementation MainViewController

@synthesize LB_MessageToUser, LB_ProductToChoose, activeVC, workArray, identifierClass, activeItem, storyboard, serviceManager;

+(MainViewController *)sharedInstance
{
    return singletonMainViewController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [_BT_Recheck setEnabled:NO];
    [LB_MessageToUser setText:@"Please Wait..."];
    [LB_MessageToUser sizeToFit];
    [LB_ProductToChoose setHidden:YES];
    [_productsTableView setHidden:YES];
    
    [_VW_Loading setHidden:NO];
    SKView *spriteView = (SKView *) _VW_Loading;
    
    LoadingSonar *loadingP = [LoadingSonar sceneWithSize:spriteView.bounds.size];
    loadingP.scaleMode = SKSceneScaleModeAspectFill;
    
    [spriteView presentScene: loadingP];
    
    [SpotzSDK reset];
    
    [SpotzSDK initializeWithAppId:@"k6k7h2ZrzzOjl5dIzykjgkiptXJiwFwrkwJULic4" clientKey:@"M2K4uzaoLdNxuEjkiEBgYy6p40AmtAB7Ku6yGY9u" delegate:self withOptions:nil];
    
    serviceManager = [[SpotManager alloc]init];
    
    [serviceManager setDelegate:self];
    
    singletonMainViewController = self;
    
    UINib *productsNib = [UINib nibWithNibName:@"ProductsTableViewCell" bundle:nil];
    [_productsTableView registerNib:productsNib forCellReuseIdentifier:@"dataCell"];
    
    [self showSpotzDetails:nil];
    [self showBeaconDetails:nil];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:SpotzInsideNotification object:nil queue:nil usingBlock:^(NSNotification *note)
     {
         //self.lbStatus.text = @"Spotz rocks!";
         
         [_BT_Recheck setEnabled:YES];
         
         [LB_MessageToUser setText:@"Found a product"];
         [LB_MessageToUser sizeToFit];
         
         [LB_ProductToChoose setHidden:NO];
         [_productsTableView setHidden:NO];
         
         if(note.object)
         {
             // the dictionary will contain a spotz object and a beacon object from inside notification
             NSDictionary *data = note.object;
             Spotz *spotz = data[@"spotz"];
             SpotzBeacon *beacon = data[@"beacon"];
             [_VW_Loading setHidden:YES];
             
             if (activeVC)
             {
                 [self.navigationController popViewControllerAnimated:YES];
                 activeVC = nil;
             }
             
             if ([beacon.serial isEqualToString:@"LmgIZD"]) //Fd03iD
             {
                 [serviceManager getMobile];
             }
             else if ([beacon.serial isEqualToString:@"XNOIZD"]) //vO03iD
             {
                 [serviceManager getShoes];
             }
             else if ([beacon.serial isEqualToString:@"FrIIZD"]) //QR03iD
             {
                 
                 [serviceManager getCola];
                 
             }
             else if ([beacon.serial isEqualToString:@"xPAIZD"]) //LU03iD
             {
                 
                 [serviceManager getClothes];
             }
             
             NSLog(@"Show spotz details");
             
             NSLog(@"Enter beacon detected with UUID: %@ major: %i minor: %i",beacon.uuid,beacon.major,beacon.minor);
             NSLog(@"Spotz id: %@ name: %@",spotz.id,spotz.name);
             
             // show the spotz and beacon data
             [self showSpotzDetails:spotz];
             [self showBeaconDetails:beacon];
         }
         else
         {
             [self showSpotzDetails:nil];
             [self showBeaconDetails:nil];
         }
     }];
    [[NSNotificationCenter defaultCenter] addObserverForName:SpotzOutsideNotification object:nil queue:nil usingBlock:^(NSNotification *note)
     {
         [_BT_Recheck setEnabled:YES];
         
         [LB_MessageToUser setText:@"Please take closer to a product"];
         [LB_MessageToUser sizeToFit];
         [LB_ProductToChoose setHidden:YES];
         [_productsTableView setHidden:YES];
         
         if(note.object)
         {
             // the dictionary will contain a spotz object and a beacon object from outside notification
             NSDictionary *data = note.object;
             Spotz *spotz = data[@"spotz"];
             SpotzBeacon *beacon = data[@"beacon"];
             
             [_VW_Loading setHidden:NO];

             [LB_ProductToChoose setHidden:YES];
             [_productsTableView setHidden:YES];
             [self.navigationController popViewControllerAnimated:YES];
             activeVC = nil;
             
             // if we have received an outside notification from the current spot, clear the screen (if not, the screen will contain info from another spot which we want to keep there)
             /*
              if ([self.lbBeaconDetails.text isEqualToString:[NSString stringWithFormat:@"major:%i  minor:%i  serial(%@)\n%@", beacon.major, beacon.minor, beacon.serial, beacon.uuid]])
              {
              self.lbStatus.text = @"Find me spotz yo!";
              [self showSpotzDetails:nil];
              [self showBeaconDetails:nil];
              }
              */
             NSLog(@"Exit beacon detected with UUID: %@ major: %i minor: %i",beacon.uuid,beacon.major,beacon.minor);
             NSLog(@"Spotz id: %@ name: %@",spotz.id,spotz.name);
         }
     }];
    [[NSNotificationCenter defaultCenter] addObserverForName:SpotzRangingNotification object:nil queue:nil usingBlock:^(NSNotification *note) {
        // beacon details are not relevant so hide clear them
        [self showBeaconDetails:nil];
        
        [_BT_Recheck setEnabled:YES];
        
        if (note.object)
        {
            // the dictionary will contain a spotz object and its accuracy
            NSDictionary *data = note.object;
            
            Spotz *spotz = data[@"spotz"];
            //NSNumber *acc = data[@"accuracy"];
            
            NSLog(@"Show spotz ranging details");
            
            // show any spotz data
            [self showSpotzDetails:spotz];
            
            // show the accuracy of the spotz
            /*
             self.lbBeaconDetails.hidden = false;
             self.lbBeaconDetails.text = [NSString stringWithFormat:@"Accuracy: %fm", acc.floatValue];
             */
        }
        else
        {
            //self.lbBeaconDetails.hidden = true;
        }
        
    }];
}

- (void) showSpotzDetails:(Spotz *)spotz
{
    if(spotz)
    {
        // show the spotz name and any attributes
        /*
         self.lbSpotzName.hidden = NO;
         self.tableView.hidden = NO;
         self.lbSpotzName.text = spotz.name;
         
         self.spotzData = spotz.data;
         [self.tableView reloadData];
         */
    }
    else
    {
        // hide the spotz name and any attributes
        /*
         self.lbSpotzName.hidden = YES;
         self.tableView.hidden = YES;
         self.spotzData = @{};
         */
    }
}

- (void) showBeaconDetails:(SpotzBeacon *)beacon
{
    if (beacon)
    {
        // show the major, minor, serial and uuid of the beacon
        /*
         self.lbBeaconDetails.hidden = false;
         self.lbBeaconDetails.text = [NSString stringWithFormat:@"major:%i  minor:%i  serial(%@)\n%@", beacon.major, beacon.minor, beacon.serial, beacon.uuid];
         */
    }
    else
    {
        // hide the major, minor, serial and uuid of the beacon
        /*
         self.lbBeaconDetails.hidden = true;*/
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Button actions

- (IBAction)BT_RecheckTapped:(id)sender
{
    [SpotzSDK checkSpotz];
    //[_BT_Recheck setEnabled:NO];
}

#pragma mark - Table delegates

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [workArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // fill each cell with a attribute
    ProductsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"dataCell"];
    
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    
    switch (identifierClass)
    {
        case iPhone:
        {
            MobileItem *mobiItem = (MobileItem *)[workArray objectAtIndex:0];
            [cell.IV_Image setImage:[UIImage imageNamed:mobiItem.itemImage]];
            [cell.LB_Title setText:mobiItem.itemName];
            
            activeItem = mobiItem;
        }
            break;
        case shoes:
        {
            ShoeItem *shoeiItem = (ShoeItem *)[workArray objectAtIndex:0];
            [cell.IV_Image setImage:[UIImage imageNamed:shoeiItem.itemImage]];
            [cell.LB_Title setText:shoeiItem.itemName];
            
            activeItem = shoeiItem;
            
        }
            break;
        case clothes:
        {
            ClothesItem *clothiItem = (ClothesItem *)[workArray objectAtIndex:0];
            [cell.IV_Image setImage:[UIImage imageNamed:clothiItem.itemImage]];
            [cell.LB_Title setText:clothiItem.itemName];
            
            activeItem = clothiItem;
            
        }
            break;
        case cocacola:
        {
            ColaItem *colaiItem = (ColaItem *)[workArray objectAtIndex:0];
            [cell.IV_Image setImage:[UIImage imageNamed:colaiItem.itemImage]];
            [cell.LB_Title setText:colaiItem.itemName];
            
            activeItem = colaiItem;
            
        }
            break;
        default:
            break;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (identifierClass)
    {
        case iPhone:
        {
            MobileItem *mobiItem = (MobileItem *)activeItem;
            
            IphoneViewController *pageContentViewController = [storyboard instantiateViewControllerWithIdentifier:@"IphoneVC"];
            
            [self.navigationController pushViewController:pageContentViewController animated:YES];
            
            pageContentViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
            
            [pageContentViewController setMobileArray:[[NSArray alloc]initWithObjects:mobiItem, nil]];
            [pageContentViewController setSelectedIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
            [pageContentViewController bindData:mobiItem];
            [pageContentViewController.LB_Title setText:mobiItem.itemName];
            
            activeVC = pageContentViewController;
            
        }
            break;
        case shoes:
        {
            ShoeItem *shoeiItem = (ShoeItem *)activeItem;
            
            ShoesViewController *pageContentViewController = [storyboard instantiateViewControllerWithIdentifier:@"ShoesVC"];
            
            [self.navigationController pushViewController:pageContentViewController animated:YES];
            
            pageContentViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
            
            [pageContentViewController setImageName:@"dune.jpeg"];
            [pageContentViewController setShoesArray:[[NSArray alloc]initWithObjects:shoeiItem, nil]];
            [pageContentViewController setSelectedIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
            [pageContentViewController bindData:shoeiItem];
            [pageContentViewController.LB_Title setText:shoeiItem.itemName];
            
            activeVC = pageContentViewController;
            
            
        }
            break;
        case clothes:
        {
            ClothesItem *clothiItem = (ClothesItem *)activeItem;
            
            ClothesViewController *pageContentViewController = [storyboard instantiateViewControllerWithIdentifier:@"ClothesVC"];
            
            [self.navigationController pushViewController:pageContentViewController animated:YES];
            
            pageContentViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
            
            [pageContentViewController setImageName:@"sportingFront.jpeg"];
            [pageContentViewController setClothesArray:[[NSArray alloc]initWithObjects:clothiItem, nil]];
            [pageContentViewController setSelectedIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
            [pageContentViewController bindData:clothiItem];
            [pageContentViewController.LB_Title setText:clothiItem.itemName];
            
            activeVC = pageContentViewController;
        }
            break;
        case cocacola:
        {
            ColaItem *colaiItem = (ColaItem *)activeItem;
            
            ColaViewController *pageContentViewController = [storyboard instantiateViewControllerWithIdentifier:@"ColaVC"];
            
            [self.navigationController pushViewController:pageContentViewController animated:YES];
            
            pageContentViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
            
            [pageContentViewController setColaArray:[[NSArray alloc]initWithObjects:colaiItem, nil]];
            [pageContentViewController setSelectedIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
            [pageContentViewController bindData:colaiItem];
            [pageContentViewController.LB_Title setText:colaiItem.itemName];
            
            
            activeVC = pageContentViewController;
            
        }
            break;
        default:
            break;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

-(void)gotMobile:(NSArray *)mobileArray
{
    MobileItem *mobileItem = [mobileArray objectAtIndex:0];
    
    IphoneViewController *pageContentViewController = [storyboard instantiateViewControllerWithIdentifier:@"IphoneVC"];
    
    [self.navigationController pushViewController:pageContentViewController animated:YES];
    
    pageContentViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    
    [pageContentViewController.LB_Title setText:mobileItem.itemName];
    [pageContentViewController setMobileArray:mobileArray];
    [pageContentViewController setSelectedIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    [pageContentViewController bindData:mobileItem];
    
    activeVC = pageContentViewController;
}

-(void)gotShoes:(NSArray *)shoesArray
{
    ShoeItem *shoeItem = [shoesArray objectAtIndex:0];
    
    ShoesViewController *pageContentViewController = [storyboard instantiateViewControllerWithIdentifier:@"ShoesVC"];
    
    [self.navigationController pushViewController:pageContentViewController animated:YES];
    
    pageContentViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    
    [pageContentViewController.LB_Title setText:shoeItem.itemName];
    [pageContentViewController setImageName:@"dune.jpeg"];
    [pageContentViewController setShoesArray:shoesArray];
    [pageContentViewController setSelectedIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    [pageContentViewController bindData:shoeItem];
    
    activeVC = pageContentViewController;
    
}

-(void)gotCola:(NSArray *)colaArray
{
    ColaItem *colaItem = [colaArray objectAtIndex:0];
    
    ColaViewController *pageContentViewController = [storyboard instantiateViewControllerWithIdentifier:@"ColaVC"];
    
    [self.navigationController pushViewController:pageContentViewController animated:YES];
    
    pageContentViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    
    [pageContentViewController.LB_Title setText:colaItem.itemName];
    [pageContentViewController setColaArray:colaArray];
    [pageContentViewController setSelectedIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    [pageContentViewController bindData:colaItem];
    
    
    activeVC = pageContentViewController;
}

-(void)gotClothes:(NSArray *)clothesArray
{
    ClothesItem *clothItem = [clothesArray objectAtIndex:0];
    
    ClothesViewController *pageContentViewController = [storyboard instantiateViewControllerWithIdentifier:@"ClothesVC"];
    
    [self.navigationController pushViewController:pageContentViewController animated:YES];
    
    pageContentViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    
    [pageContentViewController.LB_Title setText:clothItem.itemName];
    [pageContentViewController setImageName:@"sportingFront.jpeg"];
    [pageContentViewController setClothesArray:clothesArray];
    [pageContentViewController setSelectedIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    [pageContentViewController bindData:clothItem];
    
    activeVC = pageContentViewController;
    
}

#pragma mark - SpotzSDK delegates

- (void)spotzSDKInitSuccessfull
{
    NSLog(@"SpotzSDK initialized successfully");
    [_BT_Recheck setEnabled:YES];
    [LB_MessageToUser setText:@"Please take closer to a product"];
    [LB_MessageToUser sizeToFit];
    [SpotzSDK startServices];
}

- (void)spotzSDKInitFailed:(NSError *)error
{
    [LB_MessageToUser setText:@"Please Wait..."];
    [LB_MessageToUser sizeToFit];
    NSLog(@"Error %@",error);
}

- (void)spotzSDKPushNotificationRegistrationSuccess
{
    NSLog(@"SpotzSDK push notification registration successfull");
}

- (void)spotzSDKPushNotificationRegistrationFailed:(NSError *)error
{
    NSLog(@"SpotzSDK push notification registration failed. %@", error);
}


@end
