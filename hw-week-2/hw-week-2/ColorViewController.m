//
//  ColorViewController.m
//  hw-week-2
//
//  Created by Artur Lan on 10/2/15.
//  Copyright © 2015 Michael Kavouras. All rights reserved.
//

#import "ColorViewController.h"
#import <LESliderController/UIViewController+LESliderChild.h>


@interface ColorViewController ()

@end

@implementation ColorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)dismiss:(UIButton *)sender {
    [self dismissSliderController:YES];

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
