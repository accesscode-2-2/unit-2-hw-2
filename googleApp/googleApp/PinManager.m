//
//  PinManager.m
//  googleApp
//
//  Created by Fatima Zenine Villanueva on 10/2/15.
//  Copyright © 2015 apps. All rights reserved.
//

#import "PinManager.h"

@implementation PinManager

@synthesize pinsArray;

+ (PinManager *) sharedManager{
    static PinManager *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
        sharedMyManager.pinsArray = [[NSMutableArray alloc] init];
    });
    return sharedMyManager;
}

@end
