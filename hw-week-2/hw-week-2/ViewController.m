//
//  ViewController.m
//  hw-week-2
//
//  Created by Michael Kavouras on 9/28/15.
//  Copyright © 2015 Michael Kavouras. All rights reserved.
//

#import "ViewController.h"
#import "IoGMarquee.h"

@interface ViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet IoGMarquee *marquee;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
- (IBAction)buttonTapped:(id)sender {
    
    NSString* message = @"Attention all planets of the Solar Federation: we have assumed control";
    [self.marquee setupForMessage:message withBackgroundColor:[UIColor blackColor] andForegroundColor:[UIColor redColor]];
}



@end
