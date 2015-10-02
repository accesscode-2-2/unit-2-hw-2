//
//  FourthViewController.m
//  hw-week-2
//
//  Created by Umar on 10/2/15.
//  Copyright © 2015 Michael Kavouras. All rights reserved.
//

#import "FourthViewController.h"

@interface FourthViewController ()

@property (weak, nonatomic) IBOutlet UIView *blueView;
@property (weak, nonatomic) IBOutlet UIView *yellowView;

@end

@implementation FourthViewController


- (IBAction)startAnimation:(id)sender {
    
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"transform.rotation.z";
    animation.fromValue = @100;
    animation.toValue = @200;
    animation.duration = 1;
    animation.repeatCount = 100;
    animation.speed = 10;
    
    [self.blueView.layer addAnimation:animation forKey:@"basic"];
    
    CABasicAnimation *secondAnimation = [CABasicAnimation animation];
    secondAnimation.keyPath = @"transform.rotation.z";
    secondAnimation.fromValue = @10;
    secondAnimation.toValue = @20;
    secondAnimation.duration = 1;
    secondAnimation.repeatCount = 20;
    secondAnimation.speed = 3;
    
    [self.yellowView.layer addAnimation:animation forKey:@"basic"];
}

@end
