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
    
    CGRect makeRect = CGRectMake(0, 0, 300, 600);
    
    CAKeyframeAnimation *greenRectangle = [CAKeyframeAnimation animation];
    greenRectangle.keyPath = @"position";
    greenRectangle.path = CFAutorelease(CGPathCreateWithRect(makeRect, NULL));
    greenRectangle.duration = 4;
    greenRectangle.additive = YES;
    greenRectangle.repeatCount = HUGE_VALF;
    greenRectangle.calculationMode = kCAAnimationPaced;
    greenRectangle.rotationMode = kCAAnimationRotateAuto;
    greenRectangle.speed = 5.0;
    
    [self.firstView.layer addAnimation:greenRectangle forKey:@"greenRectangle"];
    
//    CGRect makeRectTwo = CGRectMake(-300, 0, 300, 600);
    
    CAKeyframeAnimation *blueRectangle = [CAKeyframeAnimation animation];
    blueRectangle.keyPath = @"position";
    blueRectangle.path = CFAutorelease(CGPathCreateCopy(greenRectangle.path));
    blueRectangle.duration = 4;
    blueRectangle.additive = YES;
    blueRectangle.repeatCount = HUGE_VALF;
    blueRectangle.calculationMode = kCAAnimationPaced;
    blueRectangle.rotationMode = kCAAnimationRotateAuto;
    
    [self.secondView.layer addAnimation:blueRectangle forKey:@"blueRectangle"];
    
    CGRect makeRectThree = CGRectMake(-300, -600, 300, 600);
    
    CAKeyframeAnimation *redRectangle = [CAKeyframeAnimation animation];
    redRectangle.path = CFAutorelease(CGPathCreateWithRect(makeRectThree, NULL));
    redRectangle.keyPath = @"position";
    redRectangle.duration = 4;
    redRectangle.additive = YES;
    redRectangle.repeatCount = HUGE_VALF;
    redRectangle.calculationMode = kCAAnimationCubic;
    redRectangle.rotationMode = kCAAnimationRotateAuto;
    
    [self.thirdView.layer addAnimation:redRectangle forKey:@"redRectangle"];
    
    CGRect makeRectFour = CGRectMake(0, 0, 300, 600);
    
    CAKeyframeAnimation *yellowRectangle = [CAKeyframeAnimation animation];
    yellowRectangle.keyPath = @"position";
    yellowRectangle.path = CFAutorelease(CGPathCreateWithRect(makeRectFour, NULL));
    yellowRectangle.duration = 4;
    yellowRectangle.additive = YES;
    yellowRectangle.repeatCount = HUGE_VALF;
    yellowRectangle.calculationMode = kCAAnimationPaced;
    yellowRectangle.rotationMode = kCAAnimationRotateAuto;
    
    [self.fourthView.layer addAnimation:yellowRectangle forKey:@"yellowRectangle"];
    
}

@end
