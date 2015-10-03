//
//  MainViewController.m
//  ColorTimer
//
//  Created by Varindra Hart on 8/16/15.
//  Copyright © 2015 Varindra Hart. All rights reserved.
//

#import "MainViewController.h"
#import "GamePlayViewController.h"
#import "SettingsViewController.h"
#import "HighScoreTableViewController.h"

@interface MainViewController ()

@property (nonatomic) HighScoreTableViewController *highScoreTVC;
@property (nonatomic) GamePlayViewController *gameViewController;
@property (nonatomic,weak) IBOutlet UIView *leftView;
@property (nonatomic, weak) IBOutlet UIView *rightView;
@property (nonatomic) BOOL isLeft;
@property (nonatomic) BOOL isRight;

@property (nonatomic) BOOL gameVCStartButtonStatus;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[self.navigationController navigationBar] setHidden:YES];
    
    [self embedTableViewControllers];
    
    [self embedGameViewController];
   
    self.gameVCStartButtonStatus = YES;
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(prepareToDismiss) name:@"DismissMainViewControllerNotification" object:nil];

    
}

//**********************************
//DELEGATE METHODS

- (void) viewController:(GamePlayViewController *)sender startButtonEnabled:(BOOL)enabled{
    
    self.gameVCStartButtonStatus = enabled;
}

- (void) viewController:(GamePlayViewController *)sender swipeGesture:(UISwipeGestureRecognizer *)swipe{
    
    [self swipeRecognized:swipe];
}

- (void) viewController:(GamePlayViewController *)sender newScoreAdded:(BOOL)added{
    
    [self.highScoreTVC.tableView reloadData];
}
//************************************

//DELEGATE CALLED METHOD
- (void)swipeRecognized:(UISwipeGestureRecognizer *)swipe{
    if (self.gameVCStartButtonStatus && swipe.direction==UISwipeGestureRecognizerDirectionLeft && !self.isLeft) {
        
        CGPoint newAnchor = [self findNewAnchor:self.gameViewController.view.center swipeDirection:swipe.direction];
        
        CGRect newFrame = CGRectMake(newAnchor.x, newAnchor.y, self.gameViewController.view.bounds.size.width, self.gameViewController.view.bounds.size.height);
        
        [UIView animateWithDuration:.27453 animations:^{
            self.gameViewController.view.frame = newFrame;
        } completion:^(BOOL finished) {
            if (self.isRight) {
                self.isRight = NO;
            }
            else{
                self.isLeft = YES;
                }
        }];
        
    }
    
    else if (self.gameVCStartButtonStatus && swipe.direction==UISwipeGestureRecognizerDirectionRight && !self.isRight){

        CGPoint newAnchor = [self findNewAnchor:self.gameViewController.view.center swipeDirection:swipe.direction];
        
        CGRect newFrame = CGRectMake(newAnchor.x, newAnchor.y, self.gameViewController.view.bounds.size.width, self.gameViewController.view.bounds.size.height);
        
        [UIView animateWithDuration:.27453 animations:^{
            self.gameViewController.view.frame = newFrame;
        } completion:^(BOOL finished) {
            if (self.isLeft) {
                self.isLeft = NO;
            }
            else{
                self.isRight = YES;
            }
        }];
    }
}

- (CGPoint) findNewAnchor:(CGPoint)center swipeDirection:(UISwipeGestureRecognizerDirection)direction{
    
    CGPoint oldAnchor = CGPointMake(center.x- (self.gameViewController.view.bounds.size.width/2), .5);
    float shift = direction==UISwipeGestureRecognizerDirectionLeft? -1: 1;
    CGPoint newAnchor = CGPointMake(oldAnchor.x + (shift*self.gameViewController.view.bounds.size.width/2), .5);
    
    return newAnchor;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//****************************************************
//EMBEDDING METHODS

- (void)embedGameViewController {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    GamePlayViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"gameViewController"];
    
    [self addChildViewController:vc];
    vc.view.frame = self.view.bounds;
    [self.view addSubview:vc.view];
    [vc willMoveToParentViewController:self];
    
    self.gameViewController = vc;
    self.gameViewController.delegate = self;
    
}



//********************

- (void)embedTableViewControllers{
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    SettingsViewController *settingsTVC = [storyboard instantiateViewControllerWithIdentifier:@"settingsViewController"];
    [self addChildViewController:settingsTVC];
    
    settingsTVC.view.frame = self.leftView.bounds;
    [self.leftView addSubview:settingsTVC.view];
    [settingsTVC willMoveToParentViewController:self];
    
    
    self.highScoreTVC = [storyboard instantiateViewControllerWithIdentifier:@"HighScoresTableViewController"];
    [self addChildViewController:self.highScoreTVC];
    
    self.highScoreTVC.view.frame = self.rightView.bounds;
    [self.rightView addSubview:self.highScoreTVC.view];
    [self.highScoreTVC willMoveToParentViewController:self];
    
}

//************************************

#pragma mark NSNotificationResponses

- (void) prepareToDismiss{
    NSLog(@"calling");
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
