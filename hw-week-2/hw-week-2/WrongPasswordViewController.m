//
//  WrongPasswordViewController.m
//  hw-week-2
//
//  Created by Mesfin Bekele Mekonnen on 10/2/15.
//  Copyright © 2015 Michael Kavouras. All rights reserved.
//

#import "WrongPasswordViewController.h"
#import <pop/POP.h>

@interface WrongPasswordViewController ()
@property (weak, nonatomic) IBOutlet UITextField *wrongPassTextField;

@end

@implementation WrongPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)loginButtonTapped:(UIButton *)sender {
    if(self.wrongPassTextField.text.length > 5){
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        POPSpringAnimation *shake = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionX];
        shake.springBounciness = 20;
        shake.velocity = @(3500);
        
        [self.wrongPassTextField pop_addAnimation:shake forKey:@"shakePassword"];
    }
    
}



@end
