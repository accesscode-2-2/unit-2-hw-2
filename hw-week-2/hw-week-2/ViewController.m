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

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)buttonTapped1:(UIButton *)sender {
//    POPAnimation *firstAnimation = [POPDecayAnimation animationWithPropertyNamed:kPOPLayerPositionX];
//    [sender.layer pop_addAnimation:firstAnimation forKey:@"slide"];
    
    POPAnimation *firstAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPViewAlpha];
    [sender.layer pop_addAnimation:firstAnimation forKey:@"slide"];
}

@end
