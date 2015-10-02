//
//  venueObject.m
//  hw-week-2
//
//  Created by Jovanny Espinal on 10/2/15.
//  Copyright © 2015 Michael Kavouras. All rights reserved.
//

#import "venueObject.h"

@implementation venueObject

-(void)backgroundImage:(NSDictionary *)json {
    self.backgroundImageString = json[@"images"][@"standard_resolution"][@"url"];
}

-(void)venueName:(NSDictionary *)json{
    
    self.venueName = json[@"name"];
}

@end
