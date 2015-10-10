//
//  GameViewController.m
//  DuckHunkGame
//
//  Created by Diana Elezaj on 8/16/15.
//  Copyright (c) 2015 Diana Elezaj. All rights reserved.
//


#import <QuartzCore/QuartzCore.h>
#import "GameViewController.h"
#import "RBBCustomAnimation.h"
#import "RBBAnimation.h"
#import "RBBSpringAnimation.h"

#import "RBBEasingFunction.h"
#import "RBBTweenAnimation.h"


@interface GameViewController ()

// music stuff



@property (strong, nonatomic) IBOutlet UIButton *duck1;
@property (weak, nonatomic) IBOutlet UIView *duck1View;
@property (strong, nonatomic) IBOutlet UIButton *duck2;
@property (strong, nonatomic) IBOutlet UIButton *duck3;
@property (strong, nonatomic) IBOutlet UIButton *duck4;
@property (strong, nonatomic) IBOutlet UIButton *duck5;
@property (strong, nonatomic) IBOutlet UIButton *duck6;
@property (strong, nonatomic) IBOutlet UIButton *duck7;
@property (strong, nonatomic) IBOutlet UIButton *duck8;
@property (strong, nonatomic) IBOutlet UIButton *duck9;
@property (strong, nonatomic) IBOutlet UIButton *duck10;
@property (nonatomic) NSInteger points;
@property (strong, nonatomic) IBOutlet UILabel *scoresLabel;
@property (nonatomic) NSInteger ducksAlive;
@property (strong, nonatomic) IBOutlet UILabel *ducksAliveLabel;
@property (nonatomic) NSTimer *startTimer;
@property (nonatomic) NSTimer *runningTimer;

@property (nonatomic) BOOL timeIsOver;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;






@end

@implementation GameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.ducksAliveLabel.text = @("0");
    self.scoresLabel.text = @("0");
    
    self.ducksAliveLabel.hidden = NO;
    self.scoresLabel.hidden=NO;
    
    //hide all ducks
    self.duck1.hidden = YES;
    self.duck2.hidden = YES;
    self.duck3.hidden = YES;
    self.duck4.hidden = YES;
    self.duck5.hidden = YES;
    self.duck6.hidden = YES;
    self.duck7.hidden = YES;
    self.duck8.hidden = YES;
    self.duck9.hidden = YES;
    self.duck10.hidden = YES;
    
    
    
    //load sound tracks
    NSString *path = [NSString stringWithFormat:@"%@/startRound.mp3", [[NSBundle mainBundle] resourcePath]];
    NSURL *soundUrl = [NSURL fileURLWithPath:path];
    // Create audio player object and initialize with URL to sound
    _audioPlayerStartRound = [[AVAudioPlayer alloc] initWithContentsOfURL:soundUrl error:nil];
    
    
    NSString *path2 = [NSString stringWithFormat:@"%@/hit.mp3", [[NSBundle mainBundle] resourcePath]];
    NSURL *soundUrl2 = [NSURL fileURLWithPath:path2];
    _audioPlayerHit = [[AVAudioPlayer alloc] initWithContentsOfURL:soundUrl2 error:nil];
    
    [_audioPlayerStartRound play];
    
    
    
    
    //duck moving
//    RBBSpringAnimation *spring = [RBBSpringAnimation animationWithKeyPath:@"position.y"];
//    
//    spring.fromValue = @(-100.0f);
//    spring.toValue = @(100.0f);
//    spring.velocity = 0;
//    spring.mass = 1;
//    spring.damping = 10;
//    spring.stiffness = 100;
//    
//    spring.additive = YES;
//    spring.duration = [spring durationForEpsilon:0.01];
//    [self.duck1.layer addAnimation:spring forKey:@"basic"];
//    

    
    
    

    self.startTimer = [NSTimer timerWithTimeInterval:6 target:self selector:@selector(duck1timerFired:) userInfo:nil repeats:NO];
    [[NSRunLoop currentRunLoop] addTimer:self.startTimer forMode:NSRunLoopCommonModes];
    
    
    
    
 }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
 }



