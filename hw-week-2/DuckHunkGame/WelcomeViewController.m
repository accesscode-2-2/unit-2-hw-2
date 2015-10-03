//
//  WelcomeViewController.m
//  DuckHunkGame
//
//  Created by Diana Elezaj on 8/16/15.
//  Copyright (c) 2015 Diana Elezaj. All rights reserved.
//

#import "WelcomeViewController.h"
#import "GameViewController.h"
#import <AVFoundation/AVFoundation.h> // this allows us to include sounds!
#import <objc/runtime.h>
#import "LNBRippleEffect.h"
#import "RBBAnimation.h"
#import "RBBCustomAnimation.h"



@interface WelcomeViewController ()
{
    AVAudioPlayer *_audioPlayerStartGame;
}
@property (strong, nonatomic) IBOutlet UIButton *PlayButton;

@property (weak, nonatomic) IBOutlet UIView *satelliteDuckView;
@property (weak, nonatomic) IBOutlet UIImageView *satelliteDuckImageView;



@end

@implementation WelcomeViewController


- (void)viewDidLoad {
    [super viewDidLoad];
   
    //adding Start button effect
    [self ButtonEffect];
    
    //adding satellite duck
    [self satelliteDuck];
    
    // adding animated header:
    [self headerAnimation];
    
    
    
    //load sound tracks
    NSString *path = [NSString stringWithFormat:@"%@/startGame.mp3", [[NSBundle mainBundle] resourcePath]];
    NSURL *soundUrl = [NSURL fileURLWithPath:path];
    // Create audio player object and initialize with URL to sound
    _audioPlayerStartGame = [[AVAudioPlayer alloc] initWithContentsOfURL:soundUrl error:nil];
    [_audioPlayerStartGame play];
 
    
    
    //view
    RBBCustomAnimation *rainbow = [RBBCustomAnimation animationWithKeyPath:@"backgroundColor"];
    
    rainbow.animationBlock = ^(CGFloat elapsed, CGFloat duration) {
        UIColor *color = [UIColor colorWithHue:elapsed / duration
                                    saturation:1
                                    brightness:1
                                         alpha:1];
        
        return (id)color.CGColor;
    };
    
    
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    [self ButtonEffect];
    [self satelliteDuck];
    [self headerAnimation];
    [_audioPlayerStartGame stop];
    [_audioPlayerStartGame play];
 
}
-(void) headerAnimation {
    self.duckHuntAnimatedHeader.animationImages = [NSArray arrayWithObjects:
                                                   [UIImage imageNamed:@"header01.png"],
                                                   [UIImage imageNamed:@"header02.png"],
                                                   [UIImage imageNamed:@"header03.png"],
                                                   [UIImage imageNamed:@"header04.png"],
                                                   [UIImage imageNamed:@"header05.png"],nil];
    
    [self.duckHuntAnimatedHeader setAnimationRepeatCount:0]; // 0 = it will run forever!!
    self.duckHuntAnimatedHeader.animationDuration = 1.0; // will switch images every 1 second
    [self.duckHuntAnimatedHeader startAnimating]; // start animation!
    

}

-(void) satelliteDuck{
    self.satelliteDuckImageView.image = [UIImage imageNamed:@"satelliteDuck"];
    
    CGRect boundingRect = CGRectMake(-100, -130, 200, 320);
    
    CAKeyframeAnimation *orbit = [CAKeyframeAnimation animation];
    orbit.keyPath = @"position";
    orbit.path = CFAutorelease(CGPathCreateWithEllipseInRect(boundingRect, NULL));
    orbit.duration = 4;
    orbit.additive = YES;
    orbit.repeatCount = HUGE_VALF;
    orbit.calculationMode = kCAAnimationPaced;
    orbit.rotationMode = kCAAnimationLinear ;
    [self.satelliteDuckView.layer addAnimation:orbit forKey:@"orbit"];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)playButtonTapped:(UIButton *)sender {
     
     [_audioPlayerStartGame stop];
    
 }
- (IBAction)duckSatelliteButton:(id)sender {
}

-(void) ButtonEffect {
    
    //pod
    LNBRippleEffect *rippleEffect = [[LNBRippleEffect alloc]initWithImage:[UIImage imageNamed:@""] Frame:CGRectMake(123, 470, 130, 130) Color:[UIColor colorWithRed:(28.0/255.0) green:(212.0/255.0) blue:(255.0/255.0) alpha:1] Target:@selector(duckSatelliteButton:) ID:self];
    [rippleEffect setRippleColor:[UIColor colorWithRed:(28.0/255.0) green:(212.0/255.0) blue:(255.0/255.0) alpha:1]];
    [rippleEffect setRippleTrailColor:[UIColor colorWithRed:(28.0/255.0) green:(212.0/255.0) blue:(255.0/255.0) alpha:0.5]];
    [self.view addSubview:rippleEffect];
    [self.view addSubview:self.PlayButton];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
