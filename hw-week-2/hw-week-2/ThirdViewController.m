//
//  ThirdViewController.m
//  hw-week-2
//
//  Created by Umar on 10/1/15.
//  Copyright © 2015 Michael Kavouras. All rights reserved.
//

#import "ThirdViewController.h"

@interface ThirdViewController ()

@property (weak, nonatomic) IBOutlet UIView *rotatingView;
@end

@implementation ThirdViewController

- (IBAction)rotationAnimation:(id)sender {
    
    
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"transform.rotation.y";
    animation.fromValue = @10;
    animation.toValue = @20;
    animation.duration = 1;
    animation.repeatCount = 20;
    
    [self.rotatingView.layer addAnimation:animation forKey:@"basic"];
}



@end
