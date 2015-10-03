//
//  GamePlayViewController.m
//  ColorTimer
//
//  Created by Varindra Hart on 8/15/15.
//  Copyright (c) 2015 Varindra Hart. All rights reserved.
//

#import "GamePlayViewController.h"
#import "HighScoresModel.h"
#import "HDNotificationView.h"

NSTimeInterval const GameTimerInteval = 0.01f;

//typedef NS_ENUM(NSInteger, QuestionColor) {
//    Green = 0,
//    Red,
//    Blue,
//};

@interface GamePlayViewController () <UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (nonatomic) NSMutableArray *colorsArray;
@property (weak, nonatomic) IBOutlet UIView *currentColorView;
@property (nonatomic, strong) IBOutletCollection(UIButton) NSArray *arrayOfButtons;

@property (weak, nonatomic) IBOutlet UIButton *startButton;

@property (weak, nonatomic) IBOutlet UILabel *streakLabel;
@property (nonatomic) float timerValue;
@property (nonatomic) NSInteger score;
@property (nonatomic) NSInteger streak;

@property (nonatomic) NSTimer *gameTimer;
@property (nonatomic) UIColor *currentColor;

@end

@implementation GamePlayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.colorsArray = [NSMutableArray new];
    
    [self.colorsArray addObject:[UIColor blackColor]];
    [self.colorsArray addObject:[UIColor orangeColor]];
    [self.colorsArray addObject:[UIColor cyanColor]];
    [self.colorsArray addObject:[UIColor brownColor]];
    [self.colorsArray addObject:[UIColor purpleColor]];
    [self.colorsArray addObject:[UIColor magentaColor]];
    [self.colorsArray addObject:[UIColor redColor]];
    [self.colorsArray addObject:[UIColor yellowColor]];
    
    [self disableButtons];
    
    
    //CREATE AND ADD SWIPE GESTURES
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeRecognized:)];
    swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:swipeLeft];
    
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeRecognized:)];
    swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swipeRight];
    
    [self addShadow];
    
}


//*******************************************************

//Methods that will set up the game screen. Sets up in particular the score, questions, and button colors

- (void)reset {
    self.score = 0;
    self.streak = 0;
    self.timerValue = 1.0;
    [self nextQuestion];
}

- (void)nextQuestion {
    [self setNextColor];
    [self resetTimer];
}

- (void)disableButtons{
    for(UIButton *b in self.arrayOfButtons){
        b.enabled=NO;
    }
}

//*********************** Partitioned for organizational purposes

- (void)setButtonColors{
    
    NSMutableArray *tempColorsArray = [NSMutableArray new];
    for (int i = 0; i<2; i++) {
        while (YES) {
            NSInteger idxForColor = arc4random_uniform(self.colorsArray.count);
            
            UIColor *color =  [self.colorsArray objectAtIndex:idxForColor];
            
            if (color != self.currentColor) {
                BOOL hasColor = NO;
                for (UIColor *c in tempColorsArray) {
                    if(c == color){
                        hasColor=YES;
                        break;
                    }
                }
                if(!hasColor){
                    [tempColorsArray addObject:color];
                    break;
                }
                else{
                    continue;
                }
            }
            
        }
    }
    
    [tempColorsArray insertObject:self.currentColor atIndex:arc4random_uniform(3)];
    NSInteger indexOfColor = 0;
    for(UIButton *b in self.arrayOfButtons){
        b.backgroundColor = tempColorsArray[indexOfColor];
        indexOfColor++;
    }
    
}

//**********************************************************



//EXECUTED BY TIMER TO DECREASE THE GAME's TIMER DISPLAYED TO THE USER
- (void)decreaseTimer{
    self.timerValue -=.01;
    self.timeLabel.text = [NSString stringWithFormat:@"%.2f",self.timerValue];
    if (self.timerValue<=0.01) {
        [self gameOver];
    }
    
}
//**********************************************************



//GAME OVER METHODS, CANCELES TIMER AND CALLS ALL RESET METHODS
- (void)gameOver {
    
    [self cancelTimer];
    [self disableButtons];
    self.startButton.enabled = YES;
    
    [self checkForNewStreak];
    
    
    //DELEGATE METHOD TRIGGERED
    [self.delegate viewController:self startButtonEnabled:self.startButton.enabled];
}

