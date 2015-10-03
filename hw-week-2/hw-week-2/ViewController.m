//
//  ViewController.m
//  hw-week-2
//
//  Created by Michael Kavouras on 9/28/15.
//  Copyright © 2015 Michael Kavouras. All rights reserved.
//

#import "ViewController.h"
#import "BLLoader.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet BLLoader *loader;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.loader.lineWidth = 12.0;
    self.loader.color = [UIColor darkGrayColor];
    [self.loader startAnimation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
