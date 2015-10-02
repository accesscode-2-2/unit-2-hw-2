//
//  SecondViewController.m
//  hw-week-2
//
//  Created by Umar on 10/1/15.
//  Copyright © 2015 Michael Kavouras. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@property (weak, nonatomic) IBOutlet UIView *firstView;

@property (weak, nonatomic) IBOutlet UIView *secondView;

@property (weak, nonatomic) IBOutlet UIView *thirdView;

@property (weak, nonatomic) IBOutlet UIView *fourthView;

@end

@implementation SecondViewController
- (IBAction)startAnimationButton:(id)sender {
    
    CGRect makeRect = CGRectMake(0, 0, 275, 500);
    
    CAKeyframeAnimation *greenRectangle = [CAKeyframeAnimation animation];
    greenRectangle.keyPath = @"position";
    greenRectangle.path = CFAutorelease(CGPathCreateWithRect(makeRect, NULL));
    greenRectangle.duration = 10;
    greenRectangle.additive = YES;
    greenRectangle.repeatCount = HUGE_VALF;
    greenRectangle.calculationMode = kCAAnimationPaced;
    greenRectangle.rotationMode = kCAAnimationRotateAuto;
    greenRectangle.speed = 3.0;
    
    [self.firstView.layer addAnimation:greenRectangle forKey:@"greenRectangle"];
    
    CGRect makeRectTwo = CGRectMake(-250, 0, 200, 500);
    
    CAKeyframeAnimation *blueRectangle = [CAKeyframeAnimation animation];
    blueRectangle.keyPath = @"position";
    blueRectangle.path = CFAutorelease(CGPathCreateWithRect(makeRectTwo, NULL));
    blueRectangle.duration = 4;
    blueRectangle.additive = YES;
    blueRectangle.repeatCount = HUGE_VALF;
    blueRectangle.calculationMode = kCAAnimationPaced;
    blueRectangle.rotationMode = kCAAnimationRotateAuto;
    blueRectangle.speed = 7.0;
    
    [self.secondView.layer addAnimation:blueRectangle forKey:@"blueRectangle"];
    
    CGRect makeRectThree = CGRectMake(0, 0, -40, -30);
    
    CAKeyframeAnimation *redRectangle = [CAKeyframeAnimation animation];
    redRectangle.path = CFAutorelease(CGPathCreateWithRect(makeRectThree, NULL));
    redRectangle.keyPath = @"position";
    redRectangle.duration = 3;
    redRectangle.additive = YES;
    redRectangle.repeatCount = HUGE_VALF;
    redRectangle.calculationMode = kCAAnimationCubic;
    redRectangle.rotationMode = kCAAnimationRotateAuto;
    redRectangle.speed = 10.0;
    
    [self.thirdView.layer addAnimation:redRectangle forKey:@"redRectangle"];
    
    CGRect makeRectFour = CGRectMake(0, 0, 200, -200);
    
    CAKeyframeAnimation *yellowRectangle = [CAKeyframeAnimation animation];
    yellowRectangle.keyPath = @"position";
    yellowRectangle.path = CFAutorelease(CGPathCreateWithRect(makeRectFour, NULL));
    yellowRectangle.duration = 5;
    yellowRectangle.additive = YES;
    yellowRectangle.repeatCount = HUGE_VALF;
    yellowRectangle.calculationMode = kCAAnimationPaced;
    yellowRectangle.rotationMode = kCAAnimationRotateAuto;
    yellowRectangle.speed = .2;
    
    [self.fourthView.layer addAnimation:yellowRectangle forKey:@"yellowRectangle"];
    
}

@end
