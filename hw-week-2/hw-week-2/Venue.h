//
//  Venue.h
//  hw-week-2
//
//  Created by Brian Blanco on 10/3/15.
//  Copyright © 2015 Brian Blanco. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Location;
@class Stats;

@interface Venue : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) Location *location;
@property (nonatomic, strong) Stats *stats;

@end
