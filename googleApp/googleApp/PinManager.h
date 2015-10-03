//
//  PinManager.h
//  googleApp
//
//  Created by Fatima Zenine Villanueva on 10/2/15.
//  Copyright © 2015 apps. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PinManager : NSObject

@property (nonatomic,strong) NSMutableArray *pinsArray;

+ (PinManager *) sharedManager;


@end