- (void)duck1timerFired: (NSTimer *)timer{
 
    
    self.duck1.hidden = NO;
    //duck 1 moving
//    CABasicAnimation *animation = [CABasicAnimation animation];
//    animation.keyPath = @"position.x";
//    animation.fromValue = @60;
//    animation.toValue = @190;
//    animation.duration = 3;
//    animation.fillMode = kCAFillModeForwards;
//    animation.removedOnCompletion = NO;
//    animation.beginTime = CACurrentMediaTime();
//    NSLog(@"duck 1 moving");
//    
//    [self.duck1.layer addAnimation:animation forKey:@"basic"];
    
    
    
    
    
    
    
    
    RBBTweenAnimation *sinus = [RBBTweenAnimation animationWithKeyPath:@"position.y"];
    sinus.fromValue = @(100);
    sinus.toValue = @(220);
    sinus.removedOnCompletion = YES;
    
    sinus.easing = ^CGFloat (CGFloat fraction) {
        return sin((fraction) * 2 * M_PI);
    };
    
    sinus.additive = YES;
    sinus.duration = 5;
     NSLog(@"duck 1 moving");
    
    [self.duck1.layer addAnimation:sinus forKey:@"basic"];
 
    
    
    
    
    
    
    //call the timer
    self.runningTimer = [NSTimer timerWithTimeInterval:0.0001 target:self selector:@selector(duckTimer:) userInfo:nil repeats:YES];
    
    
    if (self.timeIsOver == YES) {
    self.duck1.hidden = YES;
        
    self.ducksAlive = [self.ducksAliveLabel.text integerValue] + 1;
    self.ducksAliveLabel.text = [NSString stringWithFormat: @"%li",(long)self.ducksAlive];
    }
    [[NSRunLoop currentRunLoop] addTimer:self.runningTimer forMode:NSRunLoopCommonModes];
    
    
    
    

}

- (void)viewWillAppear:(BOOL)animated {
    [UIView animateWithDuration:1.0
                          delay:2.0
                        options:UIViewAnimationOptionTransitionCrossDissolve
                     animations:^{
                         //yourAnimation
                     } completion:^(BOOL finished){
                         NSLog(@"Animation is finished");
                         self.timeLabel.text = @"0:00";
                     }];
}



- (void)duckTimer: (NSTimer *)timer{
    
    CGFloat currentNumber = [self.timeLabel.text floatValue];
    CGFloat nextNumber = currentNumber + 0.001;
    
    if (nextNumber == 0.5) {
        [timer invalidate];
        NSLog(@"stoppppppppppp");
        self.timeIsOver = YES;
    }
    
    self.timeLabel.text = [NSString stringWithFormat:@"%f", nextNumber];

         // should fix this one
//    while (nextNumber < 1) {
//         currentNumber = [self.timeLabel.text floatValue];
//         nextNumber = currentNumber + 0.001;
//
//        self.timeLabel.text = [NSString stringWithFormat:@"%f", nextNumber];
//
//           }
//    
//    
//    [timer invalidate];
//    self.timeIsOver = YES;
    //self.timeLabel.text = @"aaa";
    
    
}





- (IBAction)duck1:(UIButton *)sender {
    NSLog(@"Hit duck 1");
   // self.points = self.points + 1;
    [_audioPlayerHit stop];

    [_audioPlayerHit play];
    self.points = [self.scoresLabel.text integerValue] + 1;
    self.scoresLabel.text = [NSString stringWithFormat: @"%li",(long)self.points];
    self.duck1.hidden = YES;
    self.duck2.hidden = NO;
    
    
    
    self.startTimer = [NSTimer timerWithTimeInterval:6 target:self selector:@selector(duck2timerFired:) userInfo:nil repeats:NO];
    
    [[NSRunLoop currentRunLoop] addTimer:self.startTimer forMode:NSRunLoopCommonModes];
}





     
     
