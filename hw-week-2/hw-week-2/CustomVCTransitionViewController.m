//
//  CustomVCTransitionViewController.m
//  hw-week-2
//
//  Created by Mesfin Bekele Mekonnen on 10/2/15.
//  Copyright © 2015 Michael Kavouras. All rights reserved.
//

#import "CustomVCTransitionViewController.h"
#import "CustomModalViewController.h"
#import "PresentingAnimationController.h"
#import "DismissingAnimationController.h"
#import <pop/POP.h>

@interface CustomVCTransitionViewController ()<UIViewControllerTransitioningDelegate>

@end

@implementation CustomVCTransitionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)presentButtonTapped:(UIButton *)sender {
    CustomModalViewController *modalVC = [self.storyboard instantiateViewControllerWithIdentifier:@"customModal"];
    modalVC.transitioningDelegate = self;
    modalVC.modalPresentationStyle = UIModalPresentationCustom;
    
    [self.navigationController presentViewController:modalVC animated:YES completion:nil];
}
#pragma mark - UIViewControllerTransitionDelegate

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    return [[PresentingAnimationController alloc] init];
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return [[DismissingAnimationController alloc] init];
}


@end
