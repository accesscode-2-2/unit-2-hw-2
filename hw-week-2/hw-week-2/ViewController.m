//
//  ViewController.m
//  hw-week-2
//
//  Created by Michael Kavouras on 9/28/15.
//  Copyright © 2015 Michael Kavouras. All rights reserved.
//

#import "ViewController.h"
#import <pop/POP.h>

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIView *boxToAnimate;
@property (weak, nonatomic) IBOutlet UILabel *popLabel;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void) popBasicAnimation{
    
    POPSpringAnimation *springAnimation = [POPSpringAnimation animation];
    
    springAnimation.property = [POPAnimatableProperty propertyWithName: kPOPLayerPositionX];
    springAnimation.velocity = @(700);
    springAnimation.springBounciness = 22.0f;
    springAnimation.springSpeed = 16.0f;
    
    springAnimation.name = @"RotationAnimation";
    springAnimation.delegate = self;
    
    [self.boxToAnimate.layer pop_addAnimation:springAnimation forKey:@"RotationAnimation"];
}

-(void)fadeAnimation{
    
    POPBasicAnimation *anim = [POPBasicAnimation animationWithPropertyNamed:kPOPViewAlpha];
    anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
    anim.fromValue = @(0.0);
    anim.toValue = @(1.0);
    [self.boxToAnimate pop_addAnimation:anim forKey:@"fade"];
    
}

-(void)removePopLabelAnimation{

    [self.popLabel pop_removeAllAnimations];
}

-(void)springAnimationPopOut{
    POPSpringAnimation *sprintAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewScaleXY];
    sprintAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(1.9, 1.9)];
    sprintAnimation.velocity = [NSValue valueWithCGPoint:CGPointMake(10, 10)];
    sprintAnimation.springBounciness = 20.f;
    [self.popLabel pop_addAnimation:sprintAnimation forKey:@"springAnimation2"];
}

- (IBAction)animateButtonTapped:(UIButton *)sender {
    [self popBasicAnimation];
}
- (IBAction)switchMoved:(UISwitch *)sender {
    if(sender.on){
        [self springAnimationPopOut];
    }else{
        [self removePopLabelAnimation];
    }
}
- (IBAction)fadeButtonTapped:(UIButton *)sender {
    [self fadeAnimation];
}

@end
