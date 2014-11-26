//
//  MobileCollectionViewCell.m
//  Spot
//
//  Created by Carlos Silva on 11/23/14.
//  Copyright (c) 2014 Carlos Silva. All rights reserved.
//

#import "MobileCollectionViewCell.h"
#import <XCDYouTubeVideoPlayerViewController.h>
#import <XCDYouTubeClient.h>

@interface MobileCollectionViewCell ()

@property (strong, nonatomic) MPMoviePlayerController *moviePlayer;

@end

@implementation MobileCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
}


-(void)bindData:(MobileItem *)itemData
{
    [_IV_Image setHidden:YES];
    [self.moviePlayerController.moviePlayer stop];
    [self.moviePlayerController.view removeFromSuperview];
    
    NSRange rangeOfSubstring = [itemData.itemMovieUrl rangeOfString:@"embed/"];
    
    NSString *finalStr = nil;
    
    if(rangeOfSubstring.location == NSNotFound)
    {
        finalStr = [self extractYoutubeID:itemData.itemMovieUrl];
        [self playMovieAtURL:finalStr];
    }
    else
    {
        // return only that portion of 'string' up to where '<a href' was found
        finalStr = [itemData.itemMovieUrl substringFromIndex:rangeOfSubstring.location];
        [self playMovieAtURL:[finalStr substringWithRange:NSMakeRange(6, 11)]];
    }
    

}

-(void)bindDataImage:(MobileItem *)itemData
{
    [self.moviePlayerController.moviePlayer stop];
    [self.moviePlayerController.view removeFromSuperview];
    [_IV_Image setImage:[UIImage imageNamed:itemData.itemImage]];
    [_IV_Image setHidden:NO];
}

-(void)playMovieAtURL:(NSString *)movieString
{
    self.moviePlayerController = [[XCDYouTubeVideoPlayerViewController alloc] initWithVideoIdentifier:movieString];
    [self.moviePlayerController presentInView:_VW_Background];
    [self.moviePlayerController.moviePlayer play];
    
}

-(NSString *)extractYoutubeID:(NSString *)youtubeURL
{
    NSString *regexString = @"(?<=v(=|/))([-a-zA-Z0-9_]+)|(?<=youtu.be/)([-a-zA-Z0-9_]+)";
    NSError *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regexString options:NSRegularExpressionCaseInsensitive error:&error];
    NSRange rangeOfFirstMatch = [regex rangeOfFirstMatchInString:youtubeURL options:0 range:NSMakeRange(0, [youtubeURL length])];
    if(!NSEqualRanges(rangeOfFirstMatch, NSMakeRange(NSNotFound, 0)))
    {
        NSString *substringForFirstMatch = [youtubeURL substringWithRange:rangeOfFirstMatch];
        
        return substringForFirstMatch;
    }
    return nil;
}

/*
-(void)playMovieAtURL:(NSURL*)theURL
{
    self.moviePlayer = [[MPMoviePlayerController alloc] initWithContentURL:theURL];
    [self.moviePlayer.view setFrame:CGRectMake(0, 0, _VW_Background.bounds.size.width, _VW_Background.bounds.size.height)];
    self.moviePlayer.view.autoresizingMask = UIViewAutoresizingFlexibleWidth ;
    
    [self.moviePlayer.backgroundView setBackgroundColor:[UIColor blackColor]];//[UIColor colorWithRed:31.0/255.0 green:31.0/255.0 blue:31.0/255.0 alpha:1]];
    
    [self.moviePlayer play];
    // https://www.youtube.com/watch?v=RS5mzvqWM-c&feature=youtube_gdata_player
    [_VW_Background addSubview:self.moviePlayer.view];
}*/

@end
