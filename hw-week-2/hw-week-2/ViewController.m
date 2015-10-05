//
//  ViewController.m
//  hw-week-2
//
//  Created by Michael Kavouras on 9/28/15.
//  Copyright © 2015 Michael Kavouras. All rights reserved.
//

#import "ViewController.h"
#import <AudioToolbox/AudioToolbox.h>
#import <QuartzCore/QuartzCore.h>

@interface ViewController (){

BOOL bugDead;
    
}

@property (weak, nonatomic) IBOutlet UIImageView *topImage;
@property (weak, nonatomic) IBOutlet UIImageView *bottomImage;
@property (weak, nonatomic) IBOutlet UIImageView *fabricTop;
@property (weak, nonatomic) IBOutlet UIImageView *fabricBottom;
@property (weak, nonatomic) IBOutlet UIImageView *bug;

@end

@implementation ViewController



- (void)moveToLeft:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context {
    if (bugDead) {
        return;
    }
    [UIView animateWithDuration:1.0
                          delay:2.0
                        options:(UIViewAnimationCurveEaseInOut|UIViewAnimationOptionAllowUserInteraction)
                     animations:^{
                         [UIView setAnimationDelegate:self];
                         [UIView setAnimationDidStopSelector:@selector(faceRight:finished:context:)];
                         self.bug.center = CGPointMake(75, 200);
                     }
                     completion:^(BOOL finished){
                         NSLog(@"Move to left done");
                     }];
    
}

- (void)faceRight:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context {
    
    if (bugDead) {
        return;
    }
    [UIView animateWithDuration:1.0
                          delay:0.0
                        options:(UIViewAnimationCurveEaseInOut|UIViewAnimationOptionAllowUserInteraction)
                     animations:^{
                         [UIView setAnimationDelegate:self];
                         [UIView setAnimationDidStopSelector:@selector(moveToRight:finished:context:)];
                         
                         self.bug.transform = CGAffineTransformMakeRotation(M_PI);
                         
                     }
                     completion:^(BOOL finished){
                         NSLog(@"Face right done");
                     }];
    
}

- (void)moveToRight:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context {
    
    if (bugDead) {
        return;
    }
    [UIView animateWithDuration:1.0
                          delay:2.0
                        options:(UIViewAnimationCurveEaseInOut|UIViewAnimationOptionAllowUserInteraction)
                     animations:^{
                         [UIView setAnimationDelegate:self];
                         [UIView setAnimationDidStopSelector:@selector(faceLeft:finished:context:)];
                         self.bug.center = CGPointMake(230, 250);
                         
                     }
                     completion:^(BOOL finished){
                         
                         NSLog(@"Move to right done");
                     }];
    
}

- (void)faceLeft:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context {
    
    if (bugDead) {
        return;
    }
    [UIView animateWithDuration:1.0
                          delay:0.0
                        options:(UIViewAnimationCurveEaseInOut|UIViewAnimationOptionAllowUserInteraction)
                     animations:^{
                         [UIView setAnimationDelegate:self];
                         
                         [UIView setAnimationDidStopSelector:@selector(moveToLeft:finished:context:)];
                         self.bug.transform = CGAffineTransformMakeRotation(0);
                         
                         
                     }completion:^(BOOL finished){
                         NSLog(@"Face left done");
                         
                     }];
    
}


- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint touchLocation = [touch locationInView:self.view];
    
    CGRect bugRect = [[[self.bug layer] presentationLayer] frame];
    if (CGRectContainsPoint(bugRect, touchLocation)) {
        NSLog(@"Bug Tapped!");
    } else {
        NSLog(@"Bug not tapped.");
        return;
    }
    
    NSString *squishPath = [[NSBundle mainBundle]
                            pathForResource:@"squish" ofType:@"caf"];
    NSURL *squishURL = [NSURL fileURLWithPath:squishPath];
    SystemSoundID squishSoundID;
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)squishURL, &squishSoundID);
    AudioServicesPlaySystemSound(squishSoundID);
    
    
    
    bugDead = true;
    [UIView animateWithDuration:0.7
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         self.bug.transform = CGAffineTransformMakeScale(1.25, 0.75);
                     }
                     completion:^(BOOL finished) {
                         [UIView animateWithDuration:2.0
                                               delay:2.0
                                             options:0
                                          animations:^{
                                              self.bug.alpha = 0.0;
                                          } completion:^(BOOL finished) {
                                              [self.bug removeFromSuperview];
                                          }];
                     }];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)viewDidAppear:(BOOL)animated {
    CGRect basketTopFrame = self.topImage.frame;
    basketTopFrame.origin.y = -basketTopFrame.size.height;
    
    CGRect basketBottomFrame = self.bottomImage.frame;
    basketBottomFrame.origin.y = self.view.bounds.size.height;
    
    [UIView animateWithDuration:0.5
                          delay:1.0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         self.topImage.frame = basketTopFrame;
                         self.bottomImage.frame = basketBottomFrame;
                     } completion:^(BOOL finished) {
                         NSLog(@"basket Done!");
                     }];
    
    CGRect napkinTopFrame = self.fabricTop.frame;
    napkinTopFrame.origin.y = -napkinTopFrame.size.height;
    CGRect napkinBottomFrame = self.fabricBottom.frame;
    napkinBottomFrame.origin.y = self.view.bounds.size.height;
    
    [UIView animateWithDuration:1
                          delay:1.5
                        options: UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         self.fabricTop.frame = napkinTopFrame;
                         self.fabricBottom.frame = napkinBottomFrame;
                     }
                     completion:^(BOOL finished){
                         NSLog(@"napkin Done!");
                     }];
    
    [self moveToLeft:nil finished:nil context:nil];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
    
    
    
    
    
    
    
    
    
    
    
    
    
    
  