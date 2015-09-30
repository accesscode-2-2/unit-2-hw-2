//
//  FourSquareAPIManager.h
//  hw-week-2
//
//  Created by Shena Yoshida on 9/30/15.
//  Copyright © 2015 Michael Kavouras. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface FourSquareAPIManager : NSObject

+ (void)searchFoursquarePlacesForTerm:(NSString *)term
                             location:(CLLocationCoordinate2D)location
                    completionHandler:(void(^)(id response, NSError *error))handler;

@end
