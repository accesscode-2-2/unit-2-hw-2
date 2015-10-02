//
//  venueObject.h
//  hw-week-2
//
//  Created by Jovanny Espinal on 10/2/15.
//  Copyright © 2015 Michael Kavouras. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface venueObject : NSObject

@property (nonatomic) NSString *venueName;
@property (nonatomic) NSString *backgroundImageString;

-(void)backgroundImage:(NSDictionary *)json;
-(void)venueName:(NSDictionary *)json;


@end