- (void)duck2timerFired: (NSTimer *)timer{
    
    //duck 2 moving
    CABasicAnimation *animation2 = [CABasicAnimation animation];
    animation2.keyPath = @"position.x";
    animation2.fromValue = @200;
    animation2.toValue = @88;
    animation2.duration = 3;
    
    animation2.fillMode = kCAFillModeForwards;
    animation2.removedOnCompletion = NO;
    animation2.beginTime = CACurrentMediaTime();
    NSLog(@"duck 2 moving");
    
    [self.duck2.layer addAnimation:animation2 forKey:@"basic"];
 
    
    
    
    
    
    
    //call the timer
    self.startTimer = [NSTimer timerWithTimeInterval:0.0001 target:self selector:@selector(duckTimer:) userInfo:nil repeats:NO];
    
    [[NSRunLoop currentRunLoop] addTimer:self.startTimer forMode:NSRunLoopCommonModes];
    
    if (self.timeIsOver == YES) {
        self.duck2.hidden = YES;
        
        self.ducksAlive = [self.ducksAliveLabel.text integerValue] + 1;
        self.ducksAliveLabel.text = [NSString stringWithFormat: @"%li",(long)self.ducksAlive];
    }
}

- (IBAction)duck2:(UIButton *)sender {
    [_audioPlayerHit stop];

    [_audioPlayerHit play];
    self.points = [self.scoresLabel.text integerValue] + 1;
    self.scoresLabel.text = [NSString stringWithFormat: @"%li",(long)self.points];
    self.duck2.hidden = YES;
    self.duck3.hidden = NO;
    
    
    
    self.startTimer = [NSTimer timerWithTimeInterval:0.0001 target:self selector:@selector(duck3timerFired:) userInfo:nil repeats:NO];
    
    [[NSRunLoop currentRunLoop] addTimer:self.startTimer forMode:NSRunLoopCommonModes];
    
}



- (void)duck3timerFired: (NSTimer *)timer{
    
    //call the timer
    self.startTimer = [NSTimer timerWithTimeInterval:0.0001 target:self selector:@selector(duckTimer:) userInfo:nil repeats:NO];
    
    [[NSRunLoop currentRunLoop] addTimer:self.startTimer forMode:NSRunLoopCommonModes];
    
    if (self.timeIsOver == YES) {
        self.duck3.hidden = YES;
        
        self.ducksAlive = [self.ducksAliveLabel.text integerValue] + 1;
        self.ducksAliveLabel.text = [NSString stringWithFormat: @"%li",(long)self.ducksAlive];
    }
}


- (IBAction)duck3:(UIButton *)sender {
    [_audioPlayerHit stop];

    [_audioPlayerHit play];
    self.points = [self.scoresLabel.text integerValue] + 1;
    self.scoresLabel.text = [NSString stringWithFormat: @"%li",(long)self.points];
    self.duck3.hidden = YES;
    self.duck4.hidden = NO;
    
    
    
    self.startTimer = [NSTimer timerWithTimeInterval:0.0001 target:self selector:@selector(duck4timerFired:) userInfo:nil repeats:NO];
    
    [[NSRunLoop currentRunLoop] addTimer:self.startTimer forMode:NSRunLoopCommonModes];
    
    
}




- (void)duck4timerFired: (NSTimer *)timer{
    
    //call the timer
    self.startTimer = [NSTimer timerWithTimeInterval:0.0001 target:self selector:@selector(duckTimer:) userInfo:nil repeats:NO];
    
    [[NSRunLoop currentRunLoop] addTimer:self.startTimer forMode:NSRunLoopCommonModes];
    
    if (self.timeIsOver == YES) {
        self.duck4.hidden = YES;
        
        self.ducksAlive = [self.ducksAliveLabel.text integerValue] + 1;
        self.ducksAliveLabel.text = [NSString stringWithFormat: @"%li",(long)self.ducksAlive];
    }
}



