//
//  CustomModalViewController.m
//  hw-week-2
//
//  Created by Mesfin Bekele Mekonnen on 10/2/15.
//  Copyright © 2015 Michael Kavouras. All rights reserved.
//

#import "CustomModalViewController.h"

@interface CustomModalViewController ()

@end

@implementation CustomModalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.layer.cornerRadius = 9.f;
}

- (IBAction)closeButtonTapped:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
