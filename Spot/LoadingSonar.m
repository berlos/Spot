//
//  LoadingSonar.m
//  Spot
//
//  Created by Carlos Silva on 11/26/14.
//  Copyright (c) 2014 Carlos Silva. All rights reserved.
//

#import "LoadingSonar.h"

@implementation LoadingSonar

- (void)didMoveToView: (SKView *) view
{
    if (!self.contentCreated)
    {
        [self createSceneContents];
        self.contentCreated = YES;
    }
}


- (void)createSceneContents
{
    self.backgroundColor = [SKColor blackColor];
    //self.scaleMode = SKSceneScaleModeAspectFit;
    
    
    SKTextureAtlas *atlas = [SKTextureAtlas atlasNamed:@"spot"];
    SKTexture *f1 = [atlas textureNamed:@"sonar.png"];
    SKTexture *f2 = [atlas textureNamed:@"sonar2.png"];
    SKTexture *f3 = [atlas textureNamed:@"sonar3.png"];
    SKTexture *f4 = [atlas textureNamed:@"sonar4.png"];
    SKTexture *f5 = [atlas textureNamed:@"sonar5.png"];
    SKTexture *f6 = [atlas textureNamed:@"sonar6.png"];
    SKTexture *f7 = [atlas textureNamed:@"sonar7.png"];
    SKTexture *f8 = [atlas textureNamed:@"sonar8.png"];
    SKTexture *f9 = [atlas textureNamed:@"sonar9.png"];
    SKTexture *f10 = [atlas textureNamed:@"sonar10.png"];
    SKTexture *f11 = [atlas textureNamed:@"sonar11.png"];
    
    
    NSArray *publicoTextures = @[f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11];
    
    SKSpriteNode *publico = [SKSpriteNode spriteNodeWithImageNamed:@"sonar11.png"];
    publico.position = CGPointMake(70,100); //165,300
    //publico.position = CGPointMake(25,25);
    
    [self addChild: publico];
    
    SKAction *pAnimation = [SKAction animateWithTextures:publicoTextures timePerFrame:0.1];
    pAnimation = [SKAction repeatActionForever:pAnimation];
    [publico runAction:pAnimation];
    
}


@end

