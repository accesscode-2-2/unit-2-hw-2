//
//  InstagramPostTableViewCell.h
//  CustomTableViewCells
//
//  Created by Michael Kavouras on 9/24/15.
//  Copyright © 2015 Mike Kavouras. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InstagramPostTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *commentsLabel;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *likeCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *tagCountLabel;
@property (weak, nonatomic) IBOutlet UIImageView *userMediaImageView;

@end




