//
//  HighScoresModel.m
//  ColorTimer
//
//  Created by Varindra Hart on 8/17/15.
//  Copyright © 2015 Varindra Hart. All rights reserved.
//

#import "HighScoresModel.h"

@implementation HighScoresModel

+ (HighScoresModel *)sharedModel {
    static HighScoresModel *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
        sharedMyManager.highStreakData = [[NSMutableArray alloc] initWithArray:[[NSUserDefaults standardUserDefaults]objectForKey:@"high streaks"] copyItems:YES];
        sharedMyManager.highScoreData = [[NSMutableArray alloc]initWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"high scores"]copyItems:YES];
      
    });
    return sharedMyManager;
}

- (int)isNewStreak:(NSString *)streak{
    
    NSMutableArray * keys = [[NSMutableArray alloc] init];
    for (NSDictionary *dictionary in self.highStreakData){
        [keys addObject:[dictionary allKeys][0]];
    }
    
    int counter = 0;
    for(NSString *streakKey in keys){
        if ([streak integerValue]>[streakKey integerValue]) {
            return counter;
        }
        counter++;
    }
    
    return -1;
}

- (void)addStreak:(NSString *)streak forUser:(NSString *)userName{
    
    int rank = [self isNewStreak:streak];
    
    NSDictionary *newEntry = @{streak:userName};
    
    [self.highStreakData insertObject:newEntry atIndex:rank];
    [self.highStreakData removeObject:[self.highStreakData lastObject]];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"high streaks"];
    [[NSUserDefaults standardUserDefaults] setObject:self.highStreakData forKey:@"high streaks"];
    
}
@end
