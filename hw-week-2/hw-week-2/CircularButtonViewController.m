//
//  CircularButtonViewController.m
//  hw-week-2
//
//  Created by Jackie Meggesto on 10/2/15.
//  Copyright © 2015 Michael Kavouras. All rights reserved.
//

#import "CircularButtonViewController.h"
#import "ADCircularMenu.h"

@interface CircularButtonViewController ()<ADCircularMenuDelegate>
@property ADCircularMenu* circularMenuVC;

@end

@implementation CircularButtonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)btnMenuClicked:(id)sender {
    self.circularMenuVC = nil;
    
    //use 3 or 7 or 12 for symmetric look (current implementation supports max 12 buttons)
    NSArray *arrImageName = [[NSArray alloc] initWithObjects:
                             @"btnMenu",
                             @"btnMenu",
                             @"btnMenu",
                             @"btnMenu",
                             @"btnMenu",
                             @"btnMenu",
                             @"btnMenu",
                             nil];
    
    self.circularMenuVC = [[ADCircularMenu alloc] initWithMenuButtonImageNameArray:arrImageName
                                                      andCornerButtonImageName:@"btnMenuCorner"];
    self.circularMenuVC.delegateCircularMenu = self;
    [self.circularMenuVC show];
}
- (void)circularMenuClickedButtonAtIndex:(int) buttonIndex
{
    NSLog(@"Circular Mneu : Clicked button at index : %d",buttonIndex);
}

@end
