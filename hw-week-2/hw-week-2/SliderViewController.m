//
//  SliderViewController.m
//  hw-week-2
//
//  Created by Artur Lan on 10/2/15.
//  Copyright © 2015 Michael Kavouras. All rights reserved.
//

#import "SliderViewController.h"

@interface SliderViewController ()
@property (weak, nonatomic) IBOutlet UIButton *leftButton;
@property (weak, nonatomic) IBOutlet UIButton *rightButton;

@end

@implementation SliderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIViewController *rightViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"RightViewController"];
    [self registerTriggerView:self.rightButton toViewController:rightViewController onSide:LESliderSideRight];
    [self addSliderGesture:LESliderSideRight toTriggerView:self.rightButton];
    
    UIViewController *leftViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"LeftViewController"];
    [self registerTriggerView:self.leftButton toViewController:leftViewController onSide:LESliderSideLeft];
    [self addSliderGesture:LESliderSideLeft toTriggerView:self.leftButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)leftButtonDidTouch:(UIButton *)sender {
    [self showRegisteredViewControllerForTriggerView:sender animated:YES completion:nil];

    
}
- (IBAction)rightButtonDidTouch:(UIButton *)sender {
    [self showRegisteredViewControllerForTriggerView:sender animated:YES completion:nil];

    
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
