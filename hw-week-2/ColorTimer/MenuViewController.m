//
//  MenuViewController.m
//  ColorTimer
//
//  Created by Varindra Hart on 9/28/15.
//  Copyright © 2015 Varindra Hart. All rights reserved.
//

#import "MenuViewController.h"
#import <UIColor+uiGradients/UIColor+uiGradients.h>

float const orbitRadius = 40.0;

@interface MenuViewController ()

@property (nonatomic) IBOutlet UIView *gradientView;
@property (weak, nonatomic) IBOutlet UIView *orbitView;

@property (nonatomic) CALayer *orbit1;

@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //[self setGradient];
    [self addCircularAnimation];
    
    // Do any additional setup after loading the view.
}

- (void)setGradient{
    
    UIColor *startColor = [UIColor uig_horizonEndColor];
    UIColor *endColor = [UIColor uig_horizonStartColor];
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = self.gradientView.bounds;
    gradient.position = self.gradientView.center;
    gradient.startPoint = CGPointMake(0, 0);
    gradient.endPoint = CGPointMake(1,1);
    gradient.colors = @[(id)[startColor CGColor], (id)[endColor CGColor]];
    
    [self.gradientView.layer insertSublayer:gradient atIndex:0];
    
}

- (void)addCircularAnimation{
    
    CALayer *orbit1 = [CALayer layer];
    orbit1.frame = self.orbitView.layer.bounds;
    //orbit1.position = CGPointMake(self.viewOrbit.center.x, self.viewOrbit.center.y);
    orbit1.cornerRadius = orbitRadius;
    orbit1.borderColor = [UIColor clearColor].CGColor;
    orbit1.borderWidth = 1.5;
    [self.orbitView.layer addSublayer:orbit1];
    
    
    CALayer *planet1 = [CALayer layer];
    planet1.bounds = CGRectMake(0,0,30, 30);
    planet1.position = [self coordinateForTheta:90 radius:orbitRadius];
    planet1.cornerRadius = 15;
    planet1.backgroundColor = [UIColor redColor].CGColor;
    
    [orbit1 addSublayer:planet1];
    
//    UIButton *button = [UIButton new];
//    [button setTitle:@"2" forState:UIControlStateNormal];
//    [button addTarget:self action:@selector(tapped:) forControlEvents:UIControlEventTouchUpInside];
    
    CALayer *planet2 = [CALayer layer];
    planet2.bounds = CGRectMake(0,0,30, 30);
//    button.frame = planet2.bounds;
    planet2.position = [self coordinateForTheta:(210)radius:(orbitRadius)];
    planet2.cornerRadius = 15;
    planet2.backgroundColor = [UIColor blueColor].CGColor;
    
//    [self.view addSubview:button];
    
    [orbit1 addSublayer:planet2];
    
    CALayer *planet3 = [CALayer layer];
    planet3.bounds = CGRectMake(0,0,30, 30);
    planet3.position = [self coordinateForTheta:(330)radius:(orbitRadius)];
    planet3.cornerRadius = 15;
    planet3.backgroundColor = [UIColor greenColor].CGColor;
    
    [orbit1 addSublayer:planet3];
    
    CABasicAnimation *anim1 = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    anim1.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    anim1.fromValue = @0;
    anim1.toValue = @(360*M_PI/180);
    anim1.repeatCount = HUGE_VAL;
    anim1.duration = 4.0;
    
    [orbit1 addAnimation:anim1 forKey:@"transform"];
}

- (CGPoint)coordinateForTheta:(float)theta radius:(float)radius{
    
    theta = theta*M_PI / 180;
    float x = radius *cos(theta) + radius;
    x = x>=0 ? x : -x;
    
    float y = radius *sin(theta) - radius;
    y = y>=0 ? y : -y;
    
    CGPoint coordinate = CGPointMake(x, y);
    return coordinate;
}
    


#pragma mark - Navigation


- (void)viewDidDisappear:(BOOL)animated{
    
}

@end
