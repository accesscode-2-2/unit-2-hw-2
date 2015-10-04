//
//  SearchViewController.m
//  CustomTableViewCells
//
//  Created by Eric Sze on 10/2/15.
//  Copyright © 2015 Mike Kavouras. All rights reserved.
//

#import "SearchViewController.h"
#import "MikesTVC.h"

@interface SearchViewController () <UITextFieldDelegate>

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.searchTextField.delegate = self;

}

#pragma mark - text field delegate

// when user taps "return" key on keyboard
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    // dismiss the keyboard with message:
    [self.view endEditing:YES];

    // make an api request
    
    [self performSegueWithIdentifier:@"newView" sender:self];
    
//    MikesTVC *newView = [self.storyboard instantiateViewControllerWithIdentifier:@"newView"];
//    [self.navigationController pushViewController:newView animated:YES];
    
    return NO;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    MikesTVC *mikesTVC = segue.destinationViewController;
    mikesTVC.searchString = self.searchTextField.text;
}

@end
