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


@interface WelcomeViewController ()
{
    AVAudioPlayer *_audioPlayerStartGame;
}
@property (strong, nonatomic) IBOutlet UIButton *PlayButton;

@property (weak, nonatomic) IBOutlet UIView *satelliteDuckView;
@property (weak, nonatomic) IBOutlet UIImageView *satelliteDuckImageView;



@end

@implementation WelcomeViewController
 


//-(void) bubbleButton {
//    self.PlayButton.transform = CGAffineTransformMakeScale(1, 0.8);
// 
//    
//    
//     
//    [UIView animateWithDuration:2.0
//                          delay:0
//         usingSpringWithDamping:0.20
//          initialSpringVelocity:6.00
//                        options:(UIviewAnimationOptions)options
//                     animations:^{
//        self.PlayButton.transform = CGAffineTransformIdentity;
//
//        
//        
//    } completion:^(BOOL finished) {
//        
//        
//    
//        
//
//    }];
//    
//    
//    
//}
//




- (void)viewDidLoad {
    [super viewDidLoad];
   
    
     //pod
    LNBRippleEffect *rippleEffect = [[LNBRippleEffect alloc]initWithImage:[UIImage imageNamed:@""] Frame:CGRectMake(123, 470, 130, 130) Color:[UIColor colorWithRed:(28.0/255.0) green:(212.0/255.0) blue:(255.0/255.0) alpha:1] Target:@selector(playButtonTapped:) ID:self];
    [rippleEffect setRippleColor:[UIColor colorWithRed:(28.0/255.0) green:(212.0/255.0) blue:(255.0/255.0) alpha:1]];
    [rippleEffect setRippleTrailColor:[UIColor colorWithRed:(28.0/255.0) green:(212.0/255.0) blue:(255.0/255.0) alpha:0.5]];
    [self.view addSubview:rippleEffect];
  
    
    
    
    //adding satellite duck

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

    
    
    
    // adding animated header:
    self.duckHuntAnimatedHeader.animationImages = [NSArray arrayWithObjects:
                                      [UIImage imageNamed:@"header01.png"],
                                      [UIImage imageNamed:@"header02.png"],
                                      [UIImage imageNamed:@"header03.png"],
                                      [UIImage imageNamed:@"header04.png"],
                                      [UIImage imageNamed:@"header05.png"],nil];
    
    [self.duckHuntAnimatedHeader setAnimationRepeatCount:0]; // 0 = it will run forever!!
    self.duckHuntAnimatedHeader.animationDuration = 1.0; // will switch images every 1 second
    [self.duckHuntAnimatedHeader startAnimating]; // start animation!
    
    
    //load sound tracks
    NSString *path = [NSString stringWithFormat:@"%@/startGame.mp3", [[NSBundle mainBundle] resourcePath]];
    NSURL *soundUrl = [NSURL fileURLWithPath:path];
    // Create audio player object and initialize with URL to sound
    _audioPlayerStartGame = [[AVAudioPlayer alloc] initWithContentsOfURL:soundUrl error:nil];
    
    [_audioPlayerStartGame play];

    // button animation
//    self.PlayButton.alpha = 0;
//    [UIView animateWithDuration:0.5 delay:0.001 options:UIViewAnimationOptionRepeat | UIViewAnimationOptionAutoreverse animations:^{
//        self.PlayButton.alpha = 1;
//    } completion:nil];
//    
    
    
    
    
//    CGPoint newLeftCenter = CGPointMake( 20.0f + self.PlayButton.frame.size.width / 2.0f, self.PlayButton.center.y);
//    [UIView beginAnimations:nil context:nil];
//    [UIView setAnimationDuration:1.0f];
//    self.PlayButton.center = newLeftCenter;
//    [UIView commitAnimations];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)playButtonTapped:(UIButton *)sender {
    
    [_audioPlayerStartGame stop];

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