- (IBAction)duck4:(UIButton *)sender {
    
    [_audioPlayerHit play];
    self.points = [self.scoresLabel.text integerValue] + 1;
    self.scoresLabel.text = [NSString stringWithFormat: @"%li",(long)self.points];
    self.duck4.hidden = YES;
    self.duck5.hidden = NO;
    
    
    
    self.startTimer = [NSTimer timerWithTimeInterval:0.0001 target:self selector:@selector(duck5timerFired:) userInfo:nil repeats:NO];
    
    [[NSRunLoop currentRunLoop] addTimer:self.startTimer forMode:NSRunLoopCommonModes];
    
}


- (void)duck5timerFired: (NSTimer *)timer{
    
    //call the timer
    self.startTimer = [NSTimer timerWithTimeInterval:0.0001 target:self selector:@selector(duckTimer:) userInfo:nil repeats:NO];
    
    [[NSRunLoop currentRunLoop] addTimer:self.startTimer forMode:NSRunLoopCommonModes];
    
    if (self.timeIsOver == YES) {
        self.duck5.hidden = YES;
        
        self.ducksAlive = [self.ducksAliveLabel.text integerValue] + 1;
        self.ducksAliveLabel.text = [NSString stringWithFormat: @"%li",(long)self.ducksAlive];
    }
}

- (IBAction)duck5:(UIButton *)sender {
    
    [_audioPlayerHit play];
    self.points = [self.scoresLabel.text integerValue] + 1;
    self.scoresLabel.text = [NSString stringWithFormat: @"%li",(long)self.points];
    self.duck5.hidden = YES;
    self.duck6.hidden = NO;
    
    
    
    self.startTimer = [NSTimer timerWithTimeInterval:0.0001 target:self selector:@selector(duck6timerFired:) userInfo:nil repeats:NO];
    
    [[NSRunLoop currentRunLoop] addTimer:self.startTimer forMode:NSRunLoopCommonModes];
    
}



- (void)duck6timerFired: (NSTimer *)timer{
    
    //call the timer
    self.startTimer = [NSTimer timerWithTimeInterval:0.0001 target:self selector:@selector(duckTimer:) userInfo:nil repeats:NO];
    
    [[NSRunLoop currentRunLoop] addTimer:self.startTimer forMode:NSRunLoopCommonModes];
    
    if (self.timeIsOver == YES) {
        self.duck6.hidden = YES;
        
        self.ducksAlive = [self.ducksAliveLabel.text integerValue] + 1;
        self.ducksAliveLabel.text = [NSString stringWithFormat: @"%li",(long)self.ducksAlive];
    }
}




- (IBAction)duck6:(UIButton *)sender {
    [_audioPlayerHit play];
    self.points = [self.scoresLabel.text integerValue] + 1;
    self.scoresLabel.text = [NSString stringWithFormat: @"%li",(long)self.points];
    self.duck6.hidden = YES;
    self.duck7.hidden = NO;

    
    self.startTimer = [NSTimer timerWithTimeInterval:0.0001 target:self selector:@selector(duck7timerFired:) userInfo:nil repeats:NO];
    
    [[NSRunLoop currentRunLoop] addTimer:self.startTimer forMode:NSRunLoopCommonModes];
}




- (void)duck7timerFired: (NSTimer *)timer{
    
    //call the timer
    self.startTimer = [NSTimer timerWithTimeInterval:0.0001 target:self selector:@selector(duckTimer:) userInfo:nil repeats:NO];
    
    [[NSRunLoop currentRunLoop] addTimer:self.startTimer forMode:NSRunLoopCommonModes];
    
    if (self.timeIsOver == YES) {
        self.duck7.hidden = YES;
        
        self.ducksAlive = [self.ducksAliveLabel.text integerValue] + 1;
        self.ducksAliveLabel.text = [NSString stringWithFormat: @"%li",(long)self.ducksAlive];
    }
}
- (IBAction)duck7:(UIButton *)sender {
    [_audioPlayerHit play];
    self.points = [self.scoresLabel.text integerValue] + 1;
    self.scoresLabel.text = [NSString stringWithFormat: @"%li",(long)self.points];
    self.duck7.hidden = YES;
    self.duck8.hidden = NO;
    
    self.startTimer = [NSTimer timerWithTimeInterval:0.0001 target:self selector:@selector(duck8timerFired:) userInfo:nil repeats:NO];
    
    [[NSRunLoop currentRunLoop] addTimer:self.startTimer forMode:NSRunLoopCommonModes];
    
    
}