- (void)checkForNewStreak{
    int rank = [[HighScoresModel sharedModel] isNewStreak:[NSString stringWithFormat:@"%lu",self.streak]];
    if(rank > -1){
        UIAlertView *alertViewChangeName=[[UIAlertView alloc]initWithTitle:@"NEW HIGH STREAK!" message:[NSString stringWithFormat:@"Streak rank: #%d",rank+1] delegate:self cancelButtonTitle:@"..Meh" otherButtonTitles:@"Add Me!",nil];
        alertViewChangeName.alertViewStyle=UIAlertViewStylePlainTextInput;
        [alertViewChangeName show];
    }
    
    else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"GAME OVER!" message:@"You are bad at this..." delegate:nil cancelButtonTitle:@"womp womp" otherButtonTitles:nil];
        
        [alert show];
    }
    
}

- (void)cancelTimer {
    [self.gameTimer invalidate];
}

//********************************************************


//USER SELECTS AN ANSWER (COLOR BUTTON)

- (IBAction)colorButtonTapped:(UIButton*)sender {
    if (sender.backgroundColor == self.currentColorView.backgroundColor) {
        [self incrementScore];
        [self increaseStreak];
        [self nextQuestion];
    }
    
    else {
        [self gameOver];
        [self disableButtons];
    }
}

//*******************************************


//GAME BEGINS

- (IBAction)startGameButton:(UIButton *)sender {
    sender.enabled = NO;
    for(UIButton *b in self.arrayOfButtons){
        b.enabled=YES;
//        b.layer.trasform
    }
    [self reset];
    
    //DELEGATE METHOD TRIGGERED
    [self.delegate viewController:self startButtonEnabled:sender.enabled];
}
//********************************************

//METHODS THAT WILL EXECUTE WHEN A QUESTION IS ANSWERED CORRECTLY
//SCORE, STREAK, COLOR OF BUTTONS AND UIVIEW, AND TIMER ARE UPDATED ACCORDINGLY

- (void)incrementScore {
    self.score+=ceil([self.timeLabel.text floatValue]*10);
    self.scoreLabel.text = [NSString stringWithFormat:@"SCORE: %ld",self.score];
    NSLog(@"%lu", self.score);
}


- (void)increaseStreak {
    self.streak++;
    self.streakLabel.text = [NSString stringWithFormat:@"STREAK: %ld",self.streak];
}

- (void)resetTimer {
    [self cancelTimer];
    self.timerValue = 1.0;
    self.gameTimer = [NSTimer timerWithTimeInterval:GameTimerInteval target:self selector:@selector(decreaseTimer) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.gameTimer forMode:NSRunLoopCommonModes];
}

//*************************

- (void)setNextColor {
    UIColor *realColor;
    while (YES) {
        
        
        NSInteger nextColor = arc4random_uniform(self.colorsArray.count);
        
        realColor =  [self.colorsArray objectAtIndex:nextColor];
        
        if (realColor==self.currentColor) {
            continue;
        }
        else{
            break;
        }
    }
    self.currentColor = realColor;
    self.currentColorView.backgroundColor = realColor;
    [self setButtonColors];
    
}
//************************************************************************

//DELEGATE METHODS

-(void) swipeRecognized:(UISwipeGestureRecognizer *)swipe{
    [self.delegate viewController:self swipeGesture:swipe];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    NSString *userName = [[alertView textFieldAtIndex:0] text];
    [[HighScoresModel sharedModel] addStreak:[NSString stringWithFormat:@"%lu",self.streak] forUser:userName];
    [self.delegate viewController:self newScoreAdded:YES];
    [HDNotificationView showNotificationViewWithImage:[UIImage imageNamed:@"welcomeToTheLeaderBoard"] title:@"Crushing It!" message:@"The leaderboard recognizes your skill"];
}

#pragma mark Add a Shadow

- (void)addShadow{
    
    [self.view.layer setCornerRadius:0];
    [self.view.layer setShadowColor:[UIColor blackColor].CGColor];
    [self.view.layer setShadowOpacity:0.8];
    [self.view.layer setShadowOffset:CGSizeMake(0,2.5)];
    
}

@end