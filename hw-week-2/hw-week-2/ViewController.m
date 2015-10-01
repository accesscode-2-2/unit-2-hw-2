//
//  ViewController.m
//  hw-week-2
//
//  Created by Michael Kavouras on 9/28/15.
//  Copyright © 2015 Michael Kavouras. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIView *animationView;

@end

@implementation ViewController

//- (void)viewDidLoad {
//    [super viewDidLoad];
//    // Do any additional setup after loading the view, typically from a nib.
//}
//
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}


- (IBAction)animationButton:(id)sender {
    
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"position.y";
    animation.fromValue = @16;
    animation.toValue = @550;
    animation.duration = .4;
    animation.repeatCount = 4;
    
    [self.animationView.layer addAnimation:animation forKey:@"basic"];

}



@end