- (void)duck8timerFired: (NSTimer *)timer{
    
    //call the timer
    self.startTimer = [NSTimer timerWithTimeInterval:0.0001 target:self selector:@selector(duckTimer:) userInfo:nil repeats:NO];
    
    [[NSRunLoop currentRunLoop] addTimer:self.startTimer forMode:NSRunLoopCommonModes];
    
    if (self.timeIsOver == YES) {
        self.duck8.hidden = YES;
        
        self.ducksAlive = [self.ducksAliveLabel.text integerValue] + 1;
        self.ducksAliveLabel.text = [NSString stringWithFormat: @"%li",(long)self.ducksAlive];
    }
}

- (IBAction)duck8:(UIButton *)sender {
    [_audioPlayerHit play];
    self.points = [self.scoresLabel.text integerValue] + 1;
    self.scoresLabel.text = [NSString stringWithFormat: @"%li",(long)self.points];
    self.duck8.hidden = YES;
    self.duck9.hidden = NO;
    
    self.startTimer = [NSTimer timerWithTimeInterval:0.0001 target:self selector:@selector(duck9timerFired:) userInfo:nil repeats:NO];
    
    [[NSRunLoop currentRunLoop] addTimer:self.startTimer forMode:NSRunLoopCommonModes];
    
}


- (void)duck9timerFired: (NSTimer *)timer{
    
    //call the timer
    self.startTimer = [NSTimer timerWithTimeInterval:0.0001 target:self selector:@selector(duckTimer:) userInfo:nil repeats:NO];
    
    [[NSRunLoop currentRunLoop] addTimer:self.startTimer forMode:NSRunLoopCommonModes];
    
    if (self.timeIsOver == YES) {
        self.duck9.hidden = YES;
        
        self.ducksAlive = [self.ducksAliveLabel.text integerValue] + 1;
        self.ducksAliveLabel.text = [NSString stringWithFormat: @"%li",(long)self.ducksAlive];
    }
}




- (IBAction)duck9:(UIButton *)sender {

    [_audioPlayerHit play];
    self.points = [self.scoresLabel.text integerValue] + 1;
    self.scoresLabel.text = [NSString stringWithFormat: @"%li",(long)self.points];
    self.duck9.hidden = YES;
    self.duck10.hidden = NO;
    
    self.startTimer = [NSTimer timerWithTimeInterval:0.0001 target:self selector:@selector(duck10timerFired:) userInfo:nil repeats:NO];
    
    [[NSRunLoop currentRunLoop] addTimer:self.startTimer forMode:NSRunLoopCommonModes];
    



}

- (void)duck10timerFired: (NSTimer *)timer{
    
    //call the timer
    self.startTimer = [NSTimer timerWithTimeInterval:0.0001 target:self selector:@selector(duckTimer:) userInfo:nil repeats:NO];
    
    [[NSRunLoop currentRunLoop] addTimer:self.startTimer forMode:NSRunLoopCommonModes];
    
    if (self.timeIsOver == YES) {
        self.duck10.hidden = YES;
        
        self.ducksAlive = [self.ducksAliveLabel.text integerValue] + 1;
        self.ducksAliveLabel.text = [NSString stringWithFormat: @"%li",(long)self.ducksAlive];
    }
}


- (IBAction)duck10:(UIButton *)sender {
    [_audioPlayerHit play];
    self.points = [self.scoresLabel.text integerValue] + 1;
    self.scoresLabel.text = [NSString stringWithFormat: @"%li",(long)self.points];
    self.duck10.hidden = YES;
    self.duck1.hidden = NO;
    
    self.startTimer = [NSTimer timerWithTimeInterval:0.0001 target:self selector:@selector(duck1timerFired:) userInfo:nil repeats:NO];
    
    [[NSRunLoop currentRunLoop] addTimer:self.startTimer forMode:NSRunLoopCommonModes];
    
}




@end
