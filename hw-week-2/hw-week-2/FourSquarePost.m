//
//  FourSquarePost.m
//  hw-week-2
//
//  Created by Shena Yoshida on 9/30/15.
//  Copyright © 2015 Michael Kavouras. All rights reserved.
//

#import "FourSquarePost.h"

@implementation FourSquarePost

- (instancetype)initWithJSON:(NSDictionary *)json {
    
    if (self = [super init]) {
//        self.venues = [[json objectForKey:@"response"] objectForKey:@"venues"]; // pull venues from dictionary
//        NSLog(@"%@", self.venues); // does it work?
        
        self.restaurantName = [json objectForKey:@"name"];
        
        // set address and distance properties here
        
        return self;
    }
    return nil;
}

@end
