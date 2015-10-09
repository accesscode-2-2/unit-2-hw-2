//
//  ViewController.h
//  Blink
//
//  Created by Jason Wang on 10/9/15.
//  Copyright © 2015 Jason Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *labelResult;

- (IBAction)didTapScan:(id)sender;

@end

