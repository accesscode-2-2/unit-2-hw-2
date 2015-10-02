//
//  FifthViewController.m
//  hw-week-2
//
//  Created by Umar on 10/2/15.
//  Copyright © 2015 Michael Kavouras. All rights reserved.
//

#import "FifthViewController.h"

@interface FifthViewController ()

@property (weak, nonatomic) IBOutlet UIView *easeinView;
@property (weak, nonatomic) IBOutlet UIView *realeaseinView;

@end

@implementation FifthViewController
- (IBAction)tapToAnimate:(id)sender {
    
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"position.y";
    animation.fromValue = @30;
    animation.toValue = @550;
    animation.duration = 1;
    
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    [self.easeinView.layer addAnimation:animation forKey:@"basic"];
    
    CABasicAnimation *animationTwo = [CABasicAnimation animation];
    animationTwo.keyPath = @"position.y";
    animationTwo.fromValue = @30;
    animationTwo.toValue = @550;
    animationTwo.duration = 1;
    
    animationTwo.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    
    [self.realeaseinView.layer addAnimation:animationTwo forKey:@"basic"];
    }


@end
