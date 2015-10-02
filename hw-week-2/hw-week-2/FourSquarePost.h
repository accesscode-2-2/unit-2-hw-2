//
//  FourSquarePost.h
//  hw-week-2
//
//  Created by Shena Yoshida on 9/30/15.
//  Copyright © 2015 Michael Kavouras. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FourSquarePost : NSObject

@property (nonatomic) NSString *restaurantName;
@property (nonatomic) NSString *restaurantAddress;
@property (nonatomic) NSString *restaurantDistance;
@property (nonatomic) NSArray *venues; 

- (instancetype)initWithJSON:(NSDictionary *)json; // custom init

@end
