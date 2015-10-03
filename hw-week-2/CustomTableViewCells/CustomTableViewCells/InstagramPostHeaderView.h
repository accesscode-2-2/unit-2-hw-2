//
//  InstagramPostHeaderView.h
//  CustomTableViewCells
//
//  Created by Michael Kavouras on 9/26/15.
//  Copyright © 2015 Mike Kavouras. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InstagramPostHeaderView : UITableViewHeaderFooterView

@property (weak, nonatomic) IBOutlet UILabel *timestampLabel;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *fullNameLabel;

@end
