//
//  VenueCell.h
//  hw-week-2
//
//  Created by Brian Blanco on 10/3/15.
//  Copyright © 2015 Brian Blanco. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VenueCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UILabel *distanceLabel;
@property (nonatomic, weak) IBOutlet UILabel *checkinsLabel;

@end
