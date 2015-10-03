//
//  ViewController.m
//  hw-week-2
//
//  Created by Michael Kavouras on 9/28/15.
//  Copyright © 2015 Michael Kavouras. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface ViewController ()

@end

@implementation ViewController



- (void)viewDidLoad {
//adding the image to viewController
    [super viewDidLoad];
    UIImage *ballImage = [UIImage imageNamed:@"ball"];
	UIImageView *ball = [[UIImageView alloc] initWithImage:ballImage];
	[self.view addSubview:ball];
	
}

- (void)addFallAnimationforLayer:(CALayer *)layer{
	//This is the keypath to animate
	NSString *keyPath = @"transform.transition.y";
	//Allocate a CAKeyFrameAnimtion for the specified keypath
	CAKeyframeAnimation *translation = [CAKeyframeAnimation animationWithKeyPath:keyPath];
	//set animation duration and repeat
	translation.duration = 1.5f;
	translation.repeatCount = HUGE_VAL;
	//reverse the animation
	translation.autoreverses = YES;
	
	//Allocate an array to hold the values to interpolate
	NSMutableArray *values = [[NSMutableArray alloc] init];
	
	//Add the start value
	//The Animation starts at a y offset of 0.0
	
	[values addObject:[NSNumber numberWithFloat:0.0f]];
	
	//add the end value
	//the animation finishes when the ball makes contact with the bottom of the screen.
	//This point is calculated by finding the height of the applicationFrame  and subtracting the height of the ball.
	CGFloat height = [[UIScreen mainScreen] bounds].size.height - layer.frame.size.height;
	[values addObject:[NSNumber numberWithFloat:height]];
	
	//set the values that should be interpolated during the animation
	translation.values = values;
	[layer addAnimation:translation forKey:keyPath];
	
	//allocate array to hold timing functions
	NSMutableArray *timingFunctions = [[NSMutableArray alloc] init];
	//add a timing function for the first animation step to ease in the animation. Gravity simulator
	[timingFunctions addObject:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
	
	// Set the timing functions that should be used to calculate interpolation between the first two keyframes
	translation.timingFunctions = timingFunctions;
	}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
