//
//  ViewController.h
//  ColorTimer
//
//  Created by Varindra Hart on 8/15/15.
//  Copyright (c) 2015 Varindra Hart. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GamePlayViewControllerDelegate.h"

@interface GamePlayViewController : UIViewController

@property (weak,nonatomic) id<GamePlayViewControllerDelegate> delegate;

- (void) swipeRecognized:(UISwipeGestureRecognizer *)swipe;
@end

