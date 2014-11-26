//
//  ColaCollectionViewCell.m
//  Spot
//
//  Created by Carlos Silva on 11/25/14.
//  Copyright (c) 2014 Carlos Silva. All rights reserved.
//

#import "ColaCollectionViewCell.h"

@interface ColaCollectionViewCell ()

@end

@implementation ColaCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
    
}


-(void)bindData:(ColaItem *)itemData
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

-(void)bindDataImage:(ColaItem *)itemData
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




@end

